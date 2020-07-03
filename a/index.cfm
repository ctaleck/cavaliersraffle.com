<cfinclude template="header.cfm">

	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div>
						<div id="gallery">
							<div id="gallery-background"><img src="<?php bloginfo('template_url'); ?>images/image1.jpg" alt="" width="500" height="340" class="output" /></div>
							<div id="gallery-bgthumb">
								<ul class="thumbnails">
									<li><img src="images/image1.jpg" title="Class picture at the Jog-A-Thon" alt="" /></li>
									<li><img src="images/image2.jpg" title="Lining up for the Jog-A-Thon" alt="" /></li>
									<li><img src="images/image3.jpg" title="QHRA School Portrait" alt="" /></li>
									<li><img src="images/image4.jpg" title="Students in costume for All Saints Day" alt="" /></li>
								</ul>
								<br class="clear" />
							</div>
						</div>
						<script type="text/javascript">

						$('#gallery').gallerax({
							outputSelector: 		'.output',					// Output selector
							thumbnailsSelector:		'.thumbnails li img',		// Thumbnails selector
							fade: 					'fast',						// Transition speed (fast)
							navNextSelector:		'.nav li a.navNext',		// 'Next' selector
							navPreviousSelector:	'.nav li a.navPrevious'		// 'Previous' selector
						});

					</script>
						<!-- end -->
					</div>
					<div class="post">
						<h2 class="title">Our Lady of Sorrows Piggyback Raffle Homepage</h2>
						<p class="meta">Thank you for supporting our school and students</p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
							<p>Each month, one number will be randomly selected from all the enrolled numbers to win the $200 monthly prize.  Additionally, the next higher enrolled number and the next lower enrolled number from the number selected will each win secondary prizes of $50.<br /><br />For the purposes of this raffle, one number higher than the highest number will be the lowest number and one number lower than the lowest number will be the highest number.  Numbers will be selected on the first Friday of each month.</p>
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
<!--- <cfinclude template="image_preload.cfm"> --->