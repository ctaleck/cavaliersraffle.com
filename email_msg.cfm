<!-- Email Body Content Sample : BEGIN -->
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
            <h1 style="margin: 0 0 10px 0; font-family: sans-serif; font-size: 25px; line-height: 30px; color: ##333333; font-weight: normal;">Principal's Newsletter</h1>
            <p style="margin: 0;">Maecenas sed ante pellentesque, posuere leo id, eleifend dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent laoreet malesuada cursus. Maecenas scelerisque congue eros eu posuere. Praesent in felis ut velit pretium lobortis rhoncus ut&nbsp;erat.</p>
        </td>
    </tr>
    <tr>
        <td style="padding: 0 20px;">
            <!-- Button : BEGIN -->
            <table align="center" cellspacing="0" cellpadding="0" border="0" style="margin: auto;">
                <tr>
                    <td class="button-td button-td-primary" style="border-radius: 4px; background: ##35355A;">
                            <a class="button-a button-a-primary" href="//cavaliersraffle.com" style="background: ##b81413; border: 1px solid ##b81413; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; color: ##ffffff; display: block; border-radius: 4px;">CavaliersRaffle.com</a>
                    </td>
                </tr>
            </table>
            <!-- Button : END -->
        </td>
    </tr>
    <tr>
        <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
            <h2 style="margin: 0 0 10px 0; font-family: sans-serif; font-size: 18px; line-height: 22px; color: ##333333; font-weight: bold;">Praesent in felis ut velit pretium lobortis rhoncus ut&nbsp;erat.</h2>
            <ul style="padding: 0; margin: 0 0 10px 0; list-style-type: disc;">
                <li style="margin:0 0 10px 30px;" class="list-item-first">A list item.</li>
                <li style="margin:0 0 10px 30px;">Another list item here.</li>
                <li style="margin: 0 0 0 30px;" class="list-item-last">Everyone gets a list item, list items for everyone!</li>
            </ul>
            <p style="margin: 0;">Maecenas sed ante pellentesque, posuere leo id, eleifend dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent laoreet malesuada cursus. Maecenas scelerisque congue eros eu posuere. Praesent in felis ut velit pretium lobortis rhoncus ut&nbsp;erat.</p>
        </td>
    </tr>
</table>
<!-- Email Body Content Sample : END -->

<!-- pb_report_details.cfm email -->
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td style="padding: 20px; font-family: sans-serif; font-size: 15px; line-height: 20px; color: ##555555;">
            <h1 style="margin: 0 0 10px 0; font-family: sans-serif; font-size: 25px; line-height: 30px; color: ##333333; font-weight: normal;">
                #selCurrentDonors.pb_first_name# #selCurrentDonors.pb_last_name#
            </h1>
            <p style="margin: 0;">Thank you for your support of CavaliersRaffle.com of Our Lady of Sorrows Academy!</p>
            <p style="margin: 0;"></p>
            <p style="margin: 0;">
                <cfif ListLen(variables.raffle_list,",") is 1>
                    Your Raffle Number is:&nbsp;
                <cfelse>
                    Your Raffle Numbers are:&nbsp;
                </cfif>
                #variables.raffle_list#
            </p>
            <p style="margin: 0;"></p>
            <p style="margin: 0;">
                Your Eligibility Raffle Drawing dates are:&nbsp;&nbsp;
                Starting - #selCurrentDonors.start_date#&nbsp;&nbsp; / &nbsp;&nbsp;
                Ending - #selCurrentDonors.end_date#
            </p>
            <p style="margin: 0;"></p>
            <p style="margin: 0;">
                The raffle is run on the first Friday of every month and you WILL receive email identifying the winners!
            </p>
            <p style="margin: 0;"></p>
            <p style="margin: 0;">
                If you do <em>not</em> get an email on the first Friday (by end of the day), check your junk or spam folder
                for the email and mark it as "Not Spam" so that you'll receive them in the future.
            </p>
        </td>
    </tr>
    <tr>
        <td style="padding: 0 20px;">
            <table align="center" cellspacing="0" cellpadding="0" border="0" style="margin: auto;">
                <tr>
                    <td class="button-td button-td-primary" style="border-radius: 4px; background: ##35355A;">
                            <a class="button-a button-a-primary" href="//cavaliersraffle.com" style="background: ##b81413; border: 1px solid ##b81413; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; color: ##ffffff; display: block; border-radius: 4px;">CavaliersRaffle.com</a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>