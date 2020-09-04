<!--- This code checks to see if the user has gone to http.  If so, redirect to https automatically. --->
<cfif Compare(cgi.SERVER_PORT,443)>
	<cflocation url="https://#cgi.server_name##cgi.path_info#?#cgi.query_string#" addtoken="no" />
</cfif>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Cavaliers Raffle | Our Lady of Sorrows Academy</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/font/css/open-iconic-bootstrap.css"
        integrity="sha256-CNwnGWPO03a1kOlAsGaH5g8P3dFaqFqqGFV/1nkX5OU=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Contrail+One&display=swap" />
    <link rel="stylesheet" href="custom.css" />
    <style>
    </style>
    <!-- 
        Application Insights:
        To collect user behavior analytics about your application, 
        insert the following script into each page you want to track.
        Place this code immediately before the closing head tag,
        and before any other scripts. Your first data will appear 
        automatically in just a few seconds.
    -->
    <script type="text/javascript">
        var appInsights = window.appInsights || function (a) {
            function b(a) { c[a] = function () { var b = arguments; c.queue.push(function () { c[a].apply(c, b) }) } } var c = { config: a }, d = document, e = window; setTimeout(function () { var b = d.createElement("script"); b.src = a.url || "https://az416426.vo.msecnd.net/scripts/a/ai.0.js", d.getElementsByTagName("script")[0].parentNode.appendChild(b) }); try { c.cookie = d.cookie } catch (a) { } c.queue = []; for (var f = ["Event", "Exception", "Metric", "PageView", "Trace", "Dependency"]; f.length;)b("track" + f.pop()); if (b("setAuthenticatedUserContext"), b("clearAuthenticatedUserContext"), b("startTrackEvent"), b("stopTrackEvent"), b("startTrackPage"), b("stopTrackPage"), b("flush"), !a.disableExceptionTracking) { f = "onerror", b("_" + f); var g = e[f]; e[f] = function (a, b, d, e, h) { var i = g && g(a, b, d, e, h); return !0 !== i && c["_" + f](a, b, d, e, h), i } } return c
        }({
            instrumentationKey: "2beb8a98-f9eb-43bb-b54e-1d1eab3c95e0"
        });

        window.appInsights = appInsights, appInsights.queue && 0 === appInsights.queue.length && appInsights.trackPageView();

        function viewMore() {
            setTimeout(function () {
                window.scrollTo({top:0})
            }, 300);
        }
    </script>
</head>

<body class="bg-light-blue">

<div id="app">
    <header>
        <div class="collapse" id="navbarHeader">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-md-7 py-4">
                        <p class="text-white">Thank you for your donation to</p>
                        <h4 class="text-white">Our Lady of Sorrows Academy</h4>
                        <p class="text-white">
                            All proceeds from this raffle will benefit the Academy.
                        </p>
                        <p class="text-white">
                            Thank you for supporting our school!
                        </p>
                        <p class="text-white small">
                            Our Lady of Sorrows Academy is a K-12 private traditional Catholic school located in
                            Phoenix, Arizona. The Academy is a 501(c)(3) not-for-profit IRS tax exempt entity and
                            donations may be fully tax-deductible according to IRS charitable contributions guidelines.
                            All donations that meet IRS limits will be followed up with a letter of acknowledgement as
                            mandated by the IRS.
                        </p>
                        <p class="text-white small">
                            If you have problems using this Website, please contact the 
                            <a href="mailto:admin@olosa.org">Webmaster</a>
                        </p>
                    </div>
                    <div class="col-sm-4 offset-md-1 py-4">
                        <h4 class="text-white">Contact</h4>
                        <p>750 E. Baseline Road<br/>
                        Phoenix, AZ 85042<br/>
                        602-305-7183</p>
                        <ul class="list-unstyled">
                            <li><a href="mailto:office@olosa.org" class="text-white">E-mail: office@olosa.org</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-dark fixed-top box-shadow bg-blue">
            <div class="w-100 d-flex justify-content-between">
                <a href="#" class="navbar-brand d-flex align-items-center">
                    <span class="d-md-none"><strong>OLOSA</strong></span>
                    <span class="d-none d-md-block"><strong>Our Lady of Sorrows Academy</strong></span>
                </a>
                <button title="More about donations" class="navbar-toggler" type="button" data-toggle="collapse" onClick="viewMore()"
                    data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-question-mark"></span>
                </button>
            </div>
        </nav>
    </header>