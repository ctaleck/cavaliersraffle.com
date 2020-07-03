<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<!--- Define the list of numbers. --->
<cfset strList = "1,2,3,4,5,6,7,8,9,10" />

<!---
	Create a struct to hold the list of selected numbers. Because
	structs are indexed by key, it will allow us to not select
	duplicate values.
--->
<cfset objSelections = {} />


<!---
	Now, all we have to do is pick random numbers until our
	struct count is the desired size (4 in this demo).
--->
<cfloop condition="(StructCount( objSelections ) LT 1)">

	<!--- Select a random list index. --->
	<cfset intIndex = RandRange( 1, ListLen( strList ) ) />

	<!---
		Add the random item to our collection. If we have
		already picked this number, then it will simply
		overwrite the previous and the StructCount() will
		not be changed.
	--->
	<cfset objSelections[ ListGetAt( strList, intIndex ) ] = true />

</cfloop>


<!--- Output the list collection. --->
<cfoutput>#StructKeyList( objSelections )#</cfoutput>

</body>
</html>