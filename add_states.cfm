<cfquery name="selStates" datasource="#request.datasource#">
    select abbrev,
           state_name
      from tbl_pb_states
      order by 1
</cfquery>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <cftransaction>
            <cfloop query="selStates">
                <cfquery name="insDonor" datasource="#request.datasource#">
                    insert into [tbl_cav_states]
                    	(abbrev, state_name)
                    values 
                    (
                        <cfqueryparam value="#selStates.abbrev#" cfsqltype="cf_sql_char">,
                        <cfqueryparam value="#selStates.state_name#" cfsqltype="cf_sql_char">
                    )
                </cfquery>     
            </cfloop>
        </cftransaction>
    
    </head>
    <body>DONE!</body>  
</html>