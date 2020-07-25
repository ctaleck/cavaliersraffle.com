<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfif ParameterExists(form.formValidator)>
	<cfif form.formValidator NEQ session.formValidator>
        <cflocation url="oops-error.cfm" addtoken="no">
    </cfif>
</cfif>

<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

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

    <div class="container-fluid py-5">
        <h1>Registration Details</h1>
        <h2>Donors Currently Eligible for Drawing</h2>

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
                select pb_phx_family_name,
                        pb_phx_family_email
                    from #variables.str_family#
                    where id = #selCurrentDonors.id#
                    and pb_donation_id = <cfqueryparam value="#variables.pb_donation_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfset variables.family_name = selGiftedFamily.pb_phx_family_name>
            <cfset variables.family_email = selGiftedFamily.pb_phx_family_email>
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

            <cfloop query="selUsedNumbers">
                <cfset variables.raffle_list = ListAppend(variables.raffle_list,selUsedNumbers.raffle_nbr,",")>
            </cfloop>

            <cfset variables.raffle_list = ReReplace(variables.raffle_list,",",", ","ALL")>
            <cfset variables.selCurrentDonors_pb_email = selCurrentDonors.pb_email>
            <cfset variables.selCurrentDonors_pb_first_name = selCurrentDonors.pb_first_name>
            <cfset variables.selCurrentDonors_pb_last_name = selCurrentDonors.pb_last_name>
            <cfset variables.selCurrentDonors_start_date = selCurrentDonors.start_date>
            <cfset variables.selCurrentDonors_end_date = selCurrentDonors.end_date>

            <!--- Send out the email notifications --->
            <cfoutput> 
                <cfinclude template="email_pb_report_details.cfm">
            </cfoutput>

            <cfoutput>
                <script language="JavaScript1.2">
                    alert("The ''Thank you'' and information email was sent to #selCurrentDonors.pb_first_name# #selCurrentDonors.pb_last_name# at #selCurrentDonors.pb_email#.\n\nBlind copies were sent to cavaliersraffle@olosa.org.")
                </script>
            </cfoutput>

        </cfif>
                            
        <cfform name="reg_details" action="pb_report_details.cfm" method="post">
            <div class="card card-body">
                <table class="table table-bordered">
                    <cfoutput query="selCurrentDonors">
                        <tr>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Ticket Qty</th>
                            <th>&nbsp;Start Date&nbsp;</th>
                            <th>Ending Date</th>
                        </tr>
                        <tr>                           
                            <td>#selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#</td>
                            <td>
                                <cfif Not Len(selCurrentDonors.pb_address)>
                                    None Provided
                                <cfelse>
                                    #selCurrentDonors.pb_address#<br />#selCurrentDonors.pb_city# #selCurrentDonors.pb_state# #selCurrentDonors.pb_zipcode#
                                </cfif>
                            </td>
                            <td>#selCurrentDonors.pb_email#</td>
                            <td>#selCurrentDonors.pb_ticket_number#</td>
                            <td>#selCurrentDonors.start_date#</td>
                            <td>#selCurrentDonors.end_date#</td>
                        </tr>
                        <tr>
                            <th>How PB Found</th>
                            <th>Gift?</th>
                            <th>Gift Family Name</th>
                            <th>Gift Family Email</th>
                            <th>Donation Amt</th>
                            <th>Pmt Verified</th>
                        </tr>
                        <tr>                           
                            <td>
                                <cfinput type="text" 
                                            name="pb_info_source"
                                            required="No"
                                            value="#selCurrentDonors.pb_info_source#"
                                            maxlength="100" 
                                            size="30">
                            </td>
                            <td>#selCurrentDonors.pb_gift#</td>
                            <td>#variables.family_name#&nbsp;</td>
                            <td>#variables.family_email#&nbsp;</td>
                            <td>$#selCurrentDonors.pb_donation#</td>
                            <td>
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
                </table>
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
                <cfinput class="btn btn-primary" type="Submit" name="submit" value="Save" validate="SubmitOnce">
            </div>
        </cfform>
    </div>
        
    <cfif selUsedNumbers.RecordCount GT 0>
        <div class="container-fluid">
            <cfoutput>
                <a class="btn btn-success" href="pb_update_details.cfm?ID=#URLEncodedFormat(variables.id)#&pb_donation_id=#URLEncodedFormat(variables.pb_donation_id)#&pb_start_date=#URLEncodedFormat(variables.pb_start_date)#"><span>Update Contact Information</span></a>
            </cfoutput>
        </div>
        <div class="container-fluid py-5">
            <h2>Current Raffle Numbers</h2>
            <div class="card card-body">
                <table class="table table-sm table-bordered">
                    <cfoutput>
                        <cfif selUsedNumbers.RecordCount LTE 10>
                            <tr>
                                <cfloop query="selUsedNumbers" startrow="1" endrow="10">
                                    <td>
                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                    </td>
                                </cfloop>
                            </tr>
                        <cfelse>
                            <tr>
                                <cfloop query="selUsedNumbers" startrow="1" endrow="10">
                                    <td>
                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                    </td>
                                </cfloop>
                            </tr>
                            <tr>
                                <cfloop query="selUsedNumbers" startrow="11" endrow="20">
                                    <td>
                                        #selUsedNumbers.raffle_nbr#&nbsp;
                                    </td>
                                </cfloop>
                            </tr>
                        </cfif>
                    </cfoutput>
                </table>
            </div>
        </div>
    <cfelse>
        <div class="container-fluid py-5">
            <cfif selCurrentDonors.pb_payment_verified is "Y">
                <cfoutput>
                    <a class="btn btn-primary" href="gen_raffle_nbrs.cfm?ID=#URLEncodedFormat(variables.id)#">Generate Raffle Numbers</a>
                </cfoutput>
            <cfelse>
                <div class="alert alert-danger">Once Payment has been verified, you may generate Raffle Numbers</div>
            </cfif>
        </div>
    </cfif>

<cfinclude template="footer.cfm">

