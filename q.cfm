<cftry>
    <cfscript>
    data = {empName="James", age="26"};
    serializedStr = serializeJSON(data);
    writeoutput(serializedStr);
    </cfscript>
    <!--- Dump out the server scope. --->
<cfdump var="#SERVER#" />

<!--- Store the ColdFusion version. --->
<cfset strVersion = SERVER.ColdFusion.ProductVersion />

<!--- Store the ColdFusion level. --->
<cfset strLevel = SERVER.ColdFusion.ProductLevel />
    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>