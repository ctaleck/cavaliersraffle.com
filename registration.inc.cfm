
<cfform name="quote_request" action="registration_proc.cfm" method="post">
    <section id="entry" class="jumbotron bg-light-blue rounded-0 text-center mb-0">
        <div class="container">
                <h1 class="jumbotron-heading">Raffle Entry</h1>
                <p><b class="text-danger">*</b> are required fields.</p>
                <div class="row text-left">
                    <div class="col-md-4 mt-5">
                        <h3>Entry Information</h3>
                        <p>
                            Number of raffle tickets @ $25 per ticket
                        </p>
                        <label class="" for="tickets">Tickets</label>
                        <div class="input-group mb-2">
                            <cfset variables.ticket_no = " ,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20">
                            <cfoutput>
                                <select name="tickets" size="1" class="form-control">
                                    <cfloop index="tics" list="#variables.ticket_no#">
                                        <option value="#variables.tics#">#variables.tics#</option>
                                    </cfloop>
                                </select>
                            </cfoutput>
                                <div class="input-group-append">
                                <div class="input-group-text text-danger">*</div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-4 mt-5">
                        <h3>Ticket Holder Information</h3>
                        <p>
                            Please fill out the form below completely for the ticket holder! 
                        </p>
                        <label class="form-control-label" for="pb_first_name">First Name</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_first_name"
                                        size="30"
                                        maxlength="50">
                            <div class="input-group-append">
                                <span class="input-group-text text-danger"><b>*</b></span>
                            </div>
                        </div>
                        <label class="form-control-label" for="pb_last_name">Last Name</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_last_name"
                                        size="30"
                                        maxlength="75">
                            <div class="input-group-append">
                                <span class="input-group-text text-danger" id="inputGroupPrepend"><b>*</b></span>
                            </div>
                        </div>
                        <label class="form-control-label" for="pb_phone">Phone</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_phone"
                                        size="13"
                                        maxlength="14">
                            <div class="input-group-append">
                                <span class="input-group-text text-danger"><b>*</b></span>
                            </div>
                        </div>
                        <label class="form-control-label" for="pb_email">Email</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_email"
                                        size="30"
                                        maxlength="150">
                            <div class="input-group-append">
                                <span class="input-group-text text-danger" id="inputGroupPrepend"><b>*</b></span>
                            </div>
                        </div>
                        <label class="form-control-label" for="pb_address">Street Address</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_address"
                                        size="60"
                                        maxlength="100">
                        </div>
                        <label class="form-control-label" for="pb_city">City</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_city"
                                        size="30"
                                        maxlength="50">
                        </div>
                        <label class="form-control-label" for="pb_state">State</label>
                        <div class="input-group mb-2">
                            <cfset variables.states = " ,AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY">
                            <cfoutput>
                                <select name="pb_state" size="1" class="form-control">
                                    <cfloop index="abbrev" list="#variables.states#">
                                        <option value="#variables.abbrev#">#variables.abbrev#</option>
                                    </cfloop>
                                </select>        
                            </cfoutput>

                        </div>
                        <label class="form-control-label" for="pb_zipcode">Zipcode</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"                                    
                                        name="pb_zipcode"
                                        size="6"
                                        maxlength="5">
                        </div>
                    </div>
                    <div class="col-md-4 mt-5">
                        <h3>Sponsor Information</h3>
                        <p>
                            Are you sponsoring a school family? Tell us who so they will get credit!
                        </p>
                        <label class="" for="pb_info_source">School Family</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_info_source"
                                        size="75"
                                        maxlength="150">
                        </div>
                        <h3 class="mt-5">Gift Information</h3>
                        <p>
                            Is this a gift? If yes, please provide the Name and Email of the Gift Giver!
                        </p>
                        <div class="form-group">
                            <div class="form-check">
                                    <cfinput type="Checkbox" class="form-check-input" id="yesCheck"
                                                name="pb_gift"
                                                checked="No">
                                <label class="form-check-label" for="yesCheck">
                                Yes, this is a gift.
                                </label>
                            </div>
                        </div>
                        <label class="" for="pb_phx_family_name">Name</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_phx_family_name"
                                        size="40"
                                        maxlength="85">
                        </div>
                        <label class="" for="pb_phx_family_email">Email</label>
                        <div class="input-group mb-2">
                            <cfinput type="text" class="form-control"
                                        name="pb_phx_family_email"
                                        size="40"
                                        maxlength="150">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 mt-5 text-center">
                        <cfoutput>
                            <!--- //set a random number --->
                            <cfset variables.formValidator = RandRange(1,100000)>
                            <!--- //Set a session with this value --->
                            <cfset Session.formValidator = variables.formValidator>
                            <!--- // add the random number in your form --->
                            <input type="hidden" name="formValidator" value="#variables.formValidator#">
                            
                            <input type="hidden" name="form_referer" value="#cgi.HTTP_REFERER#" />
                        </cfoutput>
                        <cfinput type="submit" name="submit" value="Enroll Now!" validate="SubmitOnce" class="btn btn-lg btn-success text-shadow">
                        <p class="mt-3 small">Please allow up to three days to get your assigned ticket numbers.</p>
                        <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                    </div>
                </div>
        </div>
    </section>
</cfform>