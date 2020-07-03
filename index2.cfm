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
                        <a href="#entry" role="button" class="btn btn-warning btn-lg text-danger text-shadow">Raffle Entry</a>
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
        <section id="entry" class="jumbotron bg-light-blue ww ounded-0 text-center mb-0">
            <div class="container">
                    <h1 class="jumbotron-heading">Raffle Entry</h1>
                    <p><b class="text-danger">*</b> are required fields.</p>
                    <div class="row text-left">
                        <div class="col-md-4 mt-5">
                            <h3>Entry Information</h3>
                            <p>
                                Number of raffle tickets @ $25 per ticket
                            </p>
                            <label class="" for="tickets">Tickets</label>
                            <div class="input-group mb-2">
                                    <select class="form-control" name="tickets" size="1">
                                            <option value=" "> </option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                            <option value="19">19</option>
                                            <option value="20">20</option>
                                        </select>
                                    <div class="input-group-append">
                                    <div class="input-group-text text-danger">*</div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Ticket Holder Information</h3>
                            <p>
                                Please fill out the form below completely for the ticket holder! 
                            </p>
                            <label class="form-control-label" for="pb_first_name">First Name</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_first_name" id="pb_first_name" type="text" maxlength="50" placeholder="Ticket holder first name">
                                <div class="input-group-append">
                                    <span class="input-group-text text-danger"><b>*</b></span>
                                </div>
                            </div>
                            <label class="form-control-label" for="pb_last_name">Last Name</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_last_name" id="pb_last_name" type="text" maxlength="50" placeholder="Ticket holder last name">
                                <div class="input-group-append">
                                    <span class="input-group-text text-danger" id="inputGroupPrepend"><b>*</b></span>
                                </div>
                            </div>
                            <label class="form-control-label" for="pb_phone">Phone</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_phone" id="pb_phone" type="text" maxlength="14" placeholder="Ticket holder phone">
                                <div class="input-group-append">
                                    <span class="input-group-text text-danger"><b>*</b></span>
                                </div>
                            </div>
                            <label class="form-control-label" for="pb_email">Email</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_email" id="pb_email" type="text" maxlength="150" placeholder="Ticket holder email">
                                <div class="input-group-append">
                                    <span class="input-group-text text-danger" id="inputGroupPrepend"><b>*</b></span>
                                </div>
                            </div>
                            <label class="form-control-label" for="pb_address">Street Address</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_address" id="pb_address" type="text" maxlength="100" placeholder="Ticket holder street address">
                            </div>
                            <label class="form-control-label" for="pb_city">City</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_city" id="pb_city" type="text" maxlength="50" placeholder="Ticket holder city">
                            </div>
                            <label class="form-control-label" for="pb_state">State</label>
                            <div class="input-group mb-2">
                                    <select class="form-control" name="pb_state" size="1" placeholder="Ticket holder state">
                                            <option value=" ">Ticket holder state</option>
                                            <option value="AL">AL</option>
                                            <option value="AK">AK</option>
                                            <option value="AZ">AZ</option>
                                            <option value="AR">AR</option>
                                            <option value="CA">CA</option>
                                            <option value="CO">CO</option>
                                            <option value="CT">CT</option>
                                            <option value="DE">DE</option>
                                            <option value="FL">FL</option>
                                            <option value="GA">GA</option>
                                            <option value="HI">HI</option>
                                            <option value="ID">ID</option>
                                            <option value="IL">IL</option>
                                            <option value="IN">IN</option>
                                            <option value="IA">IA</option>
                                            <option value="KS">KS</option>
                                            <option value="KY">KY</option>
                                            <option value="LA">LA</option>
                                            <option value="ME">ME</option>
                                            <option value="MD">MD</option>
                                            <option value="MA">MA</option>
                                            <option value="MI">MI</option>
                                            <option value="MN">MN</option>
                                            <option value="MS">MS</option>
                                            <option value="MO">MO</option>
                                            <option value="MT">MT</option>
                                            <option value="NE">NE</option>
                                            <option value="NV">NV</option>
                                            <option value="NH">NH</option>
                                            <option value="NJ">NJ</option>
                                            <option value="NM">NM</option>
                                            <option value="NY">NY</option>
                                            <option value="NC">NC</option>
                                            <option value="ND">ND</option>
                                            <option value="OH">OH</option>
                                            <option value="OK">OK</option>
                                            <option value="OR">OR</option>
                                            <option value="PA">PA</option>
                                            <option value="RI">RI</option>
                                            <option value="SC">SC</option>
                                            <option value="SD">SD</option>
                                            <option value="TN">TN</option>
                                            <option value="TX">TX</option>
                                            <option value="UT">UT</option>
                                            <option value="VT">VT</option>
                                            <option value="VA">VA</option>
                                            <option value="WA">WA</option>
                                            <option value="WV">WV</option>
                                            <option value="WI">WI</option>
                                            <option value="WY">WY</option>
                                    </select>    
                            </div>
                            <label class="form-control-label" for="pb_zipcode">Zipcode</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_zipcode" id="pb_zipcode" type="text" maxlength="5" placeholder="Ticket holder zipcode">
                            </div>
                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Sponsor Information</h3>
                            <p>
                                Are you sponsoring a school family? Tell us who so they will get credit!
                            </p>
                            <label class="" for="pb_info_source">School Family</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_info_source" id="pb_info_source" type="text" maxlength="150" placeholder="Sponsor name">
                            </div>
                            <h3 class="mt-5">Gift Information</h3>
                            <p>
                                Is this a gift? If yes, please provide the Name and Email of the Gift Giver!
                            </p>
                            <div class="form-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="gridCheck">
                                    <label class="form-check-label" for="gridCheck">
                                    Yes, this is a gift.
                                    </label>
                                </div>
                            </div>
                            <label class="" for="pb_qhra_family_name">Name</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_qhra_family_name" id="pb_qhra_family_name" type="text" maxlength="85" placeholder="Gift giver name">
                            </div>
                            <label class="" for="pb_qhra_family_email">Email</label>
                            <div class="input-group mb-2">
                                <input class="form-control" name="pb_qhra_family_email" id="pb_qhra_family_email" type="text" maxlength="150" placeholder="Gift giver email">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mt-5 text-center">
                            <button type="submit" class="btn btn-lg btn-success text-shadow">Enroll now!</button>
                        </div>
                    </div>
            </div>
        </section>
        <section id="rules" class="bg-dark-blue text-white text-center py-5">
            <div class="container">
                    <h1 class="jumbotron-heading">Rules</h1>
                    <div class="row">
                        <div class="col-md-4 mt-5">
                            <h3>Three Prizes</h3>
                            <p>
                                $200 prize and two secondary prizes of $50.
                            </p>
                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Monthly Drawing</h3>
                            <p>
                                Each month, one number will be randomly selected from all the enrolled numbers to win the $200 monthly prize.  
                                Additionally, the next higher enrolled number and the next lower enrolled number from the number selected will 
                                each win secondary prizes of $50.
                            </p>
                        </div>
                        <div class="col-md-4 mt-5">
                            <h3>Drawing Method</h3>
                            <p>
                                For the purposes of this raffle, one number higher than the highest number will be the lowest number and one 
                                number lower than the lowest number will be the highest number.  Numbers will be selected on the first Friday 
                                of each month.
                            </p>
                        </div>
                    </div>
            </div>
        </section>
        <section id="menu" class="bg-light-blue inverse text-blue text-center m-0">
            <div class="container">
                <p class="text-blue py-5">Administration <a href="admin.html">Login</a></p>
            </div>
        </section>
    </main>

<cfinclude template="footer.cfm">
<!--- <cfinclude template="image_preload.cfm"> --->