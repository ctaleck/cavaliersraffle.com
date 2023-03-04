<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="js/rusure.js">
<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

<cfif IsDefined("sort_order")>
		<!--- Don't change a thing.  Just have this variable coming back from the delete screen and we'll keep the same sort order. --->
		<cfset variables.sort_order = "id">
		<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
		<cfset variables.sort_display = "Ordered Registration ID">
<cfelse>
		<cfset variables.sort_order = "id">
		<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
		<cfset variables.sort_display = "Ordered Registration ID">
</cfif>

    <div class="container-fluid bg-light-blue py-5">
        <h1>Entries Needing Raffle Numbers</h1>
        <h2>New Donors Not Yet Eligible for Drawing</h2>
        <cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
        
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
                    convert(varchar(10), c.[pb_start_date], 101) as start_date,
                    convert(varchar(10), c.[pb_end_date], 101) as end_date
                from #variables.str_donor# as a 
                inner join #variables.str_donation# as b on a.id = b.id 
                inner join #variables.str_term# as c on a.id = c.id
                where b.pb_donation_id = c.pb_donation_id                     
                and convert(varchar(10), c.[pb_start_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                order by #variables.sort_by#
        </cfquery> 

        <cfquery name="selUsedNumbers" datasource="#request.datasource#">
            select [ID],
                    [raffle_nbr],                                      
                    [pb_donation_id],                                      
                    convert(varchar(10), [pb_start_date], 101) as start_date,                                      
                    convert(varchar(10), [pb_end_date], 101) as end_date                                   
                from #variables.str_raffle#
                order by 2, 3
        </cfquery>

        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>Donor ID</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Sponsor</th>
                            <th>Ticket Qty</th>
                            <th>Donation</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Raffle Nbr(s)</th>
                        </tr>
                    </thead>
                        <tbody>
                            <cfoutput query="selCurrentDonors">
                                <cfquery name="qry_qry_raffle_numbers_exist" dbtype="query">
                                    select raffle_nbr
                                        from selUsedNumbers
                                        where ID = #selCurrentDonors.ID#
                                        and start_date = <cfqueryparam value="#selCurrentDonors.start_date#" cfsqltype="cf_sql_varchar">
                                        order by 1
                                </cfquery>
                                <cfif qry_qry_raffle_numbers_exist.RecordCount is 0>
                                    <tr>                                    
                                        <cfset confirmation_1="This will remove all records of this entry.\n\nAre your sure you want to continue?">
                                        <cfset surl_1="delete_records.cfm?ID=#URLEncodedFormat(selCurrentDonors.ID)#&start_date=#URLEncodedFormat(selCurrentDonors.start_date)#&sender=new&sort_order=#URLEncodedFormat(variables.sort_order)#">
                                                                        
                                        <td><a href="javascript:rusure('#surl_1#','#confirmation_1#')"><span class="oi oi-trash"></span></a></td>
                                        <td><a href="pb_report_details.cfm?ID=#URLEncodedFormat(selCurrentDonors.ID)#&pb_donation_id=#URLEncodedFormat(selCurrentDonors.pb_donation_id)#&pb_start_date=#URLEncodedFormat(selCurrentDonors.start_date)#"><span class="oi oi-pencil"></span></a></td>
                                        <td>#selCurrentDonors.ID#</td>
                                        <td>#selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#
                                        <cfif selCurrentDonors.pb_gift eq "Y">
                                            🎁
                                        </cfif>
                                    </td>
                                        <td>
                                            #selCurrentDonors.pb_address#&nbsp;
                                            <cfif selCurrentDonors.pb_city is "">
                                                &nbsp;
                                            <cfelse>
                                                <br />#selCurrentDonors.pb_city#,
                                            </cfif>
                                            #selCurrentDonors.pb_state#&nbsp;
                                            <cfif selCurrentDonors.pb_zipcode is 0>
                                                &nbsp;
                                            <cfelse>
                                                #selCurrentDonors.pb_zipcode#
                                            </cfif>
                                        </td>
                                        <td>#selCurrentDonors.pb_email#</td>
                                        <td>#selCurrentDonors.pb_phone#</td>
                                        <td>#selCurrentDonors.pb_info_source#</td>
                                        <td>#selCurrentDonors.pb_ticket_number#</td>
                                        <td>$#selCurrentDonors.pb_donation#</td>
                                        <td>
                                            #selCurrentDonors.start_date#
                                        </td>
                                        <td>
                                            #selCurrentDonors.end_date#
                                        </td>
                                        <td>&nbsp;</td>    
                                    </tr>
                                </cfif>
                            </cfoutput>
                        </tbody>
                </table>
            </div>
        </div>
    </div>

<cfinclude template="footer.cfm">