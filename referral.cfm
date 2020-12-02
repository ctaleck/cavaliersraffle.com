<cftry>

<!-- https://www.bennadel.com/blog/873-using-captcha-in-coldfusion-8.htm -->
<!--- Kill extra output. --->
<cfsilent>

    <!--- Param FORM values. --->
    <cfparam
        name="FORM.referral_name1"
        type="string"
        default=""
        />

    <cfparam
        name="FORM.referral_email2"
        type="string"
        default=""
        />

    <cfparam
        name="FORM.referral_sponsor"
        type="string"
        default=""
        />

    <cfparam
        name="FORM.captcha"
        type="string"
        default=""
        />

    <cfparam
        name="FORM.captcha_check"
        type="string"
        default=""
        />

    <cftry>
        <cfparam
            name="FORM.submitted"
            type="numeric"
            default="0"
            />

        <cfcatch>
            <cfset FORM.submitted = 0 />
        </cfcatch>
    </cftry>


    <!--- Set a flag to see if this user is a bot or not. --->
    <cfset blnIsBot = true />


    <!--- Check to see if the form has been submitted. --->
    <cfif FORM.submitted>

        <!---
            Decrypt the captcha check value. Since this was
            submitted via a FORM, we have to be careful about
            attempts to hack it. Always put a Decrypt() call
            inside of a CFTry / CFCatch block.
        --->
        <cftry>

            <!--- Decrypt the check value. --->
            <cfset strCaptcha = Decrypt(
                FORM.captcha_check,
                variables.captcha_key,
                "CFMX_COMPAT",
                "HEX"
                ) />

            <!---
                Check to see if the user-submitted value is
                the same as the decrypted CAPTCHA value.
                Remember, ColdFusion is case INsensitive with
                the EQ opreator.
            --->
            <cfif (strCaptcha EQ FORM.captcha)>

                <!---
                    The user entered the correct text. Set the
                    flag for future use.
                --->
                <cfset blnIsBot = false />

            </cfif>

            <!--- Catch any errors. --->
            <cfcatch>

                <!--- Make sure the bot flag is set. --->
                <cfset blnIsBot = true />

            </cfcatch>
        </cftry>


    </cfif>



    <!---
        Before we render the form, we have to figure out
        which CAPTCHA text we are going to display. For
        this, we have to come up with a random combination
        of letters/numbers. For this, we are going to use an
        easy solution which is shuffling an array of valid
        characters.
    --->

    <!---
        Create the array of valid characters. Leave out the
        numbers 0 (zero) and 1 (one) as they can be easily
        confused with the characters o and l (respectively).
    --->
    <cfset arrValidChars = ListToArray(
        "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
        "2,3,4,5,6,7,8,9"
        ) />

    <!--- Now, shuffle the array. --->
    <cfset CreateObject(
        "java",
        "java.util.Collections"
        ).Shuffle(
            arrValidChars
            )
        />

    <!---
        Now that we have a shuffled array, let's grab the
        first 8 characters as our CAPTCHA text string.
    --->
    <cfset strCaptcha = (
        arrValidChars[ 1 ] &
        arrValidChars[ 2 ] &
        arrValidChars[ 3 ] &
        arrValidChars[ 4 ] &
        arrValidChars[ 5 ] &
        arrValidChars[ 6 ] &
        arrValidChars[ 7 ] &
        arrValidChars[ 8 ]
        ) />


    <!---
        At this point, we have picked out the CAPTCHA string
        that we want the users to ender. However, we don't
        want to pass that text anywhere in the form otherwise
        a spider might be able to scrape it. Thefefore, we now
        want to encrypt this value into our check field.
    --->
    <cfset FORM.captcha_check = Encrypt(
        strCaptcha,
        variables.captcha_key,
        "CFMX_COMPAT",
        "HEX"
        ) />

</cfsilent>

<cfinclude template="header.cfm">
<cfoutput>
<form
name=""
    action="#CGI.script_name#"
    method="post">
<main>
    <section class="bg-white py-5">
        <div class="container">
            <h1>
                Friends and Family Referral
            </h1>
                <!---
                    Check to see if the form has been submitted so
                    we can see if we need to show the validation.
                --->
                <cfif FORM.submitted>

                    <!--- Check for a bot. --->
                    <cfif blnIsBot>

                        <div class="alert alert-warning" role="alert">
                            <h4 class="alert-heading">Warning</h4>
                            <p>The CAPTCHA is incorrect. Please try again.</p>
                            <hr>
                            <p class="mb-0">This form requires you to enter these characters to prevent email spam.</p>
                        </div>

                    <cfelse>

                        <div class="alert alert-success" role="alert">
                            <h4 class="alert-heading">Success!</h4>
                            <p>Your email has been sent to your friend or family.</p>
                            <hr>
                            <p class="mb-0">You may enter more by using this form again.</p>
                        </div>
                    </cfif>

<cfdump var="#FORM#" format="html">
<cfset referralArray = ListToArray(FORM.referral_emails)>
<cfdump var="#referralArray#">
                </cfif>

<!-- Add more form inputs -->

    <div id="app">
      <div class="card mb-5">
          <div class="card-body">

        <h5 class="card-title">Enter your name</h2>
                  <input
                    type="text"
                    placeholder="your name"
                    id="sender_name"
                    name="sender_name"
                    v-model="sender_name"
                  />
        <h5 class="card-title">Enter name and email to send to</h2>
            <div class="card-text" v-for="(row, index) in rows">
                <p>
                  <input
                    type="text"
                    placeholder="name"
                    v-bind:id="'referral_name'+(index+1)"
                    v-bind:name="'referral_name'+(index+1)"
                    v-model="row.name"
                  />
                  <input
                    type="text"
                    placeholder="email address"
                    v-bind:id="'referral_emails'"
                    v-bind:name="'referral_emails'"
                    v-model="row.email"
                  />
                </p>
            </div>
        <button v-on:click="addRow()" class="btn btn-default btn-small" type="button">Add another name</button>
          </div>
      </div>
      <div class="card card-body mb-5" v-for="(row, index) in rows">

        <p>Email number {{ index+1 }}</p>
        <p>
          To: {{ row.email }}
        </p>
        <p>
          Dear {{ row.name }},
        </p>
                <p>
          Sincerely {{ sender_name }},
        </p>
      </div>
    </div>


            <div class="card card-body mb-5" style="width:405px;">
                <!---
                    This is the hidden field that will flag form
                    submission for data validation.
                --->
                <input type="hidden" name="submitted" value="1" />
    
                <!---
                    This is the hidden field that we will check the
                    user's CAPTCHA text against. This is an encrypted
                    field so that spiders / bots cannot use it to
                    their advantage.
                --->
                <input
                    type="hidden"
                    name="captcha_check"
                    value="#FORM.captcha_check#"
                    />
    
    
                <p>
                    <!---
                        Output the CAPTCHA image to the browser.
                        Here, we are using a difficulty of medium
                        so that we don't fry the user's brain.
                    --->
                    <cfimage
                        action="captcha"
                        height="75"
                        width="363"
                        text="#strCaptcha#"
                        difficulty="medium"
                        fonts="verdana,arial,times new roman,courier"
                        fontsize="28"
                        />
                </p>
    
                <label for="captcha">
                    Please enter text in image
                </label>
    
                <input
                    type="text"
                    name="captcha"
                    id="captcha"
                    value=""
                    />
            </div>

                <p>
                    <input type="submit" value="Send email" class="btn btn-primary"/>
                </p>

        </div>
    </section>
    <section class="bg-white py-5">
        <div class="container">
            <div class="card rounded-0 mb-5" style="width:600px;">
                <img class="card-img-top" src="./images/cavaliers-raffle-email.jpg" />

                <div class="card-body">
                    <p>
                    Dear _______,
                    </p>
                    <p>
                    Our Lady of Sorrows Academy is excited to announce our new fundraiser - the Cavaliers Raffle!  
                    </p>
                    <p>
                    As you know, our non-profit K-12 school provides a traditional, classical education in Phoenix, Arizona. We have wonderful teachers and priests who do their best for us, and many families to support them. However, we always need more - more books, more supplies, more money to pay the bills and increase our teacher salaries. Tuition isn’t enough, so we find other ways to raise money. Students look forward to our annual Jog-a-thon, but we want to do something year-round.
                    </p>
                    <p>
                    The Cavaliers Raffle is a quick and easy way for you to support our small Catholic school, but also a quick and easy way for you to win a cash prize. You get 12 chances to win - for just one $20 ticket! Every month, we will select a computer-generated winner for a grand prize of $200, plus two runner-up winners of $50 each. This is a continuous raffle, so people can join the pool every month. Your ticket lasts for one year from purchase. Once you buy a ticket, just wait to (hopefully) win!
                    </p>
                    <p>
                    Won’t you please invest in our school? Purchase a ticket (or two!) for yourself, or one for a friend. Feel free to forward this email, or the link below, to all of your friends … who doesn’t want to win $200?!
                    </p>
                    <p>
                    Click on the link below for more information and to register at CavaliersRaffle.com - it’s so simple!  Please select our family name from the student list, so we receive credit for the ticket sale.
                    </p>
                    <p>
                    Thank you for supporting our school! Your continued generosity is so much appreciated. You are in my prayers.
                    </p>
                    <p>
                    _________
                    </p>
                </div>
            </div>
        </div>
    </section>
</main>
</form>
</cfoutput>
<cfinclude template="footer.cfm">

<script src="https://unpkg.com/vue"></script>

<script>

<cfscript>
       example = structnew();
       example.firstname = "Yes";
       example.lastname = "Man";
       stuff = SerializeJSON(example);
</cfscript>

    var app = new Vue({
    el: "#app",
    data: {
        sender_name: '',
        rows: [{ name: "", email: "" }],
        stuff: <cfoutput>#stuff#</cfoutput>
    },
    methods: {
        addRow() {
        this.rows.push({ name: "", email: "" });
        },
        print() {}
    }
    });
</script>

    <cfcatch type="any">
        Error: <cfoutput>#cfcatch.message#</cfoutput>
    </cfcatch>
</cftry>