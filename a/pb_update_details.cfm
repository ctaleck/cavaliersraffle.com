<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

<cfif IsDefined("url.ID")>
	<cfset variables.ID = url.id>
</cfif>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Piggyback Entry Details Update</strong></h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
                            
                            <cfquery name="selCurrentDonors" datasource="#request.datasource#">
                                select [ID], 
                                       [pb_last_name], 
                                       [pb_first_name], 
                                       [pb_email], 
                                       [pb_phone], 
                                       [pb_address], 
                                       [pb_city], 
                                       [pb_state], 
                                       [pb_zipcode]
                                  from #variables.str_donor# 
                                 where [ID] = <cfqueryparam value="#variables.id#" cfsqltype="cf_sql_integer">
                                 order by 2
                            </cfquery> 
                                                        
                            <cfform name="quote_request" action="pb_update_details_proc.cfm" method="post">
                                <cfoutput>
                                <table border="0" cellpadding="3" cellspacing="3">					
                                    <tr>
                                        <td colspan="2">First Name :&nbsp; 
                                            <cfinput type="text"
                                                     name="pb_first_name"
                                                     value="#selCurrentDonors.pb_first_name#"
                                                     size="60"
                                                     maxlength="100">
                                        </td>
                                        <td colspan="2">Last Name :&nbsp; 
                                            <cfinput type="text"
                                                     name="pb_last_name"
                                                     value="#selCurrentDonors.pb_last_name#"
                                                     size="60"
                                                     maxlength="100">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">Street Address :<br /> 
                                            <cfinput type="text"
                                                     name="pb_address"
                                                     value="#selCurrentDonors.pb_address#"
                                                     size="60"
                                                     maxlength="100">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">City :<br /> 
                                            <cfinput type="text"
                                                     name="pb_city"
                                                     value="#selCurrentDonors.pb_city#"
                                                     size="30"
                                                     maxlength="50">
                                        </td>                             
                                        <td>State :<br />
                                            <cfset variables.states = " ,AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY">
                                                <select name="pb_state" size="1">
                                                    <cfloop index="abbrev" list="#variables.states#">
                                                        <cfif selCurrentDonors.pb_state is variables.abbrev>
                                                            <option value="#variables.abbrev#" selected>#variables.abbrev#</option>
                                                        <cfelse>
                                                            <option value="#variables.abbrev#">#variables.abbrev#</option>
                                                        </cfif>
                                                    </cfloop>
                                                </select>
                                        </td>
                                        <td>Zipcode :<br /> 
                                            <cfinput type="text"                                    
                                                     name="pb_zipcode"
                                                     value="#selCurrentDonors.pb_zipcode#"
                                                     size="6"
                                                     maxlength="5">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left">Phone :<br />
                                            <cfinput type="text"
                                                     name="pb_phone"
                                                     value="#selCurrentDonors.pb_phone#"
                                                     size="13"
                                                     maxlength="14">
                                        </td>
                                        <td colspan="2" align="left">Email :<br /> 
                                            <cfinput type="text"
                                                     name="pb_email"
                                                     value="#selCurrentDonors.pb_email#"
                                                     size="30"
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
                                                
                                                <input type="hidden" name="ID" value="#variables.id#" />
                                            </cfoutput>
                                                <cfinput type="submit" name="submit" value="Update" validate="SubmitOnce">
                                                <cfinput type="reset" name="reset" value="Reset">
                                        </td>
                                    </tr>
                                </table>
                                </cfoutput>
                            </cfform>
                            
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

