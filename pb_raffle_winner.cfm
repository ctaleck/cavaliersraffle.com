<cfif ParameterExists(form.formValidator)>
	<cfif form.formValidator NEQ session.formValidator>
        <cflocation url="oops-error.cfm" addtoken="no">
    </cfif>
</cfif>

<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="js/rusure.js">
<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 111) < <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

<!--- Get the list of valid raffle number, start date less than or equal to today, and for the end date to be greater than or equal to today . --->
<cfquery name="selUsedNumbers" datasource="#request.datasource#">
    select [raffle_nbr]                                   
      from #variables.str_raffle#
     where convert(varchar(10), [pb_start_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
       and convert(varchar(10), [pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
     order by 1
</cfquery>

    <cfif NOT IsDefined("form.winning_number")>
        <!--- Start Random Number Generator Code --->

        <cfquery name="selUsedNumbers" datasource="#request.datasource#">
            select [raffle_nbr]                                   
                from #variables.str_raffle#
                where convert(varchar(10), [pb_start_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                and convert(varchar(10), [pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                order by 1
        </cfquery>

        <!--- Query to get list of eligible raffle numbers --->
        <cfset variables.eligible_number_list = "">
        <cfloop query="#selUsedNumbers#">
            <cfset variables.eligible_number_list = ListAppend(variables.eligible_number_list, selUsedNumbers.raffle_nbr,", ")>
        </cfloop>
        
        <!--- Define the list of numbers in a string. --->
        <cfset strList = variables.eligible_number_list>
        <!--- Create a struct to hold the list of selected numbers. Because structs are indexed by key, it will allow us to not select duplicate values.--->
        <cfset objSelections = {} />
        
        <cfif strList NEQ "">
            <!--- Now, all we have to do is pick random numbers until our struct count is the desired size (1).--->
            <cfloop condition="(StructCount( objSelections ) LT 1)">
            
                <!--- Select a random list index. --->
                <cfset intIndex = RandRange( 1, ListLen( strList ) ) />
            
                <!--- Add the random item to our collection. If we have already picked this number, then it will simply overwrite the previous and the StructCount() will not be changed. --->
                <cfset objSelections[ ListGetAt( strList, intIndex ) ] = true />
            </cfloop>
        </cfif>
        <!--- Random Number output --->
        <!--- <cfoutput>#StructKeyList( objSelections )#</cfoutput> (Look in textbox) --->
        <div class="container-fluid py-5">
            <h1>Winning Raffle Number Entry</h1>
            <div class="card card-body">
                <cfform name="quote_request" action="pb_raffle_winner.cfm" method="post">
                    <cfoutput>
                    <div class="form-group">
                        <label for="winner" class="form-control-label">The Winning Raffle Number is Shown Below</label>
                        <cfinput type="text" class="form-control" id="winner"
                                    value="#StructKeyList( objSelections )#" <!--- Random Number output --->                                                       
                                    name="winning_number"
                                    size="4"
                                    readonly="yes"
                                    maxlength="5">
                    </div>
                    <div class="form-group">
                        <label for="thing" class="form-control-label">Eligible Numbers</label>
                        <textarea class="form-control" name="thing" id="thing" disabled="disabled">#variables.eligible_number_list#</textarea>
                    </div>
                    <!--- //set a random number --->
                    <cfset variables.formValidator = RandRange(1,100000)>
                    <!--- //Set a session with this value --->
                    <cfset Session.formValidator = variables.formValidator>
                    <!--- // add the random number in your form --->
                    <input type="hidden" name="formValidator" value="#variables.formValidator#">
                        
                    <cfinput class="btn btn-primary" type="submit" name="submit" value="Email Winners" validate="SubmitOnce">
                    </cfoutput>
                </cfform> 
            </div>
        </div>
    <cfelse>
        <cfquery name="qry_qry_number_exists" dbtype="query">
            select distinct raffle_nbr
                from selUsedNumbers
                where raffle_nbr = <cfqueryparam value="#form.winning_number#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfif qry_qry_number_exists.RecordCount is 0>
            <script language="JavaScript1.2">
                alert("The Raffle Number you provided is not valid for this month's drawing!")
                history.go(-1)   
            </script>
            <cfabort>     		
        <cfelse>
            <!--- check to see if the provided raffle number is in the valid list --->
            <cfquery name="qry_qry_number_exists" dbtype="query">
                select distinct raffle_nbr
                    from selUsedNumbers
                    where raffle_nbr = <cfqueryparam value="#form.winning_number#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <!--- If not, provide the error message and make them pick another number --->
            <cfif qry_qry_number_exists.RecordCount is 0>
                <script language="JavaScript1.2">
                    alert("The Raffle Number you provided is not valid for this month's drawing!")
                    history.go(-1)   
                </script>
                <cfabort>     		
            <cfelse>
                <!--- The number was a good one.  Get a list of ALL the valid raffle numbers --->
                <cfset variables.raffle_nbrs = "">
                <cfloop query="selUsedNumbers">
                    <cfset variables.raffle_nbrs = ListAppend(variables.raffle_nbrs, selUsedNumbers.raffle_nbr)>
                </cfloop>
            
                <!--- Next, get the position within the list of the winner --->
                <cfscript>
                    myList="#variables.raffle_nbrs#";
                    myFind=ListFind(myList,"#form.winning_number#");
                    
                    piggyback_pre =  myFind - 1;  
                    piggyback_post =  myFind + 1;  
                </cfscript> 
                
                <!--- Set the winner to a variable --->
                <cfset variables.winner = form.winning_number>
                
                <!--- Let's get the before and after piggyback winners. --->
                <cfif variables.winner is ListFirst(variables.raffle_nbrs)>
                    <!--- The winning number was the first number in the list of valid raffle numbers, so the piggyback "before" reverts to the very LAST number in the list --->
                    <cfset variables.winner_before = ListLast(variables.raffle_nbrs)>
                <cfelse>
                    <cfset variables.winner_before = ListGetAt(variables.raffle_nbrs,piggyback_pre)>
                </cfif>
                
                <cfif variables.winner is ListLast(variables.raffle_nbrs)>
                    <!--- The winning number was the last number in the list of valid raffle numbers, so the piggyback "after" reverts to the very FIRST number in the list --->
                    <cfset variables.winner_after = ListFirst(variables.raffle_nbrs)>
                <cfelse>
                    <cfset variables.winner_after = ListGetAt(variables.raffle_nbrs,piggyback_post)>
                </cfif> 
            
                <!--- Do a true query to get the matching ID to the winning raffle numbers --->
                <cfquery name="selGetDonors" datasource="#request.datasource#">
                    select [id], [raffle_nbr]                                   
                        from #variables.str_raffle#
                        where raffle_nbr in (#variables.winner#,#variables.winner_before#,#variables.winner_after#)
                        order by 1
                </cfquery>
                
                <!--- Set the winning ID's to a list --->
                <cfset variables.winner_list = "">
                <cfloop query="selGetDonors">
                    <cfset variables.winner_list = ListAppend(variables.winner_list,selGetDonors.ID)>
                </cfloop>

                <!--- Get the rest of the winner information for display --->
                <cfquery name="selWinningDonors" datasource="#request.datasource#">
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
                            a.[pb_gift],
                            b.[raffle_nbr]
                        from #variables.str_donor# as a
                        inner join #variables.str_raffle# as b on a.id = b.id
                        where a.ID in (#variables.winner_list#)
                    order by 1
                </cfquery> 
                <div class="container-fluid py-5">
                <h1>Winning Number and Piggybacks</h1>
                <h2>The Raffle Winners</h2>
                    <cfoutput>
                        <table>					
                            <tr>
                                <th align="center">$200 Raffle Winner</th>
                                <th align="center">$50 Piggyback (before)</th>
                                <th align="center">$50 Piggyback (after)</th>
                            </tr>
                            <tr>
                                <!--- ********** Output the Winner's Information  *********** --->
                                <cfquery name="qry_qry_winner" dbtype="query">
                                    select distinct id, pb_last_name, pb_first_name, pb_email, pb_address, pb_city, pb_state, pb_zipcode, pb_phone
                                        from selWinningDonors
                                        where raffle_nbr = <cfqueryparam value="#variables.winner#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                
                                <cfset variables.winner_name = "#qry_qry_winner.pb_first_name# #qry_qry_winner.pb_last_name#">                                                
                                <td align="center"><!--- #variables.winner_name# (#variables.winner#)<br />Donor ID = #qry_qry_winner.id# --->
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td align="center">
                                                #variables.winner_name# (#variables.winner#)<br />
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
                                        from selWinningDonors
                                        where raffle_nbr = <cfqueryparam value="#variables.winner_before#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                
                                <cfset variables.winner_name_before = "#qry_qry_winner_before.pb_first_name# #qry_qry_winner_before.pb_last_name#">                                                
                                <td align="center"><!--- #variables.winner_name_before# (#variables.winner_before#)<br />Donor ID = #qry_qry_winner_before.id# --->
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td align="center">
                                                #variables.winner_name_before# (#variables.winner_before#)<br />
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
                                        from selWinningDonors
                                        where raffle_nbr = <cfqueryparam value="#variables.winner_after#" cfsqltype="cf_sql_integer">
                                </cfquery>
                                
                                <cfset variables.winner_name_after = "#qry_qry_winner_after.pb_first_name# #qry_qry_winner_after.pb_last_name#">                                                
                                <td align="center"><!--- #variables.winner_name_after# (#variables.winner_after#)<br />Donor ID = #qry_qry_winner_after.id# --->
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td align="center">
                                                #variables.winner_name_after# (#variables.winner_after#)<br />
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

                        <cfset confirmation="By Submitting this form, you will be generating and sending mass emails.  Are you sure?">

                        <cfform name="send_email" action="gen_email.cfm" method="post" enablecab="Yes" onSubmit="return rusureform('#confirmation#')">
                            <cfinput class="btn btn-success" type="submit" name="submit" value="Generate Email Notifications" validate="SubmitOnce">
                            
                            <!--- //set a random number --->
                            <cfset variables.formValidator = RandRange(1,100000)>
                            <!--- //Set a session with this value --->
                            <cfset Session.formValidator = variables.formValidator>
                            <!--- // add the random number in your form --->
                            <input type="hidden" name="formValidator" value="#variables.formValidator#">
                            
                            <!--- All the following will be used in the subsequent emailings that will go out. --->
                            <input type="hidden" name="raffle_winner_state" value="#qry_qry_winner.pb_state#" />
                            <input type="hidden" name="raffle_winner_before_state" value="#qry_qry_winner_before.pb_state#" />
                            <input type="hidden" name="raffle_winner_after_state" value="#qry_qry_winner_after.pb_state#" />
                            
                            <input type="hidden" name="raffle_winner" value="#variables.winner#" />
                            <input type="hidden" name="raffle_winner_before" value="#variables.winner_before#" />
                            <input type="hidden" name="raffle_winner_after" value="#variables.winner_after#" />
                            <input type="hidden" name="winner_first" value="#qry_qry_winner.pb_first_name#" />
                            <input type="hidden" name="winner_last" value="#qry_qry_winner.pb_last_name#" />
                            <input type="hidden" name="winner_email" value="#qry_qry_winner.pb_email#" />
                            <input type="hidden" name="winner_before_first" value="#qry_qry_winner_before.pb_first_name#" />
                            <input type="hidden" name="winner_before_last" value="#qry_qry_winner_before.pb_last_name#" />
                            <input type="hidden" name="winner_before_email" value="#qry_qry_winner_before.pb_email#" />
                            <input type="hidden" name="winner_after_first" value="#qry_qry_winner_after.pb_first_name#" />
                            <input type="hidden" name="winner_after_last" value="#qry_qry_winner_after.pb_last_name#" />
                            <input type="hidden" name="winner_after_email" value="#qry_qry_winner_after.pb_email#" />
                        </cfform>        
                    </cfoutput> 
                </div                               
            </cfif>
        </cfif>                                    
    </cfif>

<cfinclude template="footer.cfm">