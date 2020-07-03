<!--- This code checks to see if the user has gone to http.  If so, redirect to https automatically. --->
<!--- <cfif Compare(cgi.SERVER_PORT,443)>
	<cflocation url="http://#cgi.server_name##cgi.path_info#?#cgi.query_string#" addtoken="no" />
</cfif> --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        
        <title>Cavaliers Raffle</title>

		<!--- Displays the date in the footer --->
        <script language="javascript">
            function displayDate() {
              var now = new Date();
              var year = now.getFullYear();
            
              document.write(year);
            }
        </script>
        
        <link href="style.css" rel="stylesheet" type="text/css" media="screen" />
        
		<script type="text/javascript" src="jquery/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.gallerax-0.2.js"></script>
    
		<style id="antiClickjack">body{display:none !important;}</style>
        
        <script type="text/javascript">
           if (self === top) {
               var antiClickjack = document.getElementById("antiClickjack");
               antiClickjack.parentNode.removeChild(antiClickjack);
           } else {
               top.location = self.location;
           }
        </script>
    
    </head>
	<body>
    
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1 style="color:Yellow">Cavaliersraffle.org</h1>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;Our Lady of Sorrows - Piggyback Raffle</p>
			</div>
		</div>
	</div>
    