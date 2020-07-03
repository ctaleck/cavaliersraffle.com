<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfif ParameterExists(form.formValidator)>
	<cfif form.formValidator NEQ session.formValidator>
        <cflocation url="oops-error.cfm" addtoken="no">
    </cfif>
</cfif>

<cfinclude template="header.cfm">

<cfif IsDefined("url.ID")>
	<cfset variables.ID = url.id>
    <cfset variables.pb_donation_id = url.pb_donation_id>
    <cfset variables.pb_start_date = url.pb_start_date>
<cfelseif IsDefined("form.ID")>
	<cfset variables.ID = form.id>
    <cfset variables.pb_donation_id = form.pb_donation_id>
    <cfset variables.pb_start_date = form.pb_start_date>
    <cfset variables.pb_info_source = form.pb_info_source>
    
	<cfquery name="updt_pmt_status" datasource="#request.datasource#">
    	update #variables.str_donation#
           set pb_payment_verified = <cfqueryparam value="#form.pb_payment_verified#" cfsqltype="cf_sql_varchar">
         where id = <cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">
           and pb_donation_id = <cfqueryparam value="#variables.pb_donation_id#" cfsqltype="cf_sql_integer">
    </cfquery>    

	<cfquery name="updt_source" datasource="#request.datasource#">
    	update #variables.str_donor#
           set pb_info_source = <cfqueryparam value="#variables.pb_info_source#" cfsqltype="cf_sql_varchar">
         where id = <cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">
    </cfquery>    
</cfif>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Piggyback Registration Details</strong></h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
                            
                            <cfquery name="selCurrentDonors" datasource="#request.datasource#">
                                select a.[ID], 
                                       a.[pb_last_name], 
                                       a.[pb_first_name], 
                                       a.[pb_email], 
                                       a.[pb_phone], 
                                       a.[pb_address], 
                                       a.[pb_city], 
                                       a.[pb_state], 
                                       a.[pb_zipcode],
                                       a.[pb_info_source],
                                       a.[pb_active],
                                       a.[pb_gift], 
                                       b.[pb_donation], 
                                       b.[pb_ticket_number], 
                                       b.[pb_payment_verified],
                                       b.[pb_donation_id],
                                       c.[pb_donation_id],
                                       convert(varchar(10), c.[pb_start_date], 101) as start_date,
                                       convert(varchar(10), c.[pb_end_date], 101) as end_date
                                  from #variables.str_donor# as a 
                                 inner join #variables.str_donation# as b on a.id = b.id 
                                 inner join #variables.str_term# as c on b.id = c.id 
                                 where a.[ID] = <cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">
                                   and b.pb_donation_id = c.pb_donation_id 
                                   and b.pb_donation_id = <cfqueryparam value="#variables.pb_donation_id#" cfsqltype="cf_sql_integer">
                                 order by 2
                            </cfquery> 
                            
                            <cfif selCurrentDonors.pb_gift is "Y">
                                <cfquery name="selGiftedFamily" datasource="#request.datasource#">
                                	select pb_qhra_family_name,
                                           pb_qhra_family_email
                                      from #variables.str_family#
                                     where id = #selCurrentDonors.id#
                                       and pb_donation_id = <cfqueryparam value="#variables.pb_donation_id#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                <cfset variables.family_name = selGiftedFamily.pb_qhra_family_name>
                                <cfset variables.family_email = selGiftedFamily.pb_qhra_family_email>
                            <cfelse>
                                 <cfset variables.family_name = "NA">
                                <cfset variables.family_email = "NA">                           	
                            </cfif>
                            
                            <cfquery name="selUsedNumbers" datasource="#request.datasource#">
                                select [raffle_nbr]                                       
                                  from #variables.str_raffle#
                                 where [ID] = <cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">
								   and [pb_start_date] = <cfqueryparam value="#variables.pb_start_date#" cfsqltype="cf_sql_varchar">
                                 order by 1
                            </cfquery>

<cfif IsDefined("url.gen")>
<cfset variables.raffle_list = "">

<cfset myImgPath = expandPath('/') & "images/">

<cfloop query="selUsedNumbers">
	<cfset variables.raffle_list = ListAppend(variables.raffle_list,selUsedNumbers.raffle_nbr,",")>
</cfloop>

<cfset variables.raffle_list = ReReplace(variables.raffle_list,",",", ","ALL")>

<cfmail
    to = "#selCurrentDonors.pb_email#"
    bcc = "office@qhra.org, cekweb@yahoo.com, grahekmj@gmail.com"
    from = "PiggybackFacilitator@piggybackraffle.org"
    failto = "cekweb@yahoo.com"
    subject = "Your Piggyback Raffle Numbers"
    username = "PiggybackFacilitator@piggybackraffle.org"
    type="html"
    server = "localhost">

    <p align="center"><img src="cid:img1" width="320" height="336" /></p>
    <cfmailparam disposition="inline" contentid="img1" file="#myImgPath#piggyback.gif">
    
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">#selCurrentDonors.pb_first_name# #selCurrentDonors.pb_last_name#</h2>
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px">
        Thank you for your support of the Piggyback Raffle of Queen of the Holy Rosary Academy!
    </h3>
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px">
        <cfif ListLen(variables.raffle_list,",") is 1>
            Your Raffle Number is:&nbsp;
        <cfelse>
            Your Raffle Numbers are:&nbsp;
        </cfif>
        #variables.raffle_list#
    </h3>
    
    <h3 style="text-align:center; font-family:Tahoma, Geneva, sans-serif; font-size:16px">
        Your Eligibility Raffle Drawing dates are:&nbsp;&nbsp;
        Starting - #selCurrentDonors.start_date#&nbsp;&nbsp; / &nbsp;&nbsp;
        Ending - #selCurrentDonors.end_date#
    </h3>
    
    <h2 style="text-align:center; font-family:'Tahoma, Geneva, sans-serif; font-size:24px">
    	<span style="color:red">
            The raffle is run on the first Friday of every month and you WILL receive email identifying the winners!<br /><br />
            If you do NOT get an email on the first Friday (by end of the day), check your junk or spam folder<br />  
            for the email and mark it as "Not Spam" so that you'll receive them in the future.
        </span>
    </h2>
	
    <br />
    
    <hr />
        
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

<cfoutput>
	<script language="JavaScript1.2">
        alert("The ''Thank you'' and information email was sent to #selCurrentDonors.pb_first_name# #selCurrentDonors.pb_last_name#!\n\nBlind copies were sent to office@qhra.org, cekweb@yahoo.com and grahekmj@gmail.com")
    </script>
</cfoutput>

</cfif>
                            
                            <cfform name="reg_details" action="pb_report_details.cfm" method="post">
                                <table border="1" cellpadding="2" cellspacing="0" align="center" width="150%">
                                    <tr bgcolor="lightgrey">
                                        <th style="font-size:16px" align="center" colspan="6">Donors Currently Eligible for Drawing</th>
                                    </tr>
                                    <cfoutput query="selCurrentDonors">
                                        <tr bgcolor="lightgrey">
                                            <th align="left">Name</th>
                                            <th align="left">Address</th>
                                            <th align="left">Email</th>
                                            <th align="left">Ticket Qty</th>
                                            <th align="left">&nbsp;Start Date&nbsp;</th>
                                            <th align="left">Ending Date</th>
                                        </tr>
                                        <tr>                           
                                            <td style="font-size:12px; text-align:left">#selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#</td>
                                            <td style="font-size:12px; text-align:left">
                                            	<cfif Not Len(selCurrentDonors.pb_address)>
                                                	None Provided
                                                <cfelse>
                                                	#selCurrentDonors.pb_address#<br />#selCurrentDonors.pb_city# #selCurrentDonors.pb_state# #selCurrentDonors.pb_zipcode#
                                                </cfif>
                                            </td>
                                            <td style="font-size:12px; text-align:left">#selCurrentDonors.pb_email#</td>
                                            <td style="font-size:12px; text-align:left">#selCurrentDonors.pb_ticket_number#</td>
                                            <td style="font-size:12px; text-align:center">#selCurrentDonors.start_date#</td>
                                            <td style="font-size:12px; text-align:center">#selCurrentDonors.end_date#</td>
                                        </tr>
                                        <tr bgcolor="lightgrey">
                                            <th align="left">How PB Found</th>
                                            <th align="left">Gift?</th>
                                            <th align="left">Gift Family Name</th>
                                            <th align="left">Gift Family Email</th>
                                            <th align="left">Donation Amt</th>
                                            <th align="left">Pmt Verified</th>
                                        </tr>
                                        <tr>                           
                                            <td style="font-size:12px; text-align:left">
                                                <cfinput type="text" 
                                                         name="pb_info_source"
                                                         required="No"
                                                         value="#selCurrentDonors.pb_info_source#"
                                                         maxlength="100" 
                                                         size="30">
                                            </td>
                                            <td style="font-size:12px; text-align:left"">#selCurrentDonors.pb_gift#</td>
                                            <td style="font-size:12px; text-align:left">#variables.family_name#&nbsp;</td>
                                            <td style="font-size:12px; text-align:left">#variables.family_email#&nbsp;</td>
                                            <td style="font-size:12px; text-align:left">$#selCurrentDonors.pb_donation#</td>
                                            <td style="font-size:12px; text-align:center">
												<select name="pb_payment_verified" size="1">
													<cfif selCurrentDonors.pb_payment_verified is "N">
                                                        <option value="Y">Y</option>
                                                        <option value="N" selected>N</option>
                                                    <cfelse>
                                                        <option value="Y" selected>Y</option>
                                                        <option value="N">N</option>
                                                    </cfif>
                                            	</select>
                                            </td>
                                        </tr>
                                    </cfoutput>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <cfoutput>
												<!--- //set a random number --->
                                                <cfset variables.formValidator = RandRange(1,100000)>
                                                <!--- //Set a session with this value --->
                                                <cfset Session.formValidator = variables.formValidator>
                                                <!--- // add the random number in your form --->
                                                <input type="hidden" name="formValidator" value="#variables.formValidator#">
                                               
                                                <input type="hidden" name="ID" value="#variables.id#" />
                                                <input type="hidden" name="pb_donation_id" value="#variables.pb_donation_id#" />
                                                <input type="hidden" name="pb_start_date" value="#variables.pb_start_date#" />
                                            </cfoutput>
                                            
                                            <cfinput type="Submit" name="submit" value="Submit" validate="SubmitOnce">&nbsp;&nbsp;
                                            <cfinput type="Reset" name="reset" value="Reset">                                            										
                                        </td>
                                    </tr>
                                </table>
                            </cfform>
                            <br /><br />
                            
                            <cfif selUsedNumbers.RecordCount GT 0>
                                <table border="1" cellpadding="2" cellspacing="0" align="center" width="150%">
                                    <tr>
                                    	<th align="center" colspan="10">Current Raffle Numbers</th>
                                    </tr>
                                    <cfoutput>
										<cfif selUsedNumbers.RecordCount LTE 10>
                                            <tr>
                                                <cfloop query="selUsedNumbers" startrow="1" endrow="10">
                                                    <td style="font-size:12px; text-align:center">
                                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                                    </td>
                                                </cfloop>
                                            </tr>
                                       <cfelse>
                                            <tr>
                                                <cfloop query="selUsedNumbers" startrow="1" endrow="10">
                                                    <td style="font-size:12px; text-align:center">
                                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                                    </td>
                                                </cfloop>
                                            </tr>
                                            <tr>
                                                <cfloop query="selUsedNumbers" startrow="11" endrow="20">
                                                    <td style="font-size:12px; text-align:center">
                                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                                    </td>
                                                </cfloop>
                                            </tr>
                                        </cfif>
                                	</cfoutput>
                                </table>
                                <br /><br />
                                <cfoutput>
                                	<a href="pb_update_details.cfm?ID=#URLEncodedFormat(variables.id)#"><span style="text-align:left; font-size:26; color:green">Update Contact Information</span></a>
								</cfoutput>
                            <cfelse>
                            	<cfif selCurrentDonors.pb_payment_verified is "Y">
									<cfoutput>
                                        <a href="gen_raffle_nbrs.cfm?ID=#URLEncodedFormat(variables.id)#">Generate Raffle Numbers</a>
                                    </cfoutput>
                                <cfelse>
                                	<span style="color:#C06">Once Payment has been verified, you may generate Raffle Numbers</span>
                                </cfif>
                            </cfif>
                            
						</div>
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->

                <cfinclude template="tm_sidebar.cfm">
			</div>
		</div>
	</div>

<cfinclude template="footer.cfm">

