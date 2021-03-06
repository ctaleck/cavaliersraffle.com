<!--- Under no circumstances, delete this file or move it.  It has a multitude of uses --->

<!--- ****************************************************************************** --->
<!---                   application.cfm                                              --->
<!---     Created by Carl Kunstmann  10/29/98                                        --->
<!--- ****************************************************************************** --->

<!--- Default menu option --->
<cfset variables.top_menu = "">

<!--- This code sets up the basic site security --->
<cfapplication name="CEK#cgi.remote_user#"
               clientmanagement="Yes"
               sessionmanagement="Yes"
               sessiontimeout=" #CreateTimeSpan(0,0,9,0)#"
               applicationtimeout=" #CreateTimeSpan(0,4,0,0)#"
               setDomainCookies="Yes" 
               setClientCookies="Yes">
               
<!--- 
Code to make sure that when a user closes their browser, any session variables that have been established die.
While your user keeps their browser open, session variables will stay alive, but will die when the browser is closed.  
--->
<cfif IsDefined("Cookie.CFID") AND IsDefined ("Cookie.CFTOKEN")>
    <cfset cfid_local = Cookie.CFID>
    <cfset cftoken_local = Cookie.CFTOKEN>
    <cfcookie name="CFID" value="#cfid_local#" secure="yes" httponly="yes" encodevalue="yes">
    <cfcookie name="CFTOKEN" value="#cftoken_local#" secure="yes" httponly="yes" encodevalue="yes">
</cfif>

<!--- Session-Tracker Code ---> 
<cfset theTimeout = CreateTimespan(0,0,30,0)>
<cflock name="#APPLICATION.applicationName#" 
        type="Exclusive" 
        timeout="20" 
        throwontimeout="Yes"> 
	<!--- If Session-Tracker does not exist, generate it ---> 
    <cfparam name="APPLICATION.SessionTracker" default=#StructNew()#>
      
    <!--- Log current user ---> 
    <CFSET dummy = StructInsert(APPLICATION.SessionTracker, CGI.REMOTE_ADDR, Now(), true)> 
</cflock>

<!--- Give variable names to the database tables --->
<cfset variables.str_pool = "tbl_cav_pool">
<cfset variables.str_family = "tbl_cav_qhra_family">
<cfset variables.str_donation = "tbl_cav_donation">
<cfset variables.str_term = "tbl_cav_term">
<cfset variables.str_donor = "tbl_cav_donor">
<cfset variables.str_raffle = "tbl_cav_current_raffle">
<cfset variables.str_states = "tbl_cav_states">

<!--- Error Screen --->
<cferror type="exception" template="oops-error.cfm">

<cfparam name="request.datasource" default="cekweb_qhra">