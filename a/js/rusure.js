<!--- ************************************************************************************ --->
<!--- The Javascripts rusure and rusureform display confirmation dialog boxes.             --->
<!---                                                                                      --->
<!--- JavaScript function rusure is used with <a href> - example:                          --->
<!---   <cfset surl="oprtnty_dummy_d1.cfm?oprtnty_id=#URLEncodedFormat(oprtnty_id)#>       --->
<!---   <cfset confirmation="This is an unrecoverable delete.  Are you sure?">             --->
<!---       <a href="javascript:rusure('#surl#','#confirmation#')">                        --->
<!---       <img src="../images/btn_del.gif" width=56 height=24 border=0 alt="">           --->
<!---       </a>                                                                           --->
<!---                                                                                      --->
<!--- JavaScript function rusure causes a confirmation dialog box to appear.               --->
<!--- Parameters are conmsg and loctn.                                                     --->
<!--- The message specified by conmsg appears in the confirmation dialog box.              --->
<!--- If the user responds to the message by clicking "OK", location is changed to         --->
<!--- the address specified by loctn.                                                      --->
<!---                                                                                      --->
<!---                                                                                      --->
<!--- JavaScript function rusureform is used with the onSubmit method of a form - example: --->
<!---  <cfset confirmation="This is an unrecoverable delete.  Are you sure?">              --->
<!---  <cfform action="opp_resources_d2_licns.cfm"                                         --->
<!---          method="POST" enablecab="Yes"                                               --->
<!---          onSubmit="return rusureform('#confirmation#')">                             --->
<!--- JavaScript function rusureform causes a confirmation dialog box to appear.           --->
<!--- Parameter is conmsg.                                                                 --->
<!--- The message specified by conmsg appears in the confirmation dialog box.              --->
<!--- If the user responds to the message by clicking "OK",                                --->
<!---      true is returned and the form is submitted.                                     --->
<!--- If the user responds to the message by clicking "Cancel",                           --->
<!---      false is returned and the form is NOT submitted.                                --->
<!---                                                                                      --->
<!--- Created by Sandy & Carl  4/29/1999                                                   --->
<!--- ************************************************************************************ --->
<script language="JavaScript">
<!-- Hide
function rusure(loctn,conmsg){
	if (confirm(conmsg)){
            top.location = loctn
	}
}

function rusureform(conmsg){
    if (confirm(conmsg)){
            return true
    }
    return false
}
// end hiding -->   
</script>
