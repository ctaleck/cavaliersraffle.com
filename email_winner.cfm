	<!--- Start of Email to the BIG Winner --->
    <cfset myImgPath = expandPath('/') & "images/">   
    <cfmail
		to = "office@qhra.org"
        bcc = "#variables.winner_email#, cekweb@yahoo.com, grahekmj@gmail.com"
        from = "PiggybackFacilitator@piggybackraffle.org"
        failto = "cekweb@yahoo.com"
        subject = "You Won!"
        username = "PiggybackFacilitator@piggybackraffle.org"
        type="html"
        server = "localhost">
    
    <p align="center"><img src="cid:img1" width="320" height="336" /></p>
    <cfmailparam disposition="inline" contentid="img1" file="#myImgPath#piggyback.gif">
    
    <h1 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:36px">Congratulations #variables.winner_first#</h1>
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">You were the BIG ($200) Winner this month</h2>
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px">
        Your check will be mailed to the address you provided when you enrolled.<br />Thank you for supporting our school through your participation in the raffle.
    </h3>
    
    <hr />
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-style:italic; font-size:16px">
        Copyright &copy; #variables.currentYear# Queen of the Holy Rosary Academy, All rights reserved.
    </h3>
    
    <div align="center">
        <table border="0" cellspacing="20">
            <tr>
                <td align="left" width="50%">
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
	<!--- End of Email to the BIG Winner --->