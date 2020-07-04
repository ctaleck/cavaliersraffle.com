<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

<cfif IsDefined("url.ID")>
	<cfset variables.ID = url.id>
    <cfset variables.pb_donation_id = url.pb_donation_id>
    <cfset variables.pb_start_date = url.pb_start_date>
</cfif>

    <div class="container-fluid py-5">
        <h1>Entry Details Update</h1>
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
                <div class="form-group">
                    <label class="form-control-label" for="pb_first_name">First Name</label>
                    <cfinput type="text" class="form-control"
                                name="pb_first_name"
                                value="#selCurrentDonors.pb_first_name#"
                                size="60"
                                maxlength="100">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_last_name">Last Name</label>
                    <cfinput type="text" class="form-control"
                                name="pb_last_name"
                                value="#selCurrentDonors.pb_last_name#"
                                size="60"
                                maxlength="100">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_address">Street Address</label>
                    <cfinput type="text" class="form-control"
                                name="pb_address"
                                value="#selCurrentDonors.pb_address#"
                                size="60"
                                maxlength="100">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_city">City</label>
                    <cfinput type="text" class="form-control"
                                name="pb_city"
                                value="#selCurrentDonors.pb_city#"
                                size="30"
                                maxlength="50">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_state">State</label>
                    <cfset variables.states = " ,AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY">
                        <select name="pb_state" size="1" class="form-control">
                            <cfloop index="abbrev" list="#variables.states#">
                                <cfif selCurrentDonors.pb_state is variables.abbrev>
                                    <option value="#variables.abbrev#" selected>#variables.abbrev#</option>
                                <cfelse>
                                    <option value="#variables.abbrev#">#variables.abbrev#</option>
                                </cfif>
                            </cfloop>
                        </select>
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_zipcode">Zipcode</label>
                    <cfinput type="text"  class="form-control"                                   
                                name="pb_zipcode"
                                value="#selCurrentDonors.pb_zipcode#"
                                size="6"
                                maxlength="5">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_phone">Phone</label>
                    <cfinput type="text" class="form-control"
                                name="pb_phone"
                                value="#selCurrentDonors.pb_phone#"
                                size="13"
                                maxlength="14">
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="pb_email">Email</label>
                    <cfinput type="text" class="form-control"
                                name="pb_email"
                                value="#selCurrentDonors.pb_email#"
                                size="30"
                                maxlength="150">
                </div>
                <!--- //set a random number --->
                <cfset variables.formValidator = RandRange(1,100000)>
                <!--- //Set a session with this value --->
                <cfset Session.formValidator = variables.formValidator>
                <!--- // add the random number in your form --->
                <input type="hidden" name="formValidator" value="#variables.formValidator#">
                
                <input type="hidden" name="ID" value="#variables.id#" />
                <div class="form-group">
                    <cfinput class="btn btn-success" type="submit" name="submit" value="Update" validate="SubmitOnce">
                    <a class="btn btn-default" href="pb_report_details.cfm?ID=#URLEncodedFormat(variables.id)#&pb_donation_id=#URLEncodedFormat(variables.pb_donation_id)#&pb_start_date=#URLEncodedFormat(variables.pb_start_date)#">Cancel</a>
                </div>
            </cfoutput>
        </cfform>
    </div>

<cfinclude template="footer.cfm">

