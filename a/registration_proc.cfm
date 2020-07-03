<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<cfif form.formValidator NEQ session.formValidator>
            <cflocation url="oops-error.cfm" addtoken="no">
        </cfif>

		<cfif Not Len(form.pb_last_name) OR Not Len(form.pb_first_name)>
            <cfset variables.error_msg = "You must provide both your first and last name!">
        <cfelseif (FindOneOf("~!@$%^&*()?><",form.pb_first_name)) OR (FindOneOf("~!@$%^&*()?><",form.pb_last_name))>
            <cfset variables.error_msg = "You have an invalid character in either your first or last name!">
        </cfif>
        
        <cfif Not Len(form.pb_email) AND Not Len(form.pb_phone) AND Not Len(form.pb_address)>
            <cfset variables.error_msg = "You must provide an email address OR phone number OR mailing address so you can be notified when you win!">
        </cfif>
        
        <cfif Not Len(trim(form.tickets))>
            <cfset variables.error_msg = "You must provide number of Raffle Tickets you are purchasing!">
        </cfif>

		<cfif Len(form.pb_phone)>
        	<cfif form.pb_phone contains "(">
            	<cfset form.pb_phone = Replace(form.pb_phone,"(","","ALL")>
            	<cfset form.pb_phone = Replace(form.pb_phone,") ","-","ALL")>
            </cfif>
        </cfif>
        
        <cfif Len(form.pb_phone)>
            <cfif form.pb_phone contains "-">
                <cfset variables.phone_formatted = form.pb_phone>
            <cfelseif form.pb_phone contains ".">
            	<cfset variables.phone_formatted = Replace(form.pb_phone,".","-","ALL")>
            <cfelseif form.pb_phone contains " ">
            	<cfset variables.phone_formatted = Replace(form.pb_phone," ","-","ALL")>
            <cfelse>
                <cfset variables.phone=form.pb_phone>
                <cfscript>
                    areacode = left(variables.phone, 3);
                    firstthree = mid(variables.phone, 4, 3);
                    lastfour = right(variables.phone, 4);
                </cfscript>
                <cfoutput>
                    <cfset variables.phone_formatted = "#areacode#-#firstthree#-#lastfour#">
                </cfoutput>
            </cfif>
        <cfelse>
            <cfset variables.phone_formatted = "NA">
        </cfif>
        
        <cfif IsDefined("variables.error_msg")>
            <cfoutput>
                <script language="JavaScript1.2">
                    alert("#variables.error_msg#")
                    history.go(-1)   
                </script>
            </cfoutput>
            <cfabort> 
        </cfif>
    </head>
    
    
    <!--- Determine the cost based upon the number of tickets selected times $25 per ticket --->
    <cfset variables.tickets = LSParseNumber(form.tickets)>
    <cfset variables.pb_cost = variables.tickets * 25>
    
    <!--- Get the next incremental pb_donation_id number --->
    <cfquery name="getDonationID" datasource="#request.datasource#">
        select max(pb_donation_id) as 'pb_donation_id'
          from [#variables.str_donation#]
    </cfquery>

    <!--- Get the next incremental Donor ID number --->
    <cfquery name="getID" datasource="#request.datasource#">
        select max(ID) as 'ID'
          from [#variables.str_donor#]
    </cfquery>
    
    <!--- If empty table, set ID to 1 ---> 
    <cfif NOT Len(getDonationID.pb_donation_id)>
        <cfset variables.next_donation_ID = 1>
    <cfelse>
        <cfset variables.next_donation_ID = getDonationID.pb_donation_id + 1>
    </cfif>

    <!--- If empty table, set ID to 1 ---> 
    <cfif NOT Len(getID.ID)>
        <cfset variables.new_ID = 1>
    <cfelse>
        <cfset variables.new_ID = getID.ID + 1>
    </cfif>
    
    <cfif Len(form.pb_info_source)>
    	<cfset variables.source = form.pb_info_source>
    <cfelse>
    	<cfset variables.source = "None">
    </cfif>
    
    <cfif Len(form.pb_email)>
    	<cfset variables.email = form.pb_email>
    <cfelse>
    	<cfset variables.email = "NotProvided@piggybackraffle.org">
    </cfif>
    
    <!--- Get the "Current" month and year --->
    <cfset variables.current_date = #DateFormat(now(), "mm/yyyy")#>
    <cfset variables.current_month = Left(variables.current_date,2)>
    <cfset variables.current_year = Right(variables.current_date,4)>
    
    <!--- Using the "current" month and year from above, determine the start and end months and years. --->
    <cfif variables.current_month LT 12>
        <cfset variables.start_month = variables.current_month + 1>
        <cfset variables.start_year = variables.current_year>
        <cfset variables.end_month = variables.current_month>
        <cfset variables.end_year = variables.current_year + 1>
    <cfelse>
        <cfset variables.start_month = 01>	    
        <cfset variables.start_year = variables.current_year + 1>
        <cfset variables.end_month = variables.current_month>
        <cfset variables.end_year = variables.current_year + 1>
    </cfif>

	<!--- 
        The process is that the drawing date will be the first Friday of the month, except when that first Friday is the first ex: 09/01/2018
        In that case, it would be the NEXT Friday.
    --->
    <cfset variables.start_day = 01>
    
    <cfset variables.start_yourDate = CreateDate(variables.start_year, variables.start_month, variables.start_day)> 

    <cfif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Monday">
        <cfset variables.start_NextFriday = variables.start_day + 4>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Tuesday">
        <cfset variables.start_NextFriday = variables.start_day + 3>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Wednesday">
        <cfset variables.start_NextFriday = variables.start_day + 2>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Thursday">
        <cfset variables.start_NextFriday = variables.start_day>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Friday">
        <cfset variables.start_NextFriday = variables.start_day + 0>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Saturday">
        <cfset variables.start_NextFriday = variables.start_day + 6>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Sunday">
        <cfset variables.start_NextFriday = variables.start_day + 5>
    </cfif>

    <cfset variables.start_NextDate = dateformat(variables.start_month & "/" & variables.start_NextFriday & "/" & variables.start_year,"mm/dd/yyyy")>
   <!---  #variables.start_NextDate# --->


    <!--- 
        The process is that the drawing date will be the first Friday of the month, except when that first Friday is the first ex: 09/01/2018
        In that case, it would be the NEXT Friday.
    --->
    <cfset variables.end_day = 01>
    
    <cfset variables.end_yourDate = CreateDate(variables.end_year, variables.end_month, variables.end_day)> 

    <cfif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Monday">
        <cfset variables.end_NextFriday = variables.end_day + 4>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Tuesday">
        <cfset variables.end_NextFriday = variables.end_day + 3>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Wednesday">
        <cfset variables.end_NextFriday = variables.end_day + 2>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Thursday">
        <cfset variables.end_NextFriday = variables.end_day + 1>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Friday">
        <cfset variables.end_NextFriday = variables.end_day>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Saturday">
        <cfset variables.end_NextFriday = variables.end_day + 6>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Sunday">
        <cfset variables.end_NextFriday = variables.end_day + 5>
    </cfif>

    <cfset variables.end_NextDate = dateformat(variables.end_month & "/" & variables.end_NextFriday & "/" & variables.end_year,"mm/dd/yyyy")>
    <!--- #variables.end_NextDate# --->

	<!--- Check to see if a record with this ID, etc. is already in the "term" table.  If so, it's a dup we're trying to insert so skip it. --->
	<cfquery name="selDups" datasource="#request.datasource#">
    	select * 
          from #variables.str_term#
         where id = <cfqueryparam value="#variables.new_ID#" cfsqltype="cf_sql_integer">
           and pb_donation_id = <cfqueryparam value="#variables.next_donation_ID#" cfsqltype="cf_sql_integer">
           and pb_start_date = <cfqueryparam value="#variables.start_NextDate#" cfsqltype="cf_sql_varchar">
           and pb_end_date = <cfqueryparam value="#variables.end_NextDate#" cfsqltype="cf_sql_varchar">
    </cfquery>
	
    <!--- Some variables may not be upper cased or may be totally UPPER CASED by the user submitting the form.  Take care of it for them. --->
	<!--- First, set everything to lower case... --->
	<cfset variables.pb_last_name = LCase(form.pb_last_name)>
	<cfset variables.pb_first_name = LCase(form.pb_first_name)>
	<cfset variables.pb_city = LCase(form.pb_city)>
	<cfset variables.source = LCase(variables.source)>
	<cfset variables.pb_address = LCase(form.pb_address)>
	
    <!--- Next, Upper Case the first letter of any/all words. --->
	<cfset variables.pb_last_name = ReReplace(variables.pb_last_name ,"(^[a-z]|\s+[a-z])","\U\1","ALL")>
	<cfset variables.pb_first_name = ReReplace(variables.pb_first_name ,"(^[a-z]|\s+[a-z])","\U\1","ALL")>
	<cfset variables.pb_city = ReReplace(variables.pb_city ,"(^[a-z]|\s+[a-z])","\U\1","ALL")>
	<cfset variables.pb_address = ReReplace(variables.pb_address ,"(^[a-z]|\s+[a-z])","\U\1","ALL")>
	<cfset variables.source = ReReplace(variables.source ,"(^[a-z]|\s+[a-z])","\U\1","ALL")>
    
	<cfif selDups.RecordCount is 0>
        <cftransaction>
            <cfquery name="insDonor" datasource="#request.datasource#">
                insert into [#variables.str_donor#]
                       (ID,
                       pb_last_name,
                       pb_first_name,
                       pb_email,
                       pb_phone,
                       pb_address,
                       pb_city,
                       pb_state,
                       pb_zipcode,
                       pb_active,
                       pb_gift,
                       pb_info_source
                       )
               values (<cfqueryparam value="#variables.new_ID#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.pb_last_name#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.pb_first_name#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.email#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.phone_formatted#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.pb_address#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.pb_city#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#form.pb_state#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#form.pb_zipcode#" cfsqltype="cf_sql_varchar">,
                       <cfqueryparam value="N" cfsqltype="cf_sql_varchar">,
                       <cfif IsDefined("form.pb_gift")>
                            <cfqueryparam value="Y" cfsqltype="cf_sql_varchar">,
                       <cfelse>
                            <cfqueryparam value="N" cfsqltype="cf_sql_varchar">,
                       </cfif>
                       <cfqueryparam value="#variables.source#" cfsqltype="cf_sql_varchar">
                       )
            </cfquery> 

            <cfquery name="insAmount" datasource="#request.datasource#">
                insert into [#variables.str_donation#]
                       (ID,
                       pb_donation_id,
                       pb_donation,
                       pb_ticket_number,
                       pb_payment_verified
                       )
               values (<cfqueryparam value="#variables.new_ID#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.next_donation_ID#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.pb_cost#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.tickets#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="N" cfsqltype="cf_sql_varchar">
                       )
            </cfquery>
        
            <cfquery name="insDates" datasource="#request.datasource#">
                insert into [#variables.str_term#]
                       (ID,
                       pb_donation_id,
                       pb_start_date,
                       pb_end_date
                       )
               values (<cfqueryparam value="#variables.new_ID#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.next_donation_ID#" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#variables.start_NextDate#" cfsqltype="cf_sql_varchar">, 
                       <cfqueryparam value="#variables.end_NextDate#" cfsqltype="cf_sql_varchar">
                       )
            </cfquery>
            
            <cfif IsDefined("form.pb_gift")>
                <cfquery name="insFamily" datasource="#request.datasource#">
                    insert into [#variables.str_family#]
                           (ID,
                           pb_donation_id,
                           pb_qhra_family_name,
                           pb_qhra_family_email
                           )
                   values (<cfqueryparam value="#variables.new_ID#" cfsqltype="cf_sql_integer">,
                           <cfqueryparam value="#variables.next_donation_ID#" cfsqltype="cf_sql_integer">,
                           <cfqueryparam value="#form.pb_qhra_family_name#" cfsqltype="cf_sql_varchar">,
                           <cfqueryparam value="#form.pb_qhra_family_email#" cfsqltype="cf_sql_varchar">
                           )
                </cfquery> 
            </cfif>
        </cftransaction>

		<!--- Set both a session variable and web cookie with the ID number of the golfer --->
        <!--- We'll use this information later after payment is received. --->
        <cfset session.Donor_ID = variables.new_ID>
        <cfcookie name="Donor_ID" secure="yes" value="#variables.new_ID#" httponly="yes" encodevalue="yes">
	</cfif>

<cflocation url="goto_paypal.cfm?tickets=#URLEncodedFormat(variables.tickets)#" addtoken="no">