<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="js/rusure.js">

<cfinclude template="header.cfm">

<cfinclude template="tm_sidebar.cfm">

<cfif IsDefined("url.sort_order")>
	<cfif url.sort_order is "name">
		<cfset variables.sort_order = "name">
		<cfset variables.sort_by = "a.pb_last_name, a.pb_first_name">
		<cfset variables.sort_display = "Ordered By Last Name, First Name">
	<cfelseif url.sort_order is "start_date">
		<cfset variables.sort_order = "start_date">
		<cfset variables.sort_by = "sort_start_date">
		<cfset variables.sort_display = "Ordered By Eligibility Start Date">
	<cfelseif url.sort_order is "end_date">
		<cfset variables.sort_order = "end_date">
		<cfset variables.sort_by = "sort_end_date">
		<cfset variables.sort_display = "Ordered By Eligibility End Date">
	<cfelseif url.sort_order is "id">
		<cfset variables.sort_order = "id">
		<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
		<cfset variables.sort_display = "Ordered Registration ID">
	<cfelseif url.sort_order is "family">
		<cfset variables.sort_order = "pb_info_source">
		<cfset variables.sort_by = "a.pb_info_source">
		<cfset variables.sort_display = "Ordered Parish Family (Source)">
	</cfif>
<cfelse>
	<cfset variables.sort_order = "id">
	<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
	<cfset variables.sort_display = "Ordered Registration ID">
</cfif>

    <div class="container-fluid bg-light-blue py-5">
        <h1>All Entries with Raffle Numbers</h1>
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
                    convert(varchar(10), c.[pb_start_date], 111) as sort_start_date,
                    convert(varchar(10), c.[pb_end_date], 111) as sort_end_date,
                    convert(varchar(10), c.[pb_start_date], 101) as start_date,
                    convert(varchar(10), c.[pb_end_date], 101) as end_date
                from #variables.str_donor# as a 
                inner join #variables.str_donation# as b on a.id = b.id 
                inner join #variables.str_term# as c on a.id = c.id
                where b.pb_donation_id = c.pb_donation_id                     
                and convert(varchar(10), c.[pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
            order by
            <cfif IsDefined("variables.sort_by")>
                #variables.sort_by#
            <cfelse>
                a.id asc, b.pb_donation_id
            </cfif> 
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
                            <th>
                                <a href="pb_report_current.cfm?sort_order=name">Name</a>
                                <cfif variables.sort_display EQ "Ordered By Last Name, First Name"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Ticket Qty</th>
                            <th>Donation</th>
                            <th>
                                <a href="pb_report_current.cfm?sort_order=start_date">Start Date</a>
                                <cfif variables.sort_display EQ "Ordered By Eligibility Start Date"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>
                                <a href="pb_report_current.cfm?sort_order=end_date">End Date</a>
                                <cfif variables.sort_display EQ "Ordered By Eligibility End Date"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>
                                <a href="pb_report_current.cfm?sort_order=family">Family</a>
                                <cfif variables.sort_display EQ "Ordered Parish Family (Source)"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>Raffle Nbr(s)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfoutput query="selCurrentDonors">
                            <cfquery name="qry_qry_raffle_numbers_exist" dbtype="query">
                                select raffle_nbr
                                    from selUsedNumbers
                                    where ID = #selCurrentDonors.ID#
                                    and start_date = '#selCurrentDonors.start_date#'
                                    order by 1
                            </cfquery>
                            <cfif qry_qry_raffle_numbers_exist.RecordCount GT 0>
                                <tr>
                                    
                                    <cfset confirmation_1="This will remove all records of this entry, including raffle numbers.\n\nAre your sure you want to continue?">
                                    <cfset surl_1="delete_records.cfm?ID=#URLEncodedFormat(selCurrentDonors.ID)#&start_date=#URLEncodedFormat(selCurrentDonors.start_date)#&sender=current&sort_order=#URLEncodedFormat(variables.sort_order)#">
                                                                    
                                    <td><a href="javascript:rusure('#surl_1#','#confirmation_1#')"><span class="oi oi-trash"></span></a></td>
                                    <td><a href="pb_report_details.cfm?ID=#URLEncodedFormat(selCurrentDonors.ID)#&pb_donation_id=#URLEncodedFormat(selCurrentDonors.pb_donation_id)#&pb_start_date=#URLEncodedFormat(selCurrentDonors.start_date)#"><span class="oi oi-pencil"></span></a></td>
                                    <td>#selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#
                                    <cfif selCurrentDonors.pb_gift eq "Y">
                                        🎁
                                    </cfif>
                                    </td>
                                        <td>
                                            #selCurrentDonors.pb_address#<br />
                                            <cfif selCurrentDonors.pb_city is "">
                                                &nbsp;
                                            <cfelse>
                                                #selCurrentDonors.pb_city#,
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
                                    <td>#selCurrentDonors.pb_ticket_number#</td>
                                    <td>$#selCurrentDonors.pb_donation#</td>
                                    <td>
                                        #selCurrentDonors.start_date#
                                    </td>
                                    <td>
                                        #selCurrentDonors.end_date#
                                    </td>
                                    <td>#selCurrentDonors.pb_info_source#</td>
                                    <cfquery name="qry_qry_raffle_numbers" dbtype="query">
                                        select raffle_nbr
                                            from selUsedNumbers
                                            where ID = #selCurrentDonors.ID#
                                            and start_date = '#selCurrentDonors.start_date#'
                                            order by 1
                                    </cfquery>
                                    <td>
                                        <cfset variables.howmany = qry_qry_raffle_numbers.RecordCount>
                                        <cfset variables.count = 1>
                                        <cfloop query="#qry_qry_raffle_numbers#">
                                            <cfif variables.howmany GT variables.count>
                                                #qry_qry_raffle_numbers.raffle_nbr#, 
                                            <cfelse>
                                                #qry_qry_raffle_numbers.raffle_nbr# 
                                            </cfif>
                                            <cfset variables.count = variables.count + 1>
                                        </cfloop>
                                    </td>    
                                </tr>
                            </cfif>
                        </cfoutput>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<cfinclude template="footer.cfm">