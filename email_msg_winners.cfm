<!-- 3 column -->
<cfswitch expression="#variables.current_email#"> 
    <cfcase value="email_winner_before.cfm">
        <cfset before_class = "bg-yellow highlight">
        <cfset winner_class = "bg-red">
        <cfset after_class = "bg-yellow">
    </cfcase>
    <cfcase value="email_winner.cfm">
        <cfset before_class = "bg-yellow">
        <cfset winner_class = "bg-red highlight">
        <cfset after_class = "bg-yellow">
    </cfcase> 
    <cfcase value="email_winner_after.cfm">
        <cfset before_class = "bg-yellow">
        <cfset winner_class = "bg-red">
        <cfset after_class = "bg-yellow highlight">
    </cfcase>
    <cfdefaultcase>
        <cfset before_class = "bg-yellow">
        <cfset winner_class = "bg-red">
        <cfset after_class = "bg-yellow">
    </cfdefaultcase> 
</cfswitch>
<div class="block">
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="table-layout: fixed;" align="center">
    <tr>
      <td><table cellpadding="0" cellspacing="0" border="0" width="560" align="center" class="fluid-table">
          <tr>
            <td>
                <cfoutput>
                    <table width="176" height="176" align="left" border="0" cellpadding="0" cellspacing="0" class="fluid-table">
                    <tbody>
                    <!-- block 1 -->
                    <tr>
                        <td width="176" align="center" class="#before_class#">
                                <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$50</p>
                                <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner_before#</p>
                                <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_before_first# #variables.winner_before_last_full#</p>
                                <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_before_state.state_name#</p>
                        </td>
                    </tr>
                    <!-- block 1 -->
                    </tbody>
                    </table>
                </cfoutput>
              
              <!-- End of first column --> 
              
              <!--[if mso]></td><td valign="top"><![endif]--> 
              
              <!-- Start of second column -->
              
              <cfoutput>
              <table width="176" height="176" align="left" border="0" cellpadding="0" cellspacing="0" class="fluid-table">
                <tbody>
                  <!-- block 2 -->
                  <tr>
                    <td width="176" align="center" class="#winner_class#">
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$200</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner#</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_first# #variables.winner_last_full#</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_winner_state.state_name#</p>
                      </td>
                  </tr>
                  <!-- block 2 -->
                </tbody>
              </table>
              </cfoutput>
              
              <!-- End of second column --> 
              
              <!--[if mso]></td><td valign="top"><![endif]--> 
              
              <!-- Start of third column -->
              
              <cfoutput>
              <table width="176" height="176" align="left" border="0" cellpadding="0" cellspacing="0" class="fluid-table">
                <tbody>
                  <!-- block 3 -->
                  <tr>
                    <td width="176" align="center" class="#after_class#">
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">$50</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:18px;">#variables.raffle_winner_after#</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:21px;">#variables.winner_after_first# #variables.winner_after_last_full#</p>
                            <p style="margin: 0; text-align:center; font-family: sans-serif; font-size:16px;">#qry_qry_after_state.state_name#</p>
                    </td>
                  </tr>
                  <!-- block 3 -->
                </tbody>
              </table>
              </cfoutput>
              <!-- End of third column --></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
