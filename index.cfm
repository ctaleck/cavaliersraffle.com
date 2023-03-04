<cfinclude template="header.cfm">

    <main role="main">
        <section id="title">
            <div class="d-md-none">
                <img src="images/cavaliers-raffle.jpg" class="center-cropped" alt="Cavaliersraffle.com">
            </div>
            <div class="parallax d-none d-md-block">
                <img style="opacity: 0" src="images/cavaliers-raffle.jpg" class="center-cropped center-cropped-md" alt="Cavaliersraffle.com">
            </div>
        </section>
        <section id="hero" class="tickets-hero jumbotron rounded-0 border-top bg-red text-white text-center mb-0">
            <div class="container">
                <h1 class="jumbotron-heading text-shadow">Get ready to team up with CavaliersRaffle.com!</h1>
                <div class="row">
                    <div class="col-md-4 mt-5">
                        <h3 class="text-shadow">Support OLOSA!</h3>
                        <p>
                            Your donation goes toward supporting Our Lady of Sorrows Academy in Phoenix, AZ.
                        </p>
                        <a href="#carousel" role="button" class="btn btn-light btn-lg">Gallery</a>
                    </div>
                    <div class="col-md-4 mt-5">
                        <h3 class="text-shadow">Enroll now!</h3>
                        <p>
                            Fill out the <b>Raffle Entry</b> form to register and purchase your raffle ticket for up to one year of eligibility.
                        </p>
                        <a href="#entry" role="button" class="btn btn-warning btn-lg text-danger text-shadow">Raffle Entry Ended</a>
                    </div>
                    <div class="col-md-4 mt-5">
                        <h3 class="text-shadow">Monthly Prizes!</h3>
                        <p>
                            $200 prize and two secondary prizes of $50. The rules are simple. 
                        </p>
                        <a href="#rules" role="button" class="btn btn-light btn-lg">Rules</a>
                    </div>
                </div>
            </div>
        </section>
        <section id="carousel" class="bg-yellow rounded-0 text-center mb-0">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="images/olosa-at-prayer.jpg" alt="OLOSA at prayer"> 
                            <div class="carousel-caption d-none d-md-block">
                                <h5>At prayer...</h5>
                                <p>OLOSA attending school Mass.</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="images/olosa-at-work.jpg" alt="OLOSA at work">
                            <div class="carousel-caption d-none d-md-block">
                                <h5>At work...</h5>
                                <p>OLOSA students in the classroom.</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="images/olosa-at-play.jpg" alt="OLOSA at play">
                            <div class="carousel-caption d-none d-md-block">
                                <h5>At play...</h5>
                                <p>OLOSA students enjoy a period of recess.</p>
                            </div>
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
        </section>        

	<cfinclude template="registration-disabled.inc.cfm">

        <section id="rules" class="bg-dark-blue text-white text-center py-5">
            <div class="container">
                    <h1 class="jumbotron-heading">Rules</h1>
                    <div class="row">
                        <div class="col-md-4 mt-5">
                            <h3>Three Prizes</h3>
                            <p>
                                $200 grand prize and two piggyback prizes of $50.<sup>*</sup>
                            </p>
                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Monthly Drawing</h3>
                            <p>
                                Numbers will be selected on the first Friday of each month.<sup>*</sup>                               
                            </p>
                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Piggyback Raffle</h3>
                            <p>
                                One number will be randomly selected with the higher and lower number automatically selected.<sup>*</sup>
                            </p>
                        </div>
                    </div>
            </div>
        </section>
        <section id="menu" class="bg-light-blue inverse text-blue text-center m-0">
            <div class="container">
                <p class="text-blue py-5">
                    <sup>*</sup> For more information, please view the  
                    <a title="FAQ" href="" data-toggle="collapse" onClick="viewMore()"
                        data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="FAQ">
                        FAQ.
                    </a>
                </p>
            </div>
        </section>
    </main>

<cfinclude template="footer.cfm">
<!--- <cfinclude template="image_preload.cfm"> --->