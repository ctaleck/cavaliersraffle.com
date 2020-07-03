<cfif ParameterExists(form.formValidator)>
	<cfif form.formValidator NEQ session.formValidator>
        <cflocation url="oops-error.cfm" addtoken="no">
    </cfif>
</cfif>

<cfif IsDefined("session.activepswd")>
	<cflocation url="tm_index.cfm" addtoken="no">
</cfif>

<cfquery name="sel_id" datasource="#request.datasource#">
	select distinct logon_id
	  from [logon_access]
	 where 1=1
	 and logon_id <> 'View'
     and site_source = 'Cavaliers'
 	order by 1
 </cfquery> 

<cflock scope="SESSION" timeout="30" type="READONLY">
	<cfif IsDefined("session.ErrorCount") and session.ErrorCount is 3>
		<script language="JavaScript1.2">
			alert("Since you have entered an incorrect password three times you\nmust close your browser and reopen it before attempting again.")
			history.go(-2)
		</script>			
		<cfabort>		
	</cfif>
</cflock>

<cfif IsDefined("form.logon_id")>
	<cfset variables.logon_id = lcase(form.logon_id)>
	<cfset variables.passwd = lcase(form.passwd)>
	
	<cfquery name="validate" datasource="#request.datasource#">
		select logon_id, passwd 
		  from [logon_access]
		 where logon_id = '#variables.logon_id#' 
		   and passwd = '#variables.passwd#'
	</cfquery> 
	
	<cflock scope="SESSION" timeout="30" type="EXCLUSIVE">
		<cfif NOT IsDefined("session.ErrorCount")>						
			<cfset session.ErrorCount = 0>
		</cfif>
	</cflock>
	
	<cfif validate.RecordCount is 1>
		<cfset session.activepswd = variables.passwd>
		<cflocation url="tm_index.cfm" addtoken="no">
	<cfelse>
		<cflock scope="SESSION" timeout="30" type="EXCLUSIVE">
			<cfset session.ErrorCount = session.ErrorCount + 1>
		</cflock>
		<script language="JavaScript1.2">
			alert("Sorry,\nIncorrect Password.")
			history.go(-1)
		</script>			
		<cfabort>		
	</cfif>
</cfif>

<cfinclude template="header.cfm">
<body onLoad="document.logon.passwd.focus();">
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Piggyback Registration</strong></h2>
						<p class="meta">Please fill out the form below completely! ALL fields are Required!</p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
                            <cfform name="logon" action="admin.cfm" method="post">
                                <table align="center" border="0" cellpadding="1" cellspacing="0">
                                    <tr align="center">
                                        <th>Destination</th>
                                        <th>Password</th>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <cfselect name="logon_id"
                                                      size="1"
                                                      required="Yes"
                                                      message="Logon_id is Required"
                                                      query="sel_id"
                                                      value="logon_id"
                                                      display="logon_id">
                                            </cfselect>			      
                                        </td>
                                        <td>
                                            <cfif IsDefined("session.activepswd")>
                                                <cfinput type="password" 
                                                         name="passwd" 
                                                         value="#session.activepswd#"
                                                         size="20" 
                                                         maxlength="20"
                                                         required="yes"
                                                         message="Password is Required">						
                                            <cfelse>
                                                <cfinput type="password" 
                                                         name="passwd" 
                                                         size="20" 
                                                         maxlength="20"
                                                         required="yes"
                                                         message="Password is Required">						
                                            </cfif>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td colspan="2">&nbsp;</td>                                       
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
											<cfoutput>
                                                <!--- //set a random number --->
                                                <cfset variables.formValidator = RandRange(1,100000)>
                                                <!--- //Set a session with this value --->
                                                <cfset Session.formValidator = variables.formValidator>
                                                <!--- // add the random number in your form --->
                                                <input type="hidden" name="formValidator" value="#variables.formValidator#">
                                            </cfoutput>
                                            
                                            <cfinput type="Submit" name="submit" value="Submit" validate="SubmitOnce">&nbsp;&nbsp;
                                            <cfinput type="Reset" name="reset" value="Reset">										
                                        </td>
                                    </tr>
                                </table>
                            </cfform>

						</div>
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->

                <cfinclude template="sidebar.cfm">
			</div>
		</div>
	</div>

<cfinclude template="footer.cfm">