<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 111) < <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">All Eligible Raffle Numbers</strong></h2>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
                            
                            <cfquery name="selUsedNumbers" datasource="#request.datasource#">
                                select [raffle_nbr]                                   
                                  from #variables.str_raffle#
                                 where convert(varchar(10), [pb_start_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                                   and convert(varchar(10), [pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                                 order by 1
                            </cfquery>

                            <table border="1" cellpadding="2" cellspacing="0" align="center" width="170%">
                                <tr bgcolor="lightgrey">
                                    <th style="font-size:16px" align="center">All Eligible Raffle Numbers</th>
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
                                                #selUsedNumbers.raffle_nbr#, 
                                            <cfelse>
                                                #selUsedNumbers.raffle_nbr# 
                                            </cfif>
                                            <cfset variables.count = variables.count + 1>
                                        </cfloop>
                                    </td>
                                </tr>
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