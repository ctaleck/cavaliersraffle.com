	<!--- Start of Email to the Piggyback (AFTER) Winner --->
    <cfset myImgPath = expandPath('/') & "images/">   
    <cfmail    	
		to = "office@qhra.org"
        bcc = "cekweb@yahoo.com, juliejhoffman26@gmail.com, grahekmj@gmail.com"
        from = "PiggybackFacilitator@piggybackraffle.org"
        failto = "cekweb@yahoo.com"
        subject = "This Month's Winners"
        username = "PiggybackFacilitator@piggybackraffle.org"
        type="html"
        server = "localhost">
    
    <p align="center"><img src="cid:img1" width="320" height="336" /></p>
    <cfmailparam disposition="inline" contentid="img1" file="#myImgPath#piggyback.gif">
    
    <h1 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:36px">Office Notification</h1>
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">for our #MonthAsString(cal_month)# winners!</h2>
    
    <hr />

    <div align="center">
        <table border="1" cellpadding="3" cellspacing="0" width="75%">					
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
                <td align="center"><!--- #variables.winner_name# (#variables.winner#)<br />Donor ID = #qry_qry_winner.id# --->
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
    
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-style:italic; font-size:16px">
        Copyright &copy; #variables.currentYear# Queen of the Holy Rosary Academy, All rights reserved.
    </h3>
    
    <div align="center">
        <table border="0" width="50%">
            <tr>
                <td colspan="2" align="center"><span style="font-size:18px">Thanks to all who have enrolled!</span></td>
            </tr>
            <tr>
                <td align="left">
                    <span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px; font-weight:bold;">Our Mailing Address<br /></span>
                    <span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">
                        Queen of the Holy Rosary Academy<br />
                        393 W. Old Watson Road<br />
                        St. Louis, MO 63119
                    </span>
                </td>           
                <td align="right">
                    <a href="https://www.qhra.org"><img src="cid:img2" width="104" height="102" /></a>
                    <cfmailparam disposition="inline" contentid="img2" file="#myImgPath#qhra_seal.jpg">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">**** Please Note: This mailbox is unattended. Do not reply to this email ****</td>
            </tr>
        </table>
    </div>
    </cfmail>
	<!--- End of Email to the Piggyback (AFTER) Winner --->