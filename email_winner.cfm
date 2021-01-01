<!--- Start of Email to the BIG Winner --->
<cftry>
<cfset variables.current_email = "email_winner.cfm">

<!-- Make sure to escape hash (##) -->
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
<cfset variables.email_preheader_text = "You're a winner! Open to find out about your winning raffle ticket.">
<cfset variables.email_sent_to = variables.winner_email>
<cfmail
            to = "cavaliersraffle@olosa.org"
            bcc = "#variables.winner_email#, cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = "CavaliersRaffle.com #variables.email_raffle_month_year#"
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74"> 
Congratulations #variables.winner_first# #variables.winner_last_full#   
   
You were the big $200 winner this month. Your check will be mailed to the address you provided when you enrolled. Thank you for supporting our school through your participation in the raffle.   
   
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
                        Congratulations #variables.winner_first# #variables.winner_last_full#
                    </h1>
                    <p>
                        You are the big $200 winner this month. Your check will be mailed to the address you provided when you enrolled. Thank you for supporting our school through your participation in the raffle.
                    </p>
                </td>
            </tr>
            <tr>
                <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
    <cfinclude template="email_msg_winners.cfm">
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
