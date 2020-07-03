<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Raffle Number Gifts by "Family"</h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
                            
                            <cfquery name="selCurrentDonors" datasource="#request.datasource#">
                                select Ltrim(Rtrim(a.[pb_info_source])) as pb_info_source,
                                       a.[id]
                                  from #variables.str_donor# as a 
                                 inner join #variables.str_term# as c on a.id = c.id
                                 where convert(varchar(10), c.[pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
								order by a.pb_info_source
                            </cfquery>

                            <cfquery name="selCurrentSource" datasource="#request.datasource#">
                                select Ltrim(Rtrim(a.[pb_info_source])) as pb_info_source
                                  from #variables.str_donor# as a 
                                 inner join #variables.str_term# as c on a.id = c.id
                                 where convert(varchar(10), c.[pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                                order by a.pb_info_source
                            </cfquery>
                            
                            <cfquery name="selUsedNumbers" datasource="#request.datasource#">
                                select [ID],
                                	   [raffle_nbr]                                   
                                  from #variables.str_raffle#
                                 order by 1
                            </cfquery>                                                        
							                           
                            <table border="1" cellpadding="2" cellspacing="0" align="center">
                                <tr bgcolor="lightgrey">
                                    <th style="font-size:16px" align="center" colspan="3">Raffle Number Gifts by "Family"</th>
                                </tr>
                                <tr bgcolor="lightgrey">
                                    <th>Family</th>
                                    <th>Ticket Qty</th>
                                    <th>Donation</th>
                                </tr>

								<cfset variables.source_name = "">
								<cfoutput query="selCurrentSource">
                                	<cfif Trim(selCurrentSource.pb_info_source) IS NOT Trim(variables.source_name)>
                                        <cfquery name="qry_qry_donor_ids" dbtype="query">
                                            select ID
                                              from selCurrentDonors
                                             where pb_info_source = '#selCurrentSource.pb_info_source#'
                                             order by 1
                                        </cfquery>
                                       
                                        <cfif qry_qry_donor_ids.RecordCount GT 0>
											<cfset variables.donor_list = "">                                        
                                            <cfloop query="qry_qry_donor_ids">
                                                <cfset variables.donor_list = ListAppend(variables.donor_list,qry_qry_donor_ids.ID)>
                                            </cfloop>
                                        
                                            <cfquery name="qry_qry_raffle_numbers" dbtype="query">
                                                select raffle_nbr
                                                  from selUsedNumbers
                                                 where ID in (#variables.donor_list#)
                                                 order by 1
                                            </cfquery>                                            

                                            <tr style="text-align:left">
                                                <td style="font-size:12px"><a href="pb_report_family.cfm?family=#URLEncodedFormat(selCurrentSource.pb_info_source)#">#selCurrentSource.pb_info_source#</a></td>
                                                <td style="font-size:12px; text-align:center">#qry_qry_raffle_numbers.RecordCount#</td>
                                                <cfset variables.donation_value = DollarFormat(qry_qry_raffle_numbers.RecordCount*25)>
                                                <td style="font-size:12px; text-align:right">#variables.donation_value#</td>
                                            </tr>
                                        </cfif>										                                    
                                    </cfif>
	                                <cfset variables.source_name = selCurrentSource.pb_info_source>
								</cfoutput>
                                <tr>
                                	<td style="font-size:12px; text-align:left">Total value of all Current Raffle Numbers</td>
                                	<td style="font-size:12px; text-align:center"><cfoutput>#selUsedNumbers.RecordCount#</cfoutput></td>
                                	<td style="font-size:12px; text-align:right"><cfoutput>#DollarFormat(selUsedNumbers.RecordCount*25)#</cfoutput></td>
                                </tr>
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