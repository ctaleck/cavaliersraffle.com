<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

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
	</cfif>
<cfelse>
	<cfset variables.sort_order = "id">
	<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
	<cfset variables.sort_display = "Ordered Registration ID">
</cfif>

    <div class="container-fluid bg-light-blue py-5">
        <h1>Entries Expired in the last 30 Days</h1>
        <h2>Current Raffle Entries</h2>
        <cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>

        <cfquery name="sel_date_minus_thirty" datasource="#request.datasource#">
            SELECT DATEADD(d,-27,GETDATE()) as date_minus_thirty
        </cfquery>
        
        <cfset variables.today_minus_thirty = DateFormat(#sel_date_minus_thirty.date_minus_thirty#,"yyyy/mm/dd")>

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
                and convert(varchar(10), c.[pb_end_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                and convert(varchar(10), c.[pb_end_date], 111) >= <cfqueryparam value="#variables.today_minus_thirty#" cfsqltype="cf_sql_varchar">                                  
            order by
            <cfif IsDefined("variables.sort_by")>
                #variables.sort_by#
            <cfelse>
                a.id asc, b.pb_donation_id
            </cfif> 
        </cfquery> 

        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead>
                        <tr>
                            <th>
                                <a href="pb_report_newly_expired.cfm?sort_order=name">Name</a>
                                <cfif variables.sort_display EQ "Ordered By Last Name, First Name"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Ticket Qty</th>
                            <th>Donation</th>
                            <th>
                                <a href="pb_report_newly_expired.cfm?sort_order=start_date">Start Date</a>
                                <cfif variables.sort_display EQ "Ordered By Eligibility Start Date"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                            <th>
                                <a href="pb_report_newly_expired.cfm?sort_order=end_date">End Date</a>
                                <cfif variables.sort_display EQ "Ordered By Eligibility End Date"><span class="oi oi-sort-ascending"></span></cfif>
                            </th>
                        </tr>
                    </thead>
                    <cfif selCurrentDonors.RecordCount is 0>                                
                        <tr>
                            <td colspan="8">No Entries expired in the last 30 days!</td>
                        </tr>
                    <cfelse>
                        <cfoutput query="selCurrentDonors">
                            <tr>											
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
                                <td >#selCurrentDonors.pb_ticket_number#</td>
                                <td >$#selCurrentDonors.pb_donation#</td>
                                <td>
                                    #selCurrentDonors.start_date#
                                </td>
                                <td>
                                    #selCurrentDonors.end_date#
                                </td>
                            </tr>
                        </cfoutput>
                    </cfif>
                </table>
            </div>
        </div>
    </div>
<cfinclude template="footer.cfm">