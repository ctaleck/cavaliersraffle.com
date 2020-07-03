<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <cfset variables.new_number = 0>
    <cftransaction>
  		<cfloop index="i" from="1" to="1000">
            <cfquery name="insDonor" datasource="#request.datasource#">
                insert into [#variables.str_pool#]
                       (raffle_nbr)
               values (
                        <cfset variables.new_number = variables.new_number + 1>
                         <cfqueryparam value="#variables.new_number#" cfsqltype="cf_sql_integer">
               )
            </cfquery>     
	    </cfloop>
    </cftransaction>

	</head>
  	<body>DONE!</body>  
  </html>