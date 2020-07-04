<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfinclude template="header.cfm">
<cfinclude template="tm_sidebar.cfm">

    <div class="container-fluid py-5">
        <h1>Raffle Number Gifts by "Family"</h1>
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
                                    
        <div class="card card-body">
            <div class="table-responsive">
                <table class="table table-sm">
                    <thead>
                        <tr>
                            <th>Family</th>
                            <th>Ticket Qty</th>
                            <th>Donation</th>
                        </tr>
                    </thead>
                    <tbody>
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
            
                                    <tr>
                                        <td><a href="pb_report_family.cfm?family=#URLEncodedFormat(selCurrentSource.pb_info_source)#">#selCurrentSource.pb_info_source#</a></td>
                                        <td>#qry_qry_raffle_numbers.RecordCount#</td>
                                        <cfset variables.donation_value = DollarFormat(qry_qry_raffle_numbers.RecordCount*25)>
                                        <td>#variables.donation_value#</td>
                                    </tr>
                                </cfif>										                                    
                            </cfif>
                            <cfset variables.source_name = selCurrentSource.pb_info_source>
                        </cfoutput>
                        <tr>
                            <td>Total value of all Current Raffle Numbers</td>
                            <td><cfoutput>#selUsedNumbers.RecordCount#</cfoutput></td>
                            <td><cfoutput>#DollarFormat(selUsedNumbers.RecordCount*25)#</cfoutput></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<cfinclude template="footer.cfm">