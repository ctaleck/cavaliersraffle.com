<cfmail
            to = "cavaliersraffle@olosa.org"
            bcc = "cavaliersraffle@olosa.org"
            from = "admin@cavaliersraffle.com"
            failto = "cavaliersraffle@olosa.org"
            subject = "Test"
            type="html"
            server = "localhost">
            <cfmailpart type="html">
            <p>Test email from Cold Fusion server localhost</p>
            </cfmailpart>
</cfmail>
<p>Email test...</p>