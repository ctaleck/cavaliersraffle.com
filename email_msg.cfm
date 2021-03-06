<!-- Make sure to escape hash (##) -->
<cfset variables.email_preheader_text = "">
<cfset variables.email_sent_to = "">
<cfmail
            to = "cavaliersraffle@olosa.org"
            bcc = "cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = ""
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74"> 
Title   
   
Text   
   
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
                        Title
                    </h1>
                    <p>
                        Text
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