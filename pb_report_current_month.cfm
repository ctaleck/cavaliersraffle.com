<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

<cfif IsDefined("url.sort_order")>
	<cfif url.sort_order is "name">
		<cfset variables.sort_by = "a.pb_last_name, a.pb_first_name">
		<cfset variables.sort_display = "Ordered By Last Name, First Name">
	<cfelseif url.sort_order is "start_date">
		<cfset variables.sort_by = "sort_start_date">
		<cfset variables.sort_display = "Ordered By Eligibility Start Date">
	<cfelseif url.sort_order is "end_date">
		<cfset variables.sort_by = "sort_end_date">
		<cfset variables.sort_display = "Ordered By Eligibility End Date">
	</cfif>
<cfelse>
	<cfset variables.sort_order = "">
	<cfset variables.sort_by = "a.pb_last_name asc, b.pb_donation_id">
	<cfset variables.sort_display = "Ordered Registration ID">
</cfif>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Entries Eligible "Next Month"</strong></h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
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
                                       convert(varchar(10), c.[pb_start_date], 112) as sort_start_date,
                                       convert(varchar(10), c.[pb_end_date], 112) as sort_end_date,
                                       convert(varchar(10), c.[pb_start_date], 101) as start_date,
                                       convert(varchar(10), c.[pb_end_date], 101) as end_date
                                  from #variables.str_donor# as a 
                                 inner join #variables.str_donation# as b on a.id = b.id 
                                 inner join #variables.str_term# as c on a.id = c.id
                                 where b.pb_donation_id = c.pb_donation_id                     
                                   and convert(varchar(10), c.[pb_start_date], 111) > <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
								order by
								<cfif IsDefined("variables.sort_by")>
                                    #variables.sort_by#
                                <cfelse>
                                    a.pb_last_name asc, b.pb_donation_id
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

                            <table border="1" cellpadding="2" cellspacing="0" align="center" width="170%">
                                <tr bgcolor="lightgrey">
                                    <th style="font-size:16px" align="center" colspan="9">New Donors Not Yet Eligible for Drawing&nbsp;&nbsp;<span style="color:teal"><cfoutput>(#variables.sort_display#)</cfoutput></span></th>
                                </tr>
                                <tr bgcolor="lightgrey">
                                    <!--- <th>Donor ID</th> --->
                                    <th><a href="pb_report_current_month.cfm?sort_order=name">Name</a></th>
                                    <th>Address</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Ticket Qty</th>
                                    <th>Donation</th>
                                    <th><a href="pb_report_current_month.cfm?sort_order=start_date">Start Date</a></th>
                                    <th><a href="pb_report_current_month.cfm?sort_order=end_date">End Date</a></th>
                                    <th>Raffle Nbr(s)</th>
                                </tr>
                                <cfif selCurrentDonors.RecordCount is 0>
                                	<tr>
                                    	<td style="font-size:20px; text-align:center" colspan="9">There are no Donor Entries that are not yet eligible for the Raffle!</td>
                                    </tr>
                                <cfelse>
									<cfoutput query="selCurrentDonors">
                                        <tr style="text-align:left">                                    
                                            <!--- <td style="font-size:12px; text-align:center">#selCurrentDonors.ID#</td> --->
                                            <td style="font-size:12px">#selCurrentDonors.pb_first_name#&nbsp;#selCurrentDonors.pb_last_name#</td>
                                            <td style="font-size:12px; text-align:left">
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
                                            <td style="font-size:12px">#selCurrentDonors.pb_email#</td>
                                            <td style="font-size:12px">#selCurrentDonors.pb_phone#</td>
                                            <td style="font-size:12px; text-align:center">#selCurrentDonors.pb_ticket_number#</td>
                                            <td style="font-size:12px; text-align:center">$#selCurrentDonors.pb_donation#</td>
                                            <td style="font-size:12px; text-align:center"">
                                                #selCurrentDonors.start_date#
                                            </td>
                                            <td style="font-size:12px; text-align:center"">
                                                #selCurrentDonors.end_date#
                                            </td>
                                            <cfquery name="qry_qry_raffle_numbers" dbtype="query">
                                                select raffle_nbr
                                                  from selUsedNumbers
                                                 where ID = #selCurrentDonors.ID#
                                                   and start_date = '#selCurrentDonors.start_date#'
                                                 order by 1
                                            </cfquery>
                                            <td>&nbsp;
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
                                    </cfoutput>
                                </cfif>
                            </table>
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