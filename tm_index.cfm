<cfinclude template="header.cfm">

<cfinclude template="tm_sidebar.cfm">

    <main role="main">
        <section id="menu" class="bg-light-blue text-blue text-center m-0">
            <div class="container py-5">
				<h1>Reports</h1>
				<div class="list-group inverse mx-auto">
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_current.cfm">All Entries with Raffle Numbers</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_new.cfm">Entries Needing Raffle Numbers</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_newly_expired.cfm">Entries Expired in the Last 30 Days</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_current_month.cfm">Entries Eligible "Next Month"</a>
					<a class="list-group-item list-group-item-dark list-group-item-action border-top-1" href="pb_report_eligible_raffle_nbrs.cfm">All Eligible Raffle Numbers</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_used_raffle_nbrs.cfm">All Currently Used Raffle Numbers</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_raffle_winner.cfm">Input Raffle Number to Get Winners</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_family_totals.cfm">Donations per Parish Family</a>
					<a class="list-group-item list-group-item-dark list-group-item-action" href="pb_report_mail.cfm">Current Email Report</a>
				</div>
            </div>
        </section>
    </main>

<cfinclude template="footer.cfm">
