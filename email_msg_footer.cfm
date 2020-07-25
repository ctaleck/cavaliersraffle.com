<cfoutput>
    <!-- Make sure to escape hash (##) -->
                            <!-- Email Body Content: END -->
                    </td>
                </tr>
                <!-- 1 Column Text + Button : END -->


                <!-- Clear Spacer : BEGIN -->
                <tr>
                    <td aria-hidden="true" height="40" style="font-size: 0px; line-height: 0px;">
                        &nbsp;
                    </td>
                </tr>
                <!-- Clear Spacer : END -->

                <!-- 1 Column Text : BEGIN -->
                <tr>
                    <td style="background-color: ##ffffff;">
                        <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td style="padding: 20px; font-family: sans-serif; font-size: 11px; line-height: 20px; color: ##555555;">
                                <p>
                                    <cfif Len(variables.email_sent_to) gt 0>
                                    This email was sent to #variables.email_sent_to# from cavaliersraffle@olosa.org.
                                    </cfif>
                                </p>
                                    <p>
                                        #variables.email_spam_text#
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!-- 1 Column Text : END -->

            </table>
            <!-- Email Body : END -->
                            <!-- Email Body Content: END -->
                        </td>
                    </tr>
                    <!-- 1 Column Text + Button : END -->
    
                </table>
                <!-- Email Body : END -->
    
                <!-- Email Footer : BEGIN -->
    	        <table align="center" cellspacing="0" cellpadding="0" border="0" width="100%" style="margin: auto;">
                    <tr>
                        <td style="padding: 20px; font-family: sans-serif; font-size: 12px; line-height: 15px; text-align: center; color: ##ffffff;">
                            <br><br>
                            #Replace(variables.email_address_text,"|","<br>","ALL")#
                            <br><br>
                        </td>
                    </tr>
                </table>
                <!-- Email Footer : END -->
    
                <!--[if mso]>
                </td>
                </tr>
                </table>
                <![endif]-->
            </div>
    
            <!-- Full Bleed Background Section : BEGIN -->
            <table cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: ##35355A;">
                <tr>
                    <td>
                        <div align="center" style="max-width: 600px; margin: auto;" class="email-container">
                            <!--[if mso]>
                            <table cellspacing="0" cellpadding="0" border="0" width="600" align="center">
                            <tr>
                            <td>
                            <![endif]-->
                            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                <tr>
                                    <td style="padding: 20px; text-align: left; font-family: sans-serif; font-size: 11px; line-height: 20px; color: ##888888;">
                                        <p style="margin: 0;">
                                            #variables.email_exempt_text#
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            <!--[if mso]>
                            </td>
                            </tr>
                            </table>
                            <![endif]-->
                        </div>
                    </td>
                </tr>
            </table>
            <!-- Full Bleed Background Section : END -->
    
        <!--[if mso | IE]>
        </td>
        </tr>
        </table>
        <![endif]-->
        </center>
    </body>
    </html>
</cfoutput>