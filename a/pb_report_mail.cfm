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
	<cfelseif url.sort_order is "zipcode">
		<cfset variables.sort_by = "pb_zipcode">
		<cfset variables.sort_display = "Ordered By Zipcode">
	</cfif>
<cfelse>
	<cfset variables.sort_order = "">
	<cfset variables.sort_by = "a.id asc, b.pb_donation_id">
	<cfset variables.sort_display = "Ordered Registration ID">
</cfif>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Mail Chimp Report</strong></h2>
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

                            <table border="1" cellpadding="2" cellspacing="0" align="center" width="170%">
                                <tr bgcolor="lightgrey">
                                    <th style="font-size:16px" align="center" colspan="9">Current Raffle Entries&nbsp;&nbsp;<span style="color:teal"><cfoutput>(#variables.sort_display#)</cfoutput></span></th>
                                </tr>
                                <tr bgcolor="lightgrey">
                                    <th>Raffle Nbr(s)</th>
                                    <th><a href="pb_report_mail.cfm?sort_order=start_date">Start Date</a></th>
                                    <th><a href="pb_report_mail.cfm?sort_order=end_date">End Date</a></th>
                                    <th>First Name</th>
                                    <th><a href="pb_report_mail.cfm?sort_order=name">Last Name</a></th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th><a href="pb_report_mail.cfm?sort_order=zipcode">Zipcode</a></th>
                                </tr>
                                <cfoutput query="selCurrentDonors">
                                    <cfquery name="qry_qry_raffle_numbers_exist" dbtype="query">
                                        select raffle_nbr
                                          from selUsedNumbers
                                         where ID = #selCurrentDonors.ID#
                                           and start_date = <cfqueryparam value="#selCurrentDonors.start_date#" cfsqltype="cf_sql_varchar">
                                         order by 1
                                    </cfquery>
                                    <cfif qry_qry_raffle_numbers_exist.RecordCount GT 0>
                                        <tr style="text-align:left">                                    
                                            <cfquery name="qry_qry_raffle_numbers" dbtype="query">
                                                select raffle_nbr
                                                  from selUsedNumbers
                                                 where ID = #selCurrentDonors.ID#
                                                   and start_date = <cfqueryparam value="#selCurrentDonors.start_date#" cfsqltype="cf_sql_varchar">
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
                                            <td style="font-size:12px; text-align:center"">
                                            	<!--- This process determines the actual drawing date for display in the MailChimp report --->
                                                <!--- 
													The process is that the drawing date will be the first Friday of the month, except when that first Friday is the first ex: 09/01/2018
													In that case, it would be the NEXT Friday.
												--->
                                                <cfset variables.start_month = ListFirst(selCurrentDonors.start_date,"/")>
                                                <cfset variables.start_day = 01>
                                                <cfset variables.start_year = ListLast(selCurrentDonors.start_date,"/")>
                                                
												<cfset variables.start_yourDate = CreateDate(variables.start_year, variables.start_month, variables.start_day)> 
                                            
                                                <cfif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Monday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 4>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Tuesday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 3>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Wednesday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 2>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Thursday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 1>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Friday">
                                                    <cfset variables.start_NextFriday = variables.start_day>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Saturday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 6>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Sunday">
                                                    <cfset variables.start_NextFriday = variables.start_day + 5>
                                                </cfif>
                                            
                                                <cfset variables.start_NextDate = dateformat(variables.start_month & "/" & variables.start_NextFriday & "/" & variables.start_year,"mm/dd/yyyy")>
                                                #variables.start_NextDate#
                                            </td>
                                            <td style="font-size:12px; text-align:center"">
                                            	<!--- This process determines the actual drawing date for display in the MailChimp report --->
                                                <!--- 
													The process is that the drawing date will be the first Friday of the month, except when that first Friday is the first ex: 09/01/2018
													In that case, it would be the NEXT Friday.
												--->
                                                <cfset variables.end_month = ListFirst(selCurrentDonors.end_date,"/")>
                                                <cfset variables.end_day = 01>
                                                <cfset variables.end_year = ListLast(selCurrentDonors.end_date,"/")>
                                                
												<cfset variables.end_yourDate = CreateDate(variables.end_year, variables.end_month, variables.end_day)> 
                                            
                                                <cfif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Monday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 4>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Tuesday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 3>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Wednesday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 2>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Thursday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 1>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Friday">
                                                    <cfset variables.end_NextFriday = variables.end_day>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Saturday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 6>
                                                <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Sunday">
                                                    <cfset variables.end_NextFriday = variables.end_day + 5>
                                                </cfif>
                                            
                                                <cfset variables.end_NextDate = dateformat(variables.end_month & "/" & variables.end_NextFriday & "/" & variables.end_year,"mm/dd/yyyy")>
                                                #variables.end_NextDate#
                                            </td>
                                            <td style="font-size:12px">#selCurrentDonors.pb_first_name#</td>
                                            <td style="font-size:12px">#selCurrentDonors.pb_last_name#</td>
                                            <td style="font-size:12px">#selCurrentDonors.pb_email#</td>
                                            <td style="font-size:12px; white-space:nowrap">#selCurrentDonors.pb_phone#</td>
                                            <td style="font-size:12px; text-align:left">
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
                                            <td style="font-size:12px; text-align:center">
                                            	<cfif selCurrentDonors.pb_zipcode is 0>
                                                	&nbsp;
                                                <cfelse>
                                            		#selCurrentDonors.pb_zipcode#
                                                </cfif>
                                            </td>
                                        </tr>
                                	</cfif>
								</cfoutput>
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