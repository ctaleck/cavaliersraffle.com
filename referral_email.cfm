<!-- Make sure to escape hash (##) -->
<cftry>

<cfif isDefined("Url.Test")>
    <cfset variables.referral_email = "chris@taleck.com">
</cfif>

<cfset variables.email_preheader_text = "Open to find learn about CavaliersRaffle.com.">
<cfset variables.email_sent_to = variables.referral_email>
<cfmail
            to = "#variables.referral_email#"
            bcc = "cavaliersraffle@olosa.org"
            from = "cavaliersraffle@olosa.org"
            failto = "cavaliersraffle@olosa.org"
            subject = "CavaliersRaffle.com"
            type="html"
            server = "localhost">
<cfmailpart type="text" wraptext="74">
Dear #variables.referral_email#,

Our Lady of Sorrows Academy is excited to announce our new fundraiser - the Cavaliers Raffle!  

As you know, our non-profit K-12 school provides a traditional, classical education in Phoenix, Arizona. We have wonderful teachers and priests who do their best for us, and many families to support them. However, we always need more - more books, more supplies, more money to pay the bills and increase our teacher salaries. Tuition isn’t enough, so we find other ways to raise money. Students look forward to our annual Jog-a-thon, but we want to do something year-round.

The Cavaliers Raffle is a quick and easy way for you to support our small Catholic school, but also a quick and easy way for you to win a cash prize. You get 12 chances to win - for just one $20 ticket! Every month, we will select a computer-generated winner for a grand prize of $200, plus two runner-up winners of $50 each. This is a continuous raffle, so people can join the pool every month. Your ticket lasts for one year from purchase. Once you buy a ticket, just wait to (hopefully) win!

Won’t you please invest in our school? Purchase a ticket (or two!) for yourself, or one for a friend. Feel free to forward this email, or the link below, to all of your friends … who doesn’t want to win $200?!

Click on the link below for more information and to register at CavaliersRaffle.com - it’s so simple!  Please select our family name from the student list, so we receive credit for the ticket sale.

Thank you for supporting our school! Your continued generosity is so much appreciated. You are in my prayers.

Donate securely online at: https://cavaliersraffle.com.


This email was sent to #variables.email_sent_to# from cavaliersraffle@olosa.org.

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
                    <p>
                    Our Lady of Sorrows Academy is excited to announce our new fundraiser - the Cavaliers Raffle!  
                    </p>
                    <p>
                    As you know, our non-profit K-12 school provides a traditional, classical education in Phoenix, Arizona. We have wonderful teachers and priests who do their best for us, and many families to support them. However, we always need more - more books, more supplies, more money to pay the bills and increase our teacher salaries. Tuition isn’t enough, so we find other ways to raise money. Students look forward to our annual Jog-a-thon, but we want to do something year-round.
                    </p>
                    <p>
                    The Cavaliers Raffle is a quick and easy way for you to support our small Catholic school, but also a quick and easy way for you to win a cash prize. You get 12 chances to win - for just one $20 ticket! Every month, we will select a computer-generated winner for a grand prize of $200, plus two runner-up winners of $50 each. This is a continuous raffle, so people can join the pool every month. Your ticket lasts for one year from purchase. Once you buy a ticket, just wait to (hopefully) win!
                    </p>
                    <p>
                    Won’t you please invest in our school? Purchase a ticket (or two!) for yourself, or one for a friend. Feel free to forward this email, or the link below, to all of your friends … who doesn’t want to win $200?!
                    </p>
                    <p>
                    Click on the link below for more information and to register at CavaliersRaffle.com - it’s so simple!  Please select our family name from the student list, so we receive credit for the ticket sale.
                    </p>
                    <p>
                    Thank you for supporting our school! Your continued generosity is so much appreciated. You are in my prayers.
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

    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>