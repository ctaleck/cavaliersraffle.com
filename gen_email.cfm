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

<cftry>
    <cfset variables.raffle_winner_state = form.raffle_winner_state>
    <cfset variables.raffle_winner_before_state = form.raffle_winner_before_state>
    <cfset variables.raffle_winner_after_state = form.raffle_winner_after_state>

    <cfset variables.raffle_winner = form.raffle_winner>
    <cfset variables.raffle_winner_before = form.raffle_winner_before>
    <cfset variables.raffle_winner_after = form.raffle_winner_after>

    <cfset variables.winner_email = form.winner_email>
    <cfset variables.winner_before_email = form.winner_before_email>
    <cfset variables.winner_after_email = form.winner_after_email>

    <cfset variables.winner_first = form.winner_first>
    <cfset variables.winner_before_first = form.winner_before_first>
    <cfset variables.winner_after_first = form.winner_after_first>
    
    <cfset variables.winner_last = Left(form.winner_last,1)>
    <cfset variables.winner_last_full = form.winner_last>
    <cfset variables.winner_before_last = Left(form.winner_before_last,1)>
    <cfset variables.winner_before_last_full = form.winner_before_last>
    <cfset variables.winner_after_last = Left(form.winner_after_last,1)>
    <cfset variables.winner_after_last_full = form.winner_after_last>

    <!--- Do a true query to get the matching ID to the winning raffle numbers --->
    <cfquery name="selGetDonors" datasource="#request.datasource#">
        select [id], [raffle_nbr]                                   
            from #variables.str_raffle#
            where raffle_nbr in (<cfqueryparam value="#variables.raffle_winner#" cfsqltype="cf_sql_integer">, <cfqueryparam value="#variables.raffle_winner_before#" cfsqltype="cf_sql_integer">, <cfqueryparam value="#variables.raffle_winner_after#" cfsqltype="cf_sql_integer">)
            order by 1
    </cfquery>
    
    <!--- Set the winning ID's to a list --->
    <cfset variables.winner_list = "">
    <cfloop query="selGetDonors">
        <cfset variables.winner_list = ListAppend(variables.winner_list,selGetDonors.ID)>
    </cfloop>

    <!--- Get the full contact info for all three winners --->
    <cfquery name="selWinningDonorInfo" datasource="#request.datasource#">
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

    <!--- Get the full spelling of the winner's home states --->
    <cfquery name="selStateNames" datasource="#request.datasource#">
        select [abbrev], [state_name]
            from #variables.str_states#
            order by 1
    </cfquery>

    <!--- Get the Current Month (as a number). The tag below spells out the full name of that month. --->
    <!--- #MonthAsString(cal_month)# --->
    <cfset cal_month=dateformat(now(), "m")>
    
    <!--- Get the Current Year --->
    <cfset variables.currentYear = #DateFormat(Now(),"YYYY")#>

    <!--- ****** Below is the list of all raffle entries that will expire after this current drawing ****** --->
    <cfset variables.today = DateFormat(now(),"yyyymmdd")>
    
    <cfquery name="sel_date_minus_thirty" datasource="#request.datasource#">
        SELECT DATEADD(d,-27,GETDATE()) as date_minus_thirty
    </cfquery>
    
    <cfset variables.today_minus_thirty = DateFormat(#sel_date_minus_thirty.date_minus_thirty#,"yyyymmdd")>
    
    <cfquery name="selCurrentDonors" datasource="#request.datasource#">
        select distinct a.[ID], 
                a.[pb_last_name], 
                a.[pb_first_name], 
                a.[pb_email], 
                a.[pb_phone], 
                a.[pb_address], 
                a.[pb_city], 
                a.[pb_state], 
                a.[pb_zipcode], 
                a.[pb_active],
                a.[pb_info_source],
                a.[pb_gift], 
                b.[pb_donation], 
                b.[pb_ticket_number], 
                b.[pb_payment_verified],
                b.[pb_donation_id],
                c.[pb_donation_id],
                convert(varchar(10), c.[pb_start_date], 112) as sort_start_date,
                convert(varchar(10), c.[pb_end_date], 112) as sort_end_date,
                convert(varchar(10), c.[pb_start_date], 101) as start_date,
                convert(varchar(10), c.[pb_end_date], 101) as end_date
            from #variables.str_donor# as a 
            inner join #variables.str_donation# as b on a.id = b.id 
            inner join #variables.str_term# as c on a.id = c.id
            where b.pb_donation_id = c.pb_donation_id
            and convert(varchar(10), c.[pb_end_date], 112) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
            and convert(varchar(10), c.[pb_end_date], 112) >= <cfqueryparam value="#variables.today_minus_thirty#" cfsqltype="cf_sql_varchar">
        order by
        <cfif IsDefined("variables.sort_by")>
            #variables.sort_by#
        <cfelse>
            a.id asc, b.pb_donation_id
        </cfif> 
    </cfquery> 
    
    <cfset variables.expired_email_list = "">
    <cfloop query="selCurrentDonors">
        <cfset variables.expired_email_list = ListAppend(variables.expired_email_list,selCurrentDonors.pb_email,", ")>
    </cfloop>
    <cfset variables.expired_email_list = ReReplace(variables.expired_email_list,",",", ","ALL")>
    <!--- ************************************************************************************************* --->


    <!--- ****** The following code is what generates the email report displayed as well as the email addresses that will be sent out ****** --->
    
    <!--- Do a true query to get the matching ID ALL raffle numbers (winners & non-winners) --->
    <cfquery name="selGetAllEntries" datasource="#request.datasource#">
        select [id], [raffle_nbr]                                   
            from #variables.str_raffle#
            order by 1
    </cfquery>
    
    <!--- Set the winning ID's to a list --->

    <cfset variables.non_winner_list = "">
    <cfloop query="selGetAllEntries">
        <cfset variables.non_winner_list = ListAppend(variables.non_winner_list,selGetAllEntries.ID)>
    </cfloop>

    <!--- Get the full contact info for all three winners --->
    <cfquery name="selNonWinningDonorInfo" datasource="#request.datasource#">
        select distinct [pb_email]
            from #variables.str_donor#
            where ID in (#variables.non_winner_list#)
        order by 1
    </cfquery> 

    <cfset variables.divider = ceiling(selNonWinningDonorInfo.recordcount/20)>
    <cfset startrow = 1>
    <cfset maxrows = ceiling(selNonWinningDonorInfo.recordcount/5)>

    <cfloop from="1" to="5" index="x">
        <cfset variables["nonWinningEmailList" & x] = "">
            <cfloop query="selNonWinningDonorInfo" startrow="#startrow#" endrow="#maxrows#">
                <cfset variables["nonWinningEmailList" & x] = ListAppend(variables["nonWinningEmailList" & x] ,selNonWinningDonorInfo.pb_email)>
                <cfset variables["nonWinningEmailList" & x]  = ReReplace(variables["nonWinningEmailList" & x] ,",",", ","ALL")>
            </cfloop>
        <cfset startrow = maxrows + 1>
        <cfset maxrows = startrow + maxrows>
    </cfloop>

    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>

    <cfoutput>
        <div class="container-fluid bg-light-blue py-5">
            <h1>Email Generation Report</h1>
            <div class="card card-body">
                <p>The following emails were generated and sent to the email addresses shown.</p>
                <table class="border-0">
                    <tr>
                        <th>Raffle Winner</th>
                    </tr>
                    <tr>
                        <td>#variables.winner_first# #variables.winner_last_full#<br />#variables.winner_email#</td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <th>Raffle Winner (Piggyback Before)</th>
                    </tr>
                    <tr>
                        <td>#variables.winner_before_first# #variables.winner_before_last_full#<br />#variables.winner_before_email#</td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <th>Raffle Winner (Piggyback After)</th>
                    </tr>
                    <tr>
                        <td>#variables.winner_after_first# #variables.winner_after_last_full#<br />#variables.winner_after_email#</td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <th>Notification to ALL (non-winning) Raffle Entries</th>
                    </tr>
                    <tr>
                        <td>#variables.nonWinningEmailList1# #variables.nonWinningEmailList2# #variables.nonWinningEmailList3# #variables.nonWinningEmailList4# #variables.nonWinningEmailList5#</td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <th>Notification to Office Treasurer and Raffle Coordinator</th>
                    </tr>
                    <tr>
                        <td>treasurer@olosa.org and cavaliersraffle@olosa.org</td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <th>An additional email was generated to everyone whose eligibility expires after today!</th>
                    </tr>
                    <tr>
                        <td>
                            <cfif Len(variables.expired_email_list)>
                                #variables.expired_email_list#
                            <cfelse>
                                There are no raffle numbers expiring before next month's drawing, so no email went out.
                            </cfif>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </cfoutput>

    <!--- *********************************************************************************************************************************** --->

    <!--- Send out the email notifications --->
    <cfoutput> 
        <cfinclude template="email_winner.cfm">
        <cfinclude template="email_winner_before.cfm">
        <cfinclude template="email_winner_after.cfm">
        <cfinclude template="email_winner_office.cfm">
        <cfif Len(variables.expired_email_list)>
            <cfinclude template="email_newly_expired.cfm">
        </cfif>
        <cfinclude template="email_winner_all_1.cfm">
        <cfinclude template="email_winner_all_2.cfm">
        <cfinclude template="email_winner_all_3.cfm">
        <cfinclude template="email_winner_all_4.cfm">
        <cfinclude template="email_winner_all_5.cfm">
    </cfoutput>

<cfinclude template="footer.cfm">

