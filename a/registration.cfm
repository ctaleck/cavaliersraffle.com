
<cfinclude template="header.cfm">
<body onLoad="document.quote_request.pb_first_name.focus();">
    
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Piggyback Registration</strong></h2>
						<p class="meta">Please fill out the form below completely!</p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
                            <cfform name="quote_request" action="registration_proc.cfm" method="post">
                                <table border="0" cellpadding="3" cellspacing="3">					
                                    <tr>
                                        <td colspan="2" align="left"><span style="font-size:16px; text-align:left">Raffle Entry Information</span></td>
                                        <td colspan="2" align="right"><span style="font-size:12px; text-align:right; color:red">** Required Fields</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">First Name :&nbsp;<span style="font-size:12px; text-align:right; color:red">**</span><br /> 
                                            <cfinput type="text"
                                                     name="pb_first_name"
                                                     size="30"
                                                     maxlength="50">
                                        </td>
                                        <td colspan="2">Last Name :&nbsp;<span style="font-size:12px; text-align:right; color:red">**</span><br /> 
                                            <cfinput type="text"
                                                     name="pb_last_name"
                                                     size="30"
                                                     maxlength="75">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">Street Address :<br /> 
                                            <cfinput type="text"
                                                     name="pb_address"
                                                     size="60"
                                                     maxlength="100">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">City :<br /> 
                                            <cfinput type="text"
                                                     name="pb_city"
                                                     size="30"
                                                     maxlength="50">
                                        </td>                             
                                        <td>State :<br />
                                            <cfset variables.states = " ,AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY">
                                            <cfoutput>
                                                <select name="pb_state" size="1">
                                                    <cfloop index="abbrev" list="#variables.states#">
                                                        <option value="#variables.abbrev#">#variables.abbrev#</option>
                                                    </cfloop>
                                                </select>        
                                            </cfoutput>
                                        </td>
                                        <td>Zipcode :<br /> 
                                            <cfinput type="text"                                    
                                                     name="pb_zipcode"
                                                     size="6"
                                                     maxlength="5">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left">Phone :&nbsp;<span style="font-size:12px; text-align:right; color:red">**</span><br />
                                            <cfinput type="text"
                                                     name="pb_phone"
                                                     size="13"
                                                     maxlength="14">
                                        </td>
                                        <td colspan="2" align="left">Email :&nbsp;<span style="font-size:12px; text-align:right; color:red">**</span><br /> 
                                            <cfinput type="text"
                                                     name="pb_email"
                                                     size="30"
                                                     maxlength="150">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="left">Are you sponsoring a School Family?  Tell us who so they will get credit.<br />
                                            <cfinput type="text"
                                                     name="pb_info_source"
                                                     size="75"
                                                     maxlength="150">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">Number of Raffle Tickets @ $25 per Ticket :&nbsp;&nbsp;&nbsp;
                                            <cfset variables.ticket_no = " ,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20">
                                            <cfoutput>
                                                <select name="tickets" size="1">
                                                    <cfloop index="tics" list="#variables.ticket_no#">
                                                        <option value="#variables.tics#">#variables.tics#</option>
                                                    </cfloop>
                                                </select>&nbsp;<span style="font-size:12px; text-align:right; color:red">**</span>
                                            </cfoutput>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td colspan="4" align="left">
                                            <cfinput type="Checkbox"
                                                     name="pb_gift"
                                                     checked="No"
                                                     align="TOP">&nbsp;Is this a gift?&nbsp;Check if Yes.
                                        </td>
                                    </tr>
                                    <tr>                                    
                                        <td colspan="4" align="left">
                                        	If yes, please provide the Name and Email of the Gift Giver!<br />
                                            Name:&nbsp;
                                            <cfinput type="text"
                                                     name="pb_qhra_family_name"
                                                     size="40"
                                                     maxlength="85">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="left">
                                            Email:&nbsp;
                                            <cfinput type="text"
                                                     name="pb_qhra_family_email"
                                                     size="40"
                                                     maxlength="150">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <cfoutput>
												<!--- //set a random number --->
                                                <cfset variables.formValidator = RandRange(1,100000)>
                                                <!--- //Set a session with this value --->
                                                <cfset Session.formValidator = variables.formValidator>
                                                <!--- // add the random number in your form --->
                                                <input type="hidden" name="formValidator" value="#variables.formValidator#">
                                              
                                                <input type="hidden" name="form_referer" value="#cgi.HTTP_REFERER#" />
                                            </cfoutput>
                                                <cfinput type="submit" name="submit" value="Submit" validate="SubmitOnce">
                                                <cfinput type="reset" name="reset" value="Reset">
                                        </td>
                                    </tr>
                                </table>
                            </cfform>
						</div>
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->

                <cfinclude template="sidebar.cfm">
			</div>
		</div>
	</div>

<cfinclude template="footer.cfm">