<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">

<cfinclude template="tm_sidebar.cfm">

<cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>

<!--- Delete from the current raffle ticket list, any ticket numbers that are expired. --->
<cfquery name="delExpiredNumbers" datasource="#request.datasource#">
	delete from #variables.str_raffle#
	 where convert(varchar(10), [pb_end_date], 111) < <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
</cfquery>

    <div class="container-fluid py-5">
        <h1>All Eligible Raffle Numbers</h1>
        <cfset variables.today = DateFormat(now(),"yyyy/mm/dd")>
        
        <cfquery name="selUsedNumbers" datasource="#request.datasource#">
            select [raffle_nbr]                                   
                from #variables.str_raffle#
                where convert(varchar(10), [pb_start_date], 111) <= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                and convert(varchar(10), [pb_end_date], 111) >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_varchar">
                order by 1
        </cfquery>

        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-sm">
                <thead>
                    <tr>
                        <th>Raffle Nbr(s)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <cfoutput>
                    <tr>                                    
                        <td>
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<cfinclude template="footer.cfm">