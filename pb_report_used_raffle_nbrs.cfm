<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

<cfset variables.today = DateFormat(now(),"yyyymmdd")>

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 112) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

    <div class="container-fluid bg-light-blue py-5">
        
        <h1>All Currently Used Raffle Numbers</h1>
        <h2>All Eligible Raffle Numbers (including next month)</h2>
        <p>All numbers in <span style="color:red">Red</span>, are not eligible until next month but have been assigned.</p>
        
        <cfquery name="selUsedNumbers" datasource="#request.datasource#">
            select [raffle_nbr],                               
                    convert(varchar(10), [pb_start_date], 112) as start_date,
                    convert(varchar(10), [pb_end_date], 112) as end_date
                from #variables.str_raffle#
                order by 1
        </cfquery>

        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-sm">
                    <tr>
                        <th>Raffle Nbr(s)</th>
                    </tr>
                    <cfoutput>
                    <tr>                                    
                        <td>
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
                    </tr>
                </table>
            </div>
        </div>

    </div>

<cfinclude template="footer.cfm">