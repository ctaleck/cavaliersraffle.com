<!--- 
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where id in (130,131,132)
</cfquery>
 --->




<!--- 
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_pool#
	 where 1=1
</cfquery>

<cfset variables.pool = 1>

<cfloop index="i" from="1" to="1000">
    <cfquery name="selUsedNumbers" datasource="#request.datasource#">
        insert into [#variables.str_pool#]                                       
		(raffle_nbr)
        values
        (#variables.pool#)
    </cfquery>

	<cfset variables.pool = variables.pool + 1>
</cfloop>

<cfquery name="sel_numbers" datasource="#request.datasource#">
	select [raffle_nbr] from #variables.str_pool#
	 where 1=1
     order by 1
</cfquery>

<cfoutput query="sel_numbers">
	#sel_numbers.raffle_nbr#
</cfoutput> --->






<!--- Next, get the now updated list of numbers from the current raffle number table  --->
<!--- 
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

<cfoutput>#variables.available_number_list#</cfoutput>
 --->
