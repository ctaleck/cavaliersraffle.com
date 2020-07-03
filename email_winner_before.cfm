	<!--- Start of Email to the Piggyback (AFTER) Winner --->
    <cfset myImgPath = expandPath('/') & "images/">   
    <cfmail
		to = "office@qhra.org"
        bcc = "#variables.winner_before_email#, cekweb@yahoo.com, grahekmj@gmail.com"
        from = "PiggybackFacilitator@piggybackraffle.org"
        failto = "cekweb@yahoo.com"
        subject = "You Won!"
        username = "PiggybackFacilitator@piggybackraffle.org"
        type="html"
        server = "localhost">
    
    <p align="center"><img src="cid:img1" width="320" height="336" /></p>
    <cfmailparam disposition="inline" contentid="img1" file="#myImgPath#piggyback.gif">
    
    <h1 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:36px">Congratulations #variables.winner_before_first#</h1>
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">You Piggybacked on the winner this month</h2>
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px">
        Your check will be mailed to the address you provided when you enrolled.<br />Thank you for supporting our school through your participation in the raffle.
    </h3>
    
    <hr />

    <div align="center">
        <table border="0" width="75%">
            <tr>
                <td align="center">
                    <cfquery name="qry_qry_before_state" dbtype="query">
                        select distinct state_name
                          from selStateNames
                         where abbrev = '#variables.raffle_winner_before_state#'
                    </cfquery>
                
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">$50</span><br /><br />
                    <span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:36px;">#variables.raffle_winner_before#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#variables.winner_before_first#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#qry_qry_before_state.state_name#</span><br /><br />
                </td>           
                <td align="center">
                    <cfquery name="qry_qry_after_state" dbtype="query">
                        select distinct state_name
                          from selStateNames
                         where abbrev = '#variables.raffle_winner_after_state#'
                    </cfquery>
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">$50</span><br /><br />
                    <span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:36px;">#variables.raffle_winner_after#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#variables.winner_after_first#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#qry_qry_after_state.state_name#</span><br /><br />
                </td>
            </tr>
        </table>
    
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-style:italic; font-size:16px">
        Copyright &copy; #variables.currentYear# Queen of the Holy Rosary Academy, All rights reserved.
    </h3>
    
    <div align="center">
        <table border="0" width="50%">
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