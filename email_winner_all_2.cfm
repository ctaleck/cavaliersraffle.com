<!--- Start of email to the non-winners 2 --->
<cftry>

<cfif isDefined("Url.Test")>
    <cfset variables.raffle_winner_state = "UT">
    <cfset variables.raffle_winner_before_state = "TX">
    <cfset variables.raffle_winner_after_state = "VA">

    <cfset variables.raffle_winner = "11">
    <cfset variables.raffle_winner_before = "10">
    <cfset variables.raffle_winner_after = "12">

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
            to = "cavaliersraffle@olosa.org"
            bcc = "#variables.nonWinningEmailList2#, cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = "CavalierRaffle.com #variables.email_raffle_month_year#"
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74"> 
Congratulations to our #variables.email_raffle_month_year# raffle winners   
   
Thank you for supporting our school through your participation in the raffle. Watch out for next month's drawing.   
   
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
                        Congratulations to our #variables.email_raffle_month_year# raffle winners
                    </h1>
                    <p>
                        Thank you for supporting our school through your participation in the raffle. Watch out for next month's drawing.
                    </p>
                    <p>
                        Please note: If the numbers immediately before or after the winning number are not assigned, the prize is awarded to the next assigned number in that direction.
                    </p>
                </td>
            </tr>
            <tr>
                <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" width="33%"  style="border: 1px dotted ##555555; padding: 20px; margin: 0; height: 100%;">
                                <div>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$50</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner_before#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_before_first# #variables.winner_before_last_full#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_before_state.state_name#</p>
                                </div>
                            </td>
                            <td width="20px"></td>
                            <td align="center" width="33%"  style="border: 1px dotted ##555555; padding: 20px; margin: 0; height: 100%;">
                                <div>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$200</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_first# #variables.winner_last_full#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_winner_state.state_name#</p>
                                </div>
                           </td>
                            <td width="20px"></td>
                            <td align="center" width="33%" style="border: 1px dotted ##555555; padding: 20px; margin: 0; height: 100%;">
                                <div>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$50</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner_after#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_after_first# #variables.winner_after_last_full#</p>
                                    <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_after_state.state_name#</p>
                                </div>
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
