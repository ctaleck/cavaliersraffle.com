    <!doctype html>
    <!-- See https://tedgoas.github.io/Cerberus/ -->
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
    <head>
        <meta charset="utf-8"> <!-- utf-8 works for most cases -->
        <meta name="viewport" content="width=device-width"> <!-- Forcing initial-scale shouldn't be necessary -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> <!-- Use the latest (edge) version of IE rendering engine -->
        <meta name="x-apple-disable-message-reformatting">  <!-- Disable auto-scale in iOS 10 Mail entirely -->
        <meta name="format-detection" content="telephone=no,address=no,email=no,date=no,url=no"> <!-- Tell iOS not to automatically link certain text strings. -->
        <title></title> <!-- The title tag shows in email notifications, like Android 4.4. -->
    
        <!-- Web Font / @font-face : BEGIN -->
        <!-- NOTE: If web fonts are not required, lines 10 - 27 can be safely removed. -->
    
        <!-- Desktop Outlook chokes on web font references and defaults to Times New Roman, so we force a safe fallback font. -->
        <!--[if mso]>
            <style>
                * {
                    font-family: sans-serif !important;
                }
            </style>
        <![endif]-->
    
        <!-- All other clients get the webfont reference; some will render the font and others will silently fail to the fallbacks. More on that here: http://stylecampaign.com/blog/2015/02/webfont-support-in-email/ -->
        <!--[if !mso]><!-->
        <!-- insert web font reference, eg: <link href='https://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'> -->
        <!--<![endif]-->
    
        <!-- Web Font / @font-face : END -->
    
        <!-- CSS Reset : BEGIN -->
        <style>
    
            /* What it does: Remove spaces around the email design added by some email clients. */
            /* Beware: It can remove the padding / margin and add a background color to the compose a reply window. */
            html,
            body {
                margin: 0 !important;
                padding: 0 !important;
                height: 100% !important;
                width: 100% !important;
            }
    
            /* What it does: Stops email clients resizing small text. */
            * {
                -ms-text-size-adjust: 100%;
                -webkit-text-size-adjust: 100%;
            }
    
            /* What it does: Centers email on Android 4.4 */
            div[style*="margin: 16px 0"] {
                margin: 0 !important;
            }
    
            /* What it does: Stops Outlook from adding extra spacing to tables. */
            table,
            td {
                mso-table-lspace: 0pt !important;
                mso-table-rspace: 0pt !important;
            }
    
            /* What it does: Fixes webkit padding issue. */
            table {
                border-spacing: 0 !important;
                border-collapse: collapse !important;
                table-layout: fixed !important;
                margin: 0 auto !important;
            }
    
            /* What it does: Uses a better rendering method when resizing images in IE. */
            img {
                -ms-interpolation-mode:bicubic;
            }
    
            /* What it does: Prevents Windows 10 Mail from underlining links despite inline CSS. Styles for underlined links should be inline. */
            a {
                text-decoration: none;
            }
    
            /* What it does: A work-around for email clients meddling in triggered links. */
            a[x-apple-data-detectors],  /* iOS */
            .unstyle-auto-detected-links a,
            .aBn {
                border-bottom: 0 !important;
                cursor: default !important;
                color: inherit !important;
                text-decoration: none !important;
                font-size: inherit !important;
                font-family: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
            }
    
            /* What it does: Prevents Gmail from displaying a download button on large, non-linked images. */
            .a6S {
                display: none !important;
                opacity: 0.01 !important;
            }
    
            /* What it does: Prevents Gmail from changing the text color in conversation threads. */
            .im {
                color: inherit !important;
            }
    
            /* If the above doesn't work, add a .g-img class to any image in question. */
            img.g-img + div {
                display: none !important;
            }
    
            /* What it does: Removes right gutter in Gmail iOS app: https://github.com/TedGoas/Cerberus/issues/89  */
            /* Create one of these media queries for each additional viewport size you'd like to fix */
    
            /* iPhone 4, 4S, 5, 5S, 5C, and 5SE */
            @media only screen and (min-device-width: 320px) and (max-device-width: 374px) {
                u ~ div .email-container {
                    min-width: 320px !important;
                }
            }
            /* iPhone 6, 6S, 7, 8, and X */
            @media only screen and (min-device-width: 375px) and (max-device-width: 413px) {
                u ~ div .email-container {
                    min-width: 375px !important;
                }
            }
            /* iPhone 6+, 7+, and 8+ */
            @media only screen and (min-device-width: 414px) {
                u ~ div .email-container {
                    min-width: 414px !important;
                }
            }
    
        </style>
    
        <!-- What it does: Makes background images in 72ppi Outlook render at correct size. -->
        <!--[if gte mso 9]>
        <xml>
            <o:OfficeDocumentSettings>
                <o:AllowPNG/>
                <o:PixelsPerInch>96</o:PixelsPerInch>
            </o:OfficeDocumentSettings>
        </xml>
        <![endif]-->
    
        <!-- CSS Reset : END -->
    
        <!-- Progressive Enhancements : BEGIN -->
        <style>
            .center-cropped {
                object-fit: none;
                object-position: center;
                height: 425px;
                width: 100%;
            }
            .bg-cavalier-blue {
                background-color: #35355A;
            }
            a {
                color: #b81413;
                text-decoration: none;
            }
            a:hover {
                color: #b81413;
                text-decoration: underline;
            }
            .center-cropped-md {
                object-fit: fill;
                height: 100%;
            }
            h1, h2, h3, h4 {
                font-family: 'Contrail One', cursive;
            }
        
            /* What it does: Hover styles for buttons */
            .button-td,
            .button-a {
                transition: all 100ms ease-in;
            }
            .button-td-primary:hover,
            .button-a-primary:hover {
                background: #b81413 !important;
                border-color: #b81413 !important;
            }
    
            /* Media Queries */
            @media screen and (max-width: 600px) {
    
                /* What it does: Adjust typography on small screens to improve readability */
                .email-container p {
                    font-size: 17px !important;
                }
    
            }
    
        </style>
        <!-- Progressive Enhancements : END -->
    
        <!-- 3-column responsive layout for html email : BEGIN -->
        <style type="text/css">
            /* Client-specific Styles */
            #outlook a {
                padding: 0;
            } /* Force Outlook to provide a "view in browser" menu link. */
            body {
                width: 100% !important;
                -webkit-text-size-adjust: 100%;
                -ms-text-size-adjust: 100%;
                margin: 0;
                padding: 0;
            }
            /* Prevent Webkit and Windows Mobile platforms from changing default font sizes, while not breaking desktop design. */
            .ExternalClass {
                width: 100%;
            } /* Force Hotmail to display emails at full width */
            .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {
                line-height: 100%;
            } /* Force Hotmail to display normal line spacing.  More on that: http://www.emailonacid.com/forum/viewthread/43/ */
            #backgroundTable {
                margin: 0;
                padding: 0;
                width: 100% !important;
                line-height: 100% !important;
            }
            img {
                outline: none;
                text-decoration: none;
                border: none;
                -ms-interpolation-mode: bicubic;
            }
            a img {
                border: none;
            }
            .image_fix {
                display: block;
            }
            p {
                margin: 0px 0px !important;
            }
            table td {
                border-collapse: collapse;
            }
            table {
                border-collapse: collapse;
                mso-table-lspace: 0pt;
                mso-table-rspace: 0pt;
            }

            /* IPHONE STYLES */
            @media only screen and (max-width: 600px) {
            table {
                position: relative;
            }

            table[class="fluid-table"], td[class="fluid-cell"]{
                width: 100% !important;
                padding: 20px 0px 20px 0px!important;
            }

            img[class="fluid-image"] {
                width: 100% !important;
                height: auto !important;
            }
            }
            </style>
        <!-- 3-column responsive layout for html email : END -->

        <!-- custom : BEGIN -->
            <style>
            .bg-red {
                color: white;
                background-color: #b81413;
                border: 5px solid #D06262;
            }
            .bg-yellow {
                color: white;
                background-color: #EA6700;
                border: 5px solid #EF8939;
            }
            .bg-red.highlight {
                border: 5px dashed #D06262;
            }
            .bg-yellow.highlight {
                border: 5px dashed #EF8939;
            }
            </style>
        <!-- custom : END -->
    </head>
    <!--
        The email background color (#35355A) is defined in three places:
        1. body tag: for most email clients
        2. center tag: for Gmail and Inbox mobile apps and web versions of Gmail, GSuite, Inbox, Yahoo, AOL, Libero, Comcast, freenet, Mail.ru, Orange.fr
        3. mso conditional: For Windows 10 Mail
    -->
    <body width="100%" style="margin: 0; padding: 0 !important; mso-line-height-rule: exactly; background-color: #35355A;">
        <center style="width: 100%; background-color: #35355A;">
        <!--[if mso | IE]>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #35355A;">
        <tr>
        <td>
        <![endif]-->
    
            <!-- Visually Hidden Preheader Text : BEGIN -->
            <div style="display: none; font-size: 1px; line-height: 1px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; mso-hide: all; font-family: sans-serif;">
                <cfoutput>
                    #variables.email_preheader_text#
                </cfoutput>
            </div>
            <!-- Visually Hidden Preheader Text : END -->
    
            <!-- Create white space after the desired preview text so email clients don’t pull other distracting text into the inbox preview. Extend as necessary. -->
            <!-- Preview Text Spacing Hack : BEGIN -->
            <div style="display: none; font-size: 1px; line-height: 1px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; mso-hide: all; font-family: sans-serif;">
                &zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;
            </div>
            <!-- Preview Text Spacing Hack : END -->
    
            <!--
                Set the email width. Defined in two places:
                1. max-width for all clients except Desktop Windows Outlook, allowing the email to squish on narrow but never go wider than 600px.
                2. MSO tags for Desktop Windows Outlook enforce a 600px width.
            -->
            <div style="max-width: 600px; margin: 0 auto;" class="email-container">
                <!--[if mso]>
                <table align="center" cellspacing="0" cellpadding="0" border="0" width="600">
                <tr>
                <td>
                <![endif]-->
    
                <!-- Email Body : BEGIN -->
                <table align="center" cellspacing="0" cellpadding="0" border="0" width="100%" style="margin: auto;">
                <!-- Email Header : BEGIN -->
                <tr>
                    <td style="padding: 20px 0; text-align: center">
                        <img src="http://ourladyofsorrows-academy.com/sites/sspx/files/media/usa-s-phoenix/pub-academy/olosa-email-crest.png" width="140" height="140" alt="OLOSA crest" border="0" style="height: auto; background: #35355A; font-family: sans-serif; font-size: 15px; line-height: 15px; color: 555555;">
                    </td>
                </tr>
                <!-- Email Header : END -->
    
                <!-- Hero Image, Flush : BEGIN -->
                <tr>
                    <td style="background-color: #ffffff;">
                        <img src="http://cavaliersraffle.com/images/cavaliers-raffle-email.jpg" width="600" height="" alt="CavaliersRaffle.com logo" border="0" style="width: 100%; max-width: 600px; height: auto; background: dddddd; font-family: sans-serif; font-size: 15px; line-height: 15px; color: 555555; margin: auto; display: block;" class="g-img">
                    </td>
                </tr>
                <!-- Hero Image, Flush : END -->
    
                <!-- 1 Column Text + Button : BEGIN -->
                <tr>
                    <td style="background-color: #ffffff;">
                        <!-- Email Body Content: BEGIN -->