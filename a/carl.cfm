
<cfinclude template="header.cfm">
	<cfquery name="selDups" datasource="#request.datasource#">
    	select distinct
               [ID],
               pb_start_date as start_date,
               pb_end_date as end_date
               <!--- convert(varchar(10), [pb_start_date], 101) as start_date,
               convert(varchar(10), [pb_end_date], 101) as end_date --->
          from #variables.str_raffle#
          order by 2
    </cfquery>

	<cfset variables.start_month = 10>
    <cfset variables.start_day = 01>
    <cfset variables.start_year = 2018>
    
    <cfset variables.start_yourDate = CreateDate(variables.start_year, variables.start_month, variables.start_day)> 

    <cfif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Monday">
        <cfset variables.start_NextFriday = variables.start_day + 4>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Tuesday">
        <cfset variables.start_NextFriday = variables.start_day + 3>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Wednesday">
        <cfset variables.start_NextFriday = variables.start_day + 2>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Thursday">
        <cfset variables.start_NextFriday = variables.start_day + 1>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Friday">
        <cfset variables.start_NextFriday = variables.start_day + 7>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Saturday">
        <cfset variables.start_NextFriday = variables.start_day + 6>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.start_yourDate)) is "Sunday">
        <cfset variables.start_NextFriday = variables.start_day + 5>
    </cfif>

    <cfset variables.start_NextDate = dateformat(variables.start_month & "/" & variables.start_NextFriday & "/" & variables.start_year,"mm/dd/yyyy")>
    <!--- #variables.start_NextDate# --->



    <!--- This process determines the actual drawing date for display in the MailChimp report --->
    <!--- 
        The process is that the drawing date will be the first Friday of the month, except when that first Friday is the first ex: 09/01/2018
        In that case, it would be the NEXT Friday.
    --->
    <cfset variables.end_month = 09>
    <cfset variables.end_day = 01>
    <cfset variables.end_year = 2019>
    
    <cfset variables.end_yourDate = CreateDate(variables.end_year, variables.end_month, variables.end_day)> 

    <cfif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Monday">
        <cfset variables.end_NextFriday = variables.end_day + 4>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Tuesday">
        <cfset variables.end_NextFriday = variables.end_day + 3>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Wednesday">
        <cfset variables.end_NextFriday = variables.end_day + 2>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Thursday">
        <cfset variables.end_NextFriday = variables.end_day + 1>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Friday">
        <cfset variables.end_NextFriday = variables.end_day + 7>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Saturday">
        <cfset variables.end_NextFriday = variables.end_day + 6>
    <cfelseif DayOfWeekAsString(DayOfWeek(variables.end_yourDate)) is "Sunday">
        <cfset variables.end_NextFriday = variables.end_day + 5>
    </cfif>

    <cfset variables.end_NextDate = dateformat(variables.end_month & "/" & variables.end_NextFriday & "/" & variables.end_year,"mm/dd/yyyy")>
    <!--- #variables.end_NextDate# --->

	<cftransaction>
        <cfquery name="UpdateDonors" datasource="#request.datasource#">
            update #variables.str_raffle#
               set pb_start_date = <cfqueryparam value="#variables.start_NextDate#" cfsqltype="cf_sql_date">,
                   pb_end_date = <cfqueryparam value="#variables.end_NextDate#" cfsqltype="cf_sql_date">
             where pb_start_date = {ts '2018-10-01 00:00:00'}
        </cfquery> 
    </cftransaction>


    <table border="1" cellpadding="2" cellspacing="0" align="center">
        <tr bgcolor="lightgrey">
            <th>ID</th>
            <th>Start Date</th>
            <th>End Date</th>
        </tr>
        <cfoutput query="selDups">
                <tr style="text-align:left">
                	<td>#selDups.ID#</td>
                	<td>#selDups.start_date#</td>
                	<td>#selDups.end_date#</td>
                </tr>
		</cfoutput>
    </table>

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