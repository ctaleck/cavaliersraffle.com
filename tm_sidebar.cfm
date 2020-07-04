<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Administration</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="index.cfm">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tm_index.cfm">Admin</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Reports
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_current.cfm">active</cfif>" href="pb_report_current.cfm">All Entries with Raffle Numbers</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_new.cfm">active</cfif>" href="pb_report_new.cfm">Entries Needing Raffle Numbers</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_newly_expired.cfm">active</cfif>" href="pb_report_newly_expired.cfm">Entries Expired in the Last 30 Days</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_current_month.cfm">active</cfif>" href="pb_report_current_month.cfm">Entries Eligible "Next Month"</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_eligible_raffle_nbrs.cfm">active</cfif>" href="pb_report_eligible_raffle_nbrs.cfm">All Eligible Raffle Numbers</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_used_raffle_nbrs.cfm">active</cfif>" href="pb_report_used_raffle_nbrs.cfm">All Currently Used Raffle Numbers</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_raffle_winner.cfm">active</cfif>" href="pb_raffle_winner.cfm">Input Raffle Number to Get Winners</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_family_totals.cfm">active</cfif>" href="pb_report_family_totals.cfm">Donations per Parish Family</a>
          <a class="dropdown-item <cfif cgi.script_name EQ "/pb_report_mail.cfm">active</cfif>" href="pb_report_mail.cfm">Current Email Report</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="tm_logoff.cfm">Logoff</a>
      </li>
      
    </ul>
    <form class="form-inline my-2 my-lg-0 d-none">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>