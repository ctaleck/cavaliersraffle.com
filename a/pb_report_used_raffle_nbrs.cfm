<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

<cfset variables.today = DateFormat(now(),"yyyymmdd")>

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 112) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">All Currently Used Raffle Numbers</strong></h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
                            
                            <cfquery name="selUsedNumbers" datasource="#request.datasource#">
                                select [raffle_nbr],                               
                                       convert(varchar(10), [pb_start_date], 112) as start_date,
                                       convert(varchar(10), [pb_end_date], 112) as end_date
                                  from #variables.str_raffle#
                                 order by 1
                            </cfquery>

                            <table border="1" cellpadding="2" cellspacing="0" align="center" width="170%">
                                <tr bgcolor="lightgrey">
                                    <th style="font-size:16px" align="center">All Eligible Raffle Numbers (including next month)</th>
                                </tr>
                                <tr bgcolor="lightgrey">
                                    <th>Raffle Nbr(s)</th>
                                </tr>
                                <cfoutput>
                                <tr style="text-align:left">                                    
                                    <td style="font-size:14px" width="100%">
                                        <cfset variables.howmany = selUsedNumbers.RecordCount>
                                        <cfset variables.count = 1>
                                        <cfloop query="#selUsedNumbers#">
                                            <cfif variables.howmany GT variables.count>
                                                <cfif selUsedNumbers.start_date GT variables.today>
													<span style="color:red">#selUsedNumbers.raffle_nbr#,</span>
												<cfelse>                                                
                                                	#selUsedNumbers.raffle_nbr#, 
                                                </cfif>
                                            <cfelse>
                                                <cfif selUsedNumbers.start_date GT variables.today>
													<span style="color:red">#selUsedNumbers.raffle_nbr#</span>
												<cfelse>                                                
                                                	#selUsedNumbers.raffle_nbr#
                                                </cfif>
                                            </cfif>
                                            <cfset variables.count = variables.count + 1>
                                        </cfloop>
                                    </td>
                                </tr>
                                </cfoutput>
                                <tr>
                                	<th style="font-size:14px" align="center">All numbers in <span style="color:red">Red</span>, are not eligible until next month but have been assigned!</th>
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