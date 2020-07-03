	<!--- Start of Email to the Piggyback (AFTER) Winner --->
    <cfset myImgPath = expandPath('/') & "images/">   
    <cfmail
		to = "office@qhra.org"
        bcc = "#variables.nonWinningEmailList3#, cekweb@yahoo.com, grahekmj@gmail.com"
        from = "PiggybackFacilitator@piggybackraffle.org"
        failto = "cekweb@yahoo.com"
        subject = "This Month's Winners"
        username = "PiggybackFacilitator@piggybackraffle.org"
        type="html"
        server = "localhost">
    
    <p align="center"><img src="cid:img1" width="320" height="336" /></p>
    <cfmailparam disposition="inline" contentid="img1" file="#myImgPath#piggyback.gif">
    
    <h1 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:36px">Congratulations</h1>
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">to our #MonthAsString(cal_month)# winners!</h2>
    
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
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#variables.winner_before_first# #variables.winner_before_last#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#qry_qry_before_state.state_name#</span><br /><br />
                </td>           
                <td align="center" style="border-bottom-color:red; border-left-color:red; border-right-color:red; border-top-color:red;" bgcolor="##6699CC">
                    <cfquery name="qry_qry_state" dbtype="query">
                        select distinct state_name
                          from selStateNames
                         where abbrev = '#variables.raffle_winner_state#'
                    </cfquery>
                
                	<span style="text-align:center; color:white; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">$200</span><br /><br />
                    <span style="text-align:center; color:white; font-family:Tahoma, Geneva, sans-serif; font-size:36px;">#variables.raffle_winner#</span><br /><br />
                	<span style="text-align:center; color:white; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#variables.winner_first# #variables.winner_last#</span><br /><br />
                	<span style="text-align:center; color:white; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#qry_qry_state.state_name#</span><br /><br />
                </td>           
                <td align="center">
                    <cfquery name="qry_qry_after_state" dbtype="query">
                        select distinct state_name
                          from selStateNames
                         where abbrev = '#variables.raffle_winner_after_state#'
                    </cfquery>
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">$50</span><br /><br />
                    <span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:36px;">#variables.raffle_winner_after#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#variables.winner_after_first# #variables.winner_after_last#</span><br /><br />
                	<span style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px;">#qry_qry_after_state.state_name#</span><br /><br />
                </td>
            </tr>            
        </table>

    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-style:italic; font-size:13px; font-style:italic; color:red">
        <span style="color:red">Please note:</span> If the numbers immediately before or after the winning number are not assigned, the prize is awarded to the next assigned number in that direction.
    </h3>    
    
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