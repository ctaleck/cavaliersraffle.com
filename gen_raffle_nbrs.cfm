<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfif IsDefined("url.ID")>
	<cfset variables.ID = url.id>
<cfelseif IsDefined("form.ID")>
	<cfset variables.ID = form.id>
</cfif>

<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>

<!--- First, get info on the donor so we can get the quantity of raffle tickets needed --->
<cfquery name="selCurrentDonors" datasource="#request.datasource#">
	select a.[ID],
           a.[pb_email] as email, 
		   b.[pb_ticket_number], 
		   b.[pb_payment_verified],
           b.[pb_donation_id],
           convert(varchar(10), c.[pb_start_date], 101) as start_date,
           convert(varchar(10), c.[pb_end_date], 101) as end_date
      from #variables.str_donor# as a 
     inner join #variables.str_donation# as b on a.id = b.id 
     inner join #variables.str_term# as c on b.id = c.id 
	 where a.[ID] = #variables.id#
</cfquery> 

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

<!--- Next, get the now updated list of numbers from the current raffle number table  --->
<cfquery name="selUsedNumbers" datasource="#request.datasource#">
	select [raffle_nbr]                                       
	  from #variables.str_raffle#
	 order by 1
</cfquery>

<!--- Create the empty list --->
<cfset variables.used_number_list = "">

<!--- Loop the Used number query to create a list of Used numbers that we'll eventually "jump over" in the final list --->
<cfloop query="selUsedNumbers">
	<cfset variables.used_number_list = ListAppend(variables.used_number_list, selUsedNumbers.raffle_nbr)>
</cfloop>

<!--- Query the full pool of numbers (1000 total) and omit ones in the "used list". --->
<cfquery name="selPoolNumbers" datasource="#request.datasource#">
	select [raffle_nbr]
	  from #variables.str_pool#
	 where 1=1
	   <cfif Len(variables.used_number_list)>
		   and [raffle_nbr] not in (#variables.used_number_list#)
	   </cfif>
	 order by 1
</cfquery>

<!--- Next, create a new empty list of the actual available numbers we can use for this donor --->
<cfset variables.available_number_list = "">

<!--- Create the list by looping the query --->
<cfloop query="selPoolNumbers">
	<cfset variables.available_number_list = ListAppend(variables.available_number_list, selPoolNumbers.raffle_nbr)>
</cfloop>

<!--- Get the number of tickets the donor bought --->
<cfset variables.count = selCurrentDonors.pb_ticket_number>

<!--- Loop the primary list of "Available" numbers --->
<cfloop list="#variables.available_number_list#" index="i">    
	<!--- Get the first available number --->
	<cfset variables.next_number = ListFirst(variables.available_number_list)>
    <!--- Establish the variable for number position --->
    <cfset variables.position = 1>
    <!--- Keep track of the number of actual inserts.  Need this because of the two loops --->
    <cfset variables.insertcount = 1>

    <cfloop index="j" from="1" to="#variables.count#">
        <cfquery name="insRaffleNumbers" datasource="#request.datasource#">
            insert into [#variables.str_raffle#]
                   (ID,
                   pb_donation_id,
                   raffle_nbr,
                   pb_start_date,
                   pb_end_date
                   )
           values (<cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">,
                   <cfqueryparam value="#selCurrentDonors.pb_donation_id#" cfsqltype="cf_sql_integer">,
                   <cfqueryparam value="#variables.next_number#" cfsqltype="cf_sql_integer">,
                   <cfqueryparam value="#selCurrentDonors.start_date#" cfsqltype="cf_sql_varchar">,
                   <cfqueryparam value="#selCurrentDonors.end_date#" cfsqltype="cf_sql_varchar">
                   )
        </cfquery>

		<cfset variables.position = variables.position + 1>
        <cfset variables.tmp_next_number = variables.next_number>
        <cfset variables.next_number = ListGetAt(variables.available_number_list,variables.position)>
        
        <cfloop from="1" to="3" index="k">
			<cfif variables.next_number - variables.tmp_next_number GTE 3>
            	<cfbreak>
            <cfelse>
            	<cfset variables.position = variables.position + 1>	
                <cfset variables.next_number = ListGetAt(variables.available_number_list,variables.position)>
            </cfif>
        </cfloop>

        <cfset variables.insertcount = variables.insertcount + 1>

    </cfloop>
    	<!--- If the number of inserts is GTE the number of tickets purchased, break out of the primary loop. 
		      It will increment one time more than the number of the "count" variable when all records have processed.		
		--->
		<cfif variables.insertcount GTE variables.count>
            <cfbreak>
        </cfif>    
</cfloop>

<cflocation url="pb_report_details.cfm?ID=#URLEncodedFormat(variables.id)#&pb_donation_id=#URLEncodedFormat(selCurrentDonors.pb_donation_id)#&pb_start_date=#URLEncodedFormat(selCurrentDonors.start_date)#&gen=yes" addtoken="no">
