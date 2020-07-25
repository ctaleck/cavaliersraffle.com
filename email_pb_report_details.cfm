<!-- Make sure to escape hash (##) -->
<cfset variables.email_preheader_text = "Open to find your new raffle number. You are now entered into the monthly drawing.">
<cfset variables.email_sent_to = variables.selCurrentDonors_pb_email>
<cfmail
            to = "#variables.selCurrentDonors_pb_email#"
            bcc = "cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = "#variables.selCurrentDonors_pb_first_name# #variables.selCurrentDonors_pb_last_name#'s CavaliersRaffle.com numbers"
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74"> 
#variables.selCurrentDonors_pb_first_name# #variables.selCurrentDonors_pb_last_name#

Thank you for participating with CavaliersRaffle.com in support of Our Lady of Sorrows Academy.

<cfif ListLen(variables.raffle_list,",") is 1>Your raffle number is:<cfelse>Your raffle numbers are:</cfif>
#variables.raffle_list#

Your eligible raffle drawing dates are:
Starting - #variables.selCurrentDonors_start_date# 
Ending - #variables.selCurrentDonors_end_date#

The raffle is run on the first Friday of every month and you will receive an email identifying the winners.

This email was sent to #variables.selCurrentDonors_pb_email# from cavaliersraffle@olosa.org.

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
                        #variables.selCurrentDonors_pb_first_name# #variables.selCurrentDonors_pb_last_name#
                    </h1>
                    <p>
                        Thank you for participating with CavaliersRaffle.com in support of Our Lady of Sorrows Academy.
                    </p>
                    <p>
                        <cfif ListLen(variables.raffle_list,",") is 1>
                            Your raffle number is:&nbsp;
                        <cfelse>
                            Your raffle numbers are:&nbsp;
                        </cfif>
                    </p>
                    <p style="margin-left: 20px; margin-right: 20px; font-size: 20px; line-height: 24px;">
                        #variables.raffle_list#
                    </p>
                    <p>
                        Your eligibility raffle drawing dates are:
                    </p>
                    <p style="margin-left: 20px;">
                        Starting - #variables.selCurrentDonors_start_date#
                    </p>
                    <p style="margin-top:0; margin-left: 20px;">
                        Ending - #variables.selCurrentDonors_end_date#
                    </p>
                    <p>
                        The raffle is run on the first Friday of every month and you will receive an email identifying the winners.
                    </p>
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