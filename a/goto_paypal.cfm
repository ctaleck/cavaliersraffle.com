<cfinclude template="header.cfm">

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
						<h2 class="title">Piggyback Registration Complete</strong></h2>

						<p class="meta">Please click the PayPal Link below to Finalize your Donation</p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">                            
                            <p style="text-align:justify">
                            Once your order is processed, you will receive confirmation of your enrollment including your unique entry number(s).  
                            Each $25 purchase entitles you to 12 consecutive monthly raffles, beginning the month after you enter.
                            </p>
                            <p style="font-weight:bold; color:red">
                            	Please note: <br />Be sure to modify the PayPal screen to reflect you're purchasing <cfoutput>(#url.tickets#)</cfoutput> tickets, <br />which is what you selected.
                            </p>
                            <p>&nbsp;</p>
                            <p>
                            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                <input type="hidden" name="cmd" value="_s-xclick">
                                <input type="hidden" name="hosted_button_id" value="9U8MWYMZ5RVDJ">
                                <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                            </form>
							</p>
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