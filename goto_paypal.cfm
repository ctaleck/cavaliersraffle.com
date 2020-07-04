<cfinclude template="header.cfm">

	<section id="menu" class="bg-light-blue text-blue text-center m-0">
		<cfoutput>
			<div class="container py-5">
				<h1 class="display-1">One more step...</h1>
				<div class="card card-body">
					<p>
						Please click the "Buy Now" link below to finalize your donation. We use PayPal for our donations, but you do not need an account to purchase. Credit cards are accepted.
					</p>
					<p>
						Once your order is processed, you will receive confirmation of your enrollment including your unique entry number(s).  
					</p>
					<p>
						Each $25 purchase entitles you to 12 consecutive monthly raffles, beginning the month after you enter.
					</p>
					<div class="alert alert-info" role="alert">
						<h4 class="alert-heading">Please note!</h4>
						You are purchasing (#url.tickets#) tickets at $#url.tickets*25#.00. Please confirm this on the next page.
					</div>
					<p>
						<a 
							href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=ourladyofsorrows@sspx.org&item_name=#url.tickets#+tickets&item_number=cavaliersraffle.com&amount=#url.tickets*25#&currency_code=USD"
							target="_blank" class="btn btn-lg btn-success my-2">Buy Now</a>
					</p>
					<p class="img-fluid">
						<img src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png" alt="Donate now with PayPal">
					</p>
				</div>
				</div>
		</cfoutput>
	</section>

<cfinclude template="footer.cfm">