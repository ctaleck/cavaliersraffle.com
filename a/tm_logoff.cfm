<cfset tempvariable = StructDelete(session,"activepswd")>
<cfcookie name="activepswd" secure="yes"  expires="now" httponly="yes" encodevalue="yes">

<cflocation url="index.cfm">

