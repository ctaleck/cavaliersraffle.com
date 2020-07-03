<cfinclude template="header.cfm">

	<section id="menu" class="bg-light-blue text-blue text-center m-0">
		<div class="container py-5">
			<h1 class="display-1">One more step...</h1>
			<p>
				Please click the PayPal link below to finalize your donation.
			</p>
			<p>
				Once your order is processed, you will receive confirmation of your enrollment including your unique entry number(s).  
			</p>
			<p>
				Each $25 purchase entitles you to 12 consecutive monthly raffles, beginning the month after you enter.
			</p>
			<div class="alert alert-info" role="alert">
				<h4 class="alert-heading">Please note!</h4>
				Be sure to modify the PayPal screen to reflect you're purchasing <cfoutput>(#url.tickets#)</cfoutput> tickets, which is what you selected.
			</div>
			<p>
			<p>
				<a 
					href="<cfoutput>https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=ourladyofsorrows@sspx.org&item_name=#url.tickets#+tickets&item_number=cavaliersraffle.com&amount=#url.tickets*25#&currency_code=USD</cfoutput>"
					target="_blank" class="btn btn-lg btn-success my-2">Buy Now</a>
				<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
			</p>
			</p>
		</div>
	</section>

<cfinclude template="footer.cfm">