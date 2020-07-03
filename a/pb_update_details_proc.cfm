<cfif Not IsDefined("session.activepswd")>	
	<cflocation url="admin.cfm" addtoken="no">
</cfif>

<cfif form.formValidator NEQ session.formValidator>
	<cflocation url="oops-error.cfm" addtoken="no">
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <cfif Not Len(form.pb_email) AND Not Len(form.pb_phone) AND Not Len(form.pb_address)>
            <cfset variables.error_msg = "You must provide an email address OR phone number OR mailing address so you can notify the winner!">
        </cfif>
        
		<cfif Len(form.pb_phone)>
        	<cfif form.pb_phone contains "(">
            	<cfset form.pb_phone = Replace(form.pb_phone,"(","","ALL")>
            	<cfset form.pb_phone = Replace(form.pb_phone,") ","-","ALL")>
            </cfif>
        </cfif>
        
        <cfif Len(form.pb_phone)>
            <cfif form.pb_phone contains "-">
                <cfset variables.phone_formatted = form.pb_phone>
            <cfelse>
                <cfset variables.phone=form.pb_phone>
                <cfscript>
                    areacode = left(variables.phone, 3);
                    firstthree = mid(variables.phone, 4, 3);
                    lastfour = right(variables.phone, 4);
                </cfscript>
                <cfoutput>
                    <cfset variables.phone_formatted = "#areacode#-#firstthree#-#lastfour#">
                </cfoutput>
            </cfif>
        <cfelse>
            <cfset variables.phone_formatted = "NA">
        </cfif>
        
        <cfif IsDefined("variables.error_msg")>
            <cfoutput>
                <script language="JavaScript1.2">
                    alert("#variables.error_msg#")
                    history.go(-1)   
                </script>
            </cfoutput>
            <cfabort> 
        </cfif>
    </head>

	<cftransaction>
        <cfquery name="UpdateDonors" datasource="#request.datasource#">
            update #variables.str_donor#
               set pb_first_name = <cfqueryparam value="#form.pb_first_name#" cfsqltype="cf_sql_varchar">,
                   pb_last_name = <cfqueryparam value="#form.pb_last_name#" cfsqltype="cf_sql_varchar">,
                   pb_email = <cfqueryparam value="#form.pb_email#" cfsqltype="cf_sql_varchar">,
                   pb_phone = <cfqueryparam value="#variables.phone_formatted#" cfsqltype="cf_sql_varchar">,
                   pb_address = <cfqueryparam value="#form.pb_address#" cfsqltype="cf_sql_varchar">,
                   pb_city = <cfqueryparam value="#form.pb_city#" cfsqltype="cf_sql_varchar">,
                   pb_state = <cfqueryparam value="#form.pb_state#" cfsqltype="cf_sql_varchar">,
                   pb_zipcode = <cfqueryparam value="#form.pb_zipcode#" cfsqltype="cf_sql_varchar">
             where [ID] = #form.id#
        </cfquery> 
    </cftransaction>
                                                        
<cflocation url="pb_report_current.cfm" addtoken="no">

