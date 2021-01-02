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
        <h1>Raffle Number Gifts by "Family"</h1>
        <h2>By Gift Giver (or Ticket Buyer)</h2>
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
                    convert(varchar(10), c.[pb_end_date], 101) as end_date,
                    f.[pb_phx_family_name],
                    f.[pb_phx_family_email]
                from #variables.str_donor# as a 
                inner join #variables.str_donation# as b on a.id = b.id 
                inner join #variables.str_term# as c on a.id = c.id
                left join #variables.str_family# as f on b.pb_donation_id = f.pb_donation_id
                where b.pb_donation_id = c.pb_donation_id                     
                and convert(varchar(10), c.[pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                and a.pb_info_source = <cfqueryparam value="#url.family#" cfsqltype="cf_sql_varchar">
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
                    <cfoutput>
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th>Donation</th>
                                <th>Ticket Qty</th>
                                <th>Gifted By</th>
                                <th>
                                    <a href="pb_report_family.cfm?sort_order=name&family=#URLEncodedFormat(url.family)#">Ticket Holder</a>
                                    <cfif variables.sort_display EQ "Ordered By Last Name, First Name"><span class="oi oi-sort-ascending"></span></cfif>
                                </th>
                                <th>
                                    <a href="pb_report_family.cfm?sort_order=start_date&family=#URLEncodedFormat(url.family)#">Start Date</a>
                                    <cfif variables.sort_display EQ "Ordered By Eligibility Start Date"><span class="oi oi-sort-ascending"></span></cfif>
                                </th>
                                <th>
                                    <a href="pb_report_family.cfm?sort_order=end_date&family=#URLEncodedFormat(url.family)#">End Date</a>
                                    <cfif variables.sort_display EQ "Ordered By Eligibility End Date"><span class="oi oi-sort-ascending"></span></cfif>
                                </th>
                                <th>
                                    <a href="pb_report_family.cfm?sort_order=family&family=#URLEncodedFormat(url.family)#">Family</a>
                                    <cfif variables.sort_display EQ "Ordered Parish Family (Source)"><span class="oi oi-sort-ascending"></span></cfif>
                                </th>
                                <th>Raffle Nbr(s)</th>
                            </tr>
                        </thead>
                    </cfoutput>
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
                                <td><a href="pb_report_details.cfm?ID=#URLEncodedFormat(selCurrentDonors.ID)#&pb_donation_id=#URLEncodedFormat(selCurrentDonors.pb_donation_id)#&pb_start_date=#URLEncodedFormat(selCurrentDonors.start_date)#"><span class="oi oi-pencil"></span></a></td>
                                <td>$#selCurrentDonors.pb_donation#</td>
                                <td>#selCurrentDonors.pb_ticket_number#</td>
                                <td>
                                    <cfif selCurrentDonors.pb_gift eq "Y">
                                         #selCurrentDonors.pb_phx_family_name#<br />
                                         #selCurrentDonors.pb_phx_family_email#
                                    <cfelse>
                                        &nbsp;
                                    </cfif>
                                </td>
                                <td>
                                    
                                    #selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#<br />
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
                                    <br />
                                    #selCurrentDonors.pb_email#<br />
                                    #selCurrentDonors.pb_phone#
                                </td>
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
                </table>
            </div>
        </div>
    </div>
<cfinclude template="footer.cfm">