<cftry>
    <cftransaction>
        <cfquery name="delDonor" datasource="#request.datasource#">
            delete from #variables.str_donor#
            where id = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
        </cfquery> 

        <cfquery name="delDonation" datasource="#request.datasource#">
            delete from #variables.str_donation#
            where id = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfquery name="delTerm" datasource="#request.datasource#">
            delete from #variables.str_term#
            where id = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfquery name="delFamily" datasource="#request.datasource#">
            delete from #variables.str_family#
            where id = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfquery name="delRaffleNbrs" datasource="#request.datasource#">
            delete from #variables.str_raffle#
            where id = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cftransaction>

    <cfif url.sender is "new">
        <cflocation url="pb_report_new.cfm?sort_order=#URLEncodedFormat(URL.sort_order)#" addtoken="no">
    <cfelseif url.sender is "current">
        <cflocation url="pb_report_current.cfm?sort_order=#URLEncodedFormat(URL.sort_order)#" addtoken="no">
    </cfif>
    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>