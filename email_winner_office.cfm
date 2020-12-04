<!--- Start of email to the non-winners 5 --->
<cftry>

<cfif isDefined("Url.Test")>
    <cfset variables.raffle_winner_state = "UT">
    <cfset variables.raffle_winner_before_state = "TX">
    <cfset variables.raffle_winner_after_state = "VA">

    <cfset variables.raffle_winner = 11>
    <cfset variables.raffle_winner_before = 10>
    <cfset variables.raffle_winner_after = 12>

    <cfset variables.winner_email = "chris@taleck.com">
    <cfset variables.winner_before_email = "chris@taleck.com">
    <cfset variables.winner_after_email = "chris@taleck.com">

    <cfset variables.winner_first = "Ulysses">
    <cfset variables.winner_before_first = "Timothy">
    <cfset variables.winner_after_first = "Victoria">
    
    <cfset variables.winner_last = Left("Winner",1)>
    <cfset variables.winner_last_full = "Winner">
    <cfset variables.winner_before_last = Left("Before",1)>
    <cfset variables.winner_before_last_full = "Before">
    <cfset variables.winner_after_last = Left("After",1)>
    <cfset variables.winner_after_last_full = "After">

    <cfset variables.nonWinningEmailList1 = "chris@taleck.com">
    <cfset variables.nonWinningEmailList2 = "chris@taleck.com">
    <cfset variables.nonWinningEmailList3 = "chris@taleck.com">
    <cfset variables.nonWinningEmailList4 = "chris@taleck.com">
    <cfset variables.nonWinningEmailList5 = "chris@taleck.com">

    <cfquery name="selGetDonors" datasource="#request.datasource#">
        select [id], [raffle_nbr]
            from #variables.str_raffle#
            where raffle_nbr in (<cfqueryparam value="#variables.raffle_winner#" cfsqltype="cf_sql_integer">, <cfqueryparam value="#variables.raffle_winner_before#" cfsqltype="cf_sql_integer">, <cfqueryparam value="#variables.raffle_winner_after#" cfsqltype="cf_sql_integer">)
            order by 1
    </cfquery>
    
    <!--- Set the winning ID's to a list --->
    <cfset variables.winner_list = "">
    <cfloop query="selGetDonors">
        <cfset variables.winner_list = ListAppend(variables.winner_list,selGetDonors.ID)>
    </cfloop>

        <!--- Get the full contact info for all three winners --->
    <cfquery name="selWinningDonorInfo" datasource="#request.datasource#">
        select a.[ID], 
                a.[pb_last_name], 
                a.[pb_first_name], 
                a.[pb_email], 
                a.[pb_phone], 
                a.[pb_address], 
                a.[pb_city], 
                a.[pb_state], 
                a.[pb_zipcode], 
                a.[pb_info_source],
                a.[pb_gift],
                b.[raffle_nbr]
            from #variables.str_donor# as a
            inner join #variables.str_raffle# as b on a.id = b.id
            where a.ID in (#variables.winner_list#)
        order by 1
    </cfquery> 
</cfif>

    <!--- Get the full spelling of the winner's home states --->
<cfquery name="selStateNames" datasource="#request.datasource#">
    select [abbrev], [state_name]
        from #variables.str_states#
        order by 1
</cfquery>

<cfquery name="qry_qry_before_state" dbtype="query">
    select distinct state_name
        from selStateNames
        where abbrev = '#variables.raffle_winner_before_state#'
</cfquery>

<cfquery name="qry_qry_winner_state" dbtype="query">
    select distinct state_name
        from selStateNames
        where abbrev = '#variables.raffle_winner_state#'
</cfquery>

<cfquery name="qry_qry_after_state" dbtype="query">
    select distinct state_name
        from selStateNames
        where abbrev = '#variables.raffle_winner_after_state#'
</cfquery>

<cfset variables.email_raffle_month_year = DateFormat(now(), "mmmm yyyy")>
<cfset variables.email_preheader_text = "Open to find out about this months's raffle ticket winners.">
<cfset variables.email_sent_to = "">
<cfmail
            to = "treasurer@olosa.org"
            bcc = "cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = "CavalierRaffle.com #variables.email_raffle_month_year#"
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74"> 
Office notification to our #variables.email_raffle_month_year# raffle winners   
   
Please use this information to mail out checks to the the winners. All raffle participants have received an email notified if they have won.    
   
Please note: If the numbers immediately before or after the winning number are not assigned, the prize is awarded to the next assigned number in that direction.   
   
$50   
#variables.raffle_winner_before#   
#variables.winner_before_first# #variables.winner_before_last_full#   
#qry_qry_before_state.state_name#   
   
$200   
#variables.raffle_winner#   
#variables.winner_first# #variables.winner_last_full#   
#qry_qry_winner_state.state_name#   
   
$50   
#variables.raffle_winner_after#   
#variables.winner_after_first# #variables.winner_after_last_full#   
#qry_qry_after_state.state_name#   
   
<cfif Len(variables.email_sent_to) gt 0>
This email was sent to #variables.email_sent_to# from cavaliersraffle@olosa.org.   
</cfif>
   
#variables.email_spam_text#   
   
#variables.email_address_text#   
   
#variables.email_exempt_text#   
   
</cfmailpart> 
<cfmailpart type="html">
    <cfinclude template="email_msg_header.cfm">
    <!-- Email Body Content Sample : BEGIN -->
        <table cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
                    <h1 style="margin: 0 0 10px 0; font-family: sans-serif; font-size: 25px; line-height: 30px; color: ##333333; font-weight: normal;">
                        Office notification to our #variables.email_raffle_month_year# raffle winners
                    </h1>
                    <p>
                        Please use this information to mail out checks to the the winners. All raffle participants have received an email notified if they have won. 
                    </p>
                    <p>
                        Please note: If the numbers immediately before or after the winning number are not assigned, the prize is awarded to the next assigned number in that direction.
                    </p>
                </td>
            </tr>
            <tr>
                <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
                    <table border="1" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <th align="center">$200 Raffle Winner</th>
                            <th align="center">$50 Piggyback (before)</th>
                            <th align="center">$50 Piggyback (after)</th>
                        </tr>
                        <tr>
                            <!--- ********** Output the Winner's Information  *********** --->
                            <cfquery name="qry_qry_winner" dbtype="query">
                                select distinct id, pb_last_name, pb_first_name, pb_email, pb_address, pb_city, pb_state, pb_zipcode, pb_phone
                                from selWinningDonorInfo
                                where raffle_nbr = #variables.raffle_winner#
                            </cfquery>
                        
                            <cfset variables.winner_name = "#qry_qry_winner.pb_first_name# #qry_qry_winner.pb_last_name#">
                            <td align="center">
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td align="center">
                                            #variables.winner_name# (#variables.raffle_winner#)<br />
                                            <cfif Len(qry_qry_winner.pb_address)>
                                                #qry_qry_winner.pb_address#<br />
                                                #qry_qry_winner.pb_city#, #qry_qry_winner.pb_state# #qry_qry_winner.pb_zipcode#
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">Email: #qry_qry_winner.pb_email#</td>
                                    </tr>
                                    <tr>
                                        <td align="left">Phone: #qry_qry_winner.pb_phone#&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                            
                            <!--- ********** Output the "Before" Winner's Information  *********** --->
                            <cfquery name="qry_qry_winner_before" dbtype="query">
                                select distinct id, pb_last_name, pb_first_name, pb_email, pb_address, pb_city, pb_state, pb_zipcode, pb_phone
                                from selWinningDonorInfo
                                where raffle_nbr = #variables.raffle_winner_before#
                            </cfquery>
                            
                            <cfset variables.winner_name_before = "#qry_qry_winner_before.pb_first_name# #qry_qry_winner_before.pb_last_name#">
                            <td align="center"><!--- #variables.winner_name_before# (#variables.winner_before#)<br />Donor ID = #qry_qry_winner_before.id# --->
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td align="center">
                                            #variables.winner_name_before# (#variables.raffle_winner_before#)<br />
                                            <cfif Len(qry_qry_winner_before.pb_address)>
                                                #qry_qry_winner_before.pb_address#<br />
                                                #qry_qry_winner_before.pb_city#, #qry_qry_winner_before.pb_state# #qry_qry_winner_before.pb_zipcode#
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">Email: #qry_qry_winner_before.pb_email#</td>
                                    </tr>
                                    <tr>
                                        <td align="left">Phone: #qry_qry_winner_before.pb_phone#&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                
                            <!--- ********** Output the "After" Winner's Information  *********** --->
                            <cfquery name="qry_qry_winner_after" dbtype="query">
                                select distinct id, pb_last_name, pb_first_name, pb_email, pb_address, pb_city, pb_state, pb_zipcode, pb_phone
                                from selWinningDonorInfo
                                where raffle_nbr = #variables.raffle_winner_after#
                            </cfquery>
                            
                            <cfset variables.winner_name_after = "#qry_qry_winner_after.pb_first_name# #qry_qry_winner_after.pb_last_name#">
                            <td align="center"><!--- #variables.winner_name_after# (#variables.winner_after#)<br />Donor ID = #qry_qry_winner_after.id# --->
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td align="center">
                                            #variables.winner_name_after# (#variables.raffle_winner_after#)<br />
                                            <cfif Len(qry_qry_winner_after.pb_address)>
                                                #qry_qry_winner_after.pb_address#<br />
                                                #qry_qry_winner_after.pb_city#, #qry_qry_winner_after.pb_state# #qry_qry_winner_after.pb_zipcode#
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">Email: #qry_qry_winner_after.pb_email#</td>
                                    </tr>
                                    <tr>
                                        <td align="left">Phone: #qry_qry_winner_after.pb_phone#&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            <td style="padding: 20px;">
                <table align="center" cellspacing="0" cellpadding="0" border="0" style="margin: auto;">
                    <tr>
                        <td class="button-td button-td-primary" style="border-radius: 4px; background: ##35355A;">
                                <a class="button-a button-a-primary" href="#variables.email_web_address#" style="background: ##b81413; border: 1px solid ##b81413; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; color: ##ffffff; display: block; border-radius: 4px;">CavaliersRaffle.com</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
    <!-- Email Body Content Sample : END -->
    
    <cfinclude template="email_msg_footer.cfm">
</cfmailpart>
</cfmail>

    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>
