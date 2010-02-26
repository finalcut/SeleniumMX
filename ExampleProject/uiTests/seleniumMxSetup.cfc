<cfcomponent displayname="setup" extends="mxunit.framework.TestCase" output="false">
        <cffunction name="testSetup" access="public">
				<cfset var l = structNew() />
				<cfset l.coms = getComponents("setup") />

				<cfloop list="#l.coms#" index="l.com">
					<cfinvoke
						component="#l.com#"
						method="testUIsetup" />
				</cfloop>

				<cfset buildMasterSuite() />
        </cffunction>


		<!--- framework helper mixin; don't delete this --->
		<cfinclude template="_seleniumMXHelper.cfm">


		<cffunction name="buildMasterSuite" access="public" returntype="string">
                <cfset var l = structNew() >
				<cfset var d = "" />
                <cfset l.path = ExpandPath('#variables.instance.rootpath#') />
				<cfset l.coms = "" />

                <cfdirectory action="list" type="file" recurse="yes" name="d" directory="#l.path#" filter="*.html*" />
				<cfquery name="l.dir" dbtype="query">
					SELECT * FROM d WHERE directory NOT LIKE '%.svn%' AND NAME NOT LIKE '%.svn%' AND UPPER(NAME) NOT LIKE '%SUITE%'
				</cfquery>

				<cfset l.tests = ArrayNew(1) />
                
				<cfloop query="l.dir">
					<cfset l.path = ReplaceNoCase(l.dir.directory, ExpandPath("#variables.instance.rootpath#"), "") />
					<cfset l.test = "#l.path#\#l.dir.name#" >
					<cfset ArrayAppend(l.tests,l.test) />
                </cfloop>
			<cfsavecontent variable="l.html"><?xml version="1.0" encoding="UTF-8"?><cfoutput>
			<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
			<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
			<head>
			  <meta content="text/html; charset=UTF-8" http-equiv="content-type" />
			  <title>Test Suite</title>
			</head>
			<body>
			<table id="suiteTable" cellpadding="1" cellspacing="1" border="1" class="selenium"><tbody>
			<tr><td><b>Test Suite</b></td></tr><cfloop from="1" to="#ArrayLen(l.tests)#" index="l.t"><cfsilent>
			<cfset l.testLink = l.tests[l.t] />
			<cfset l.testName = ListGetAt(l.testLink, ListLen(l.testLink, "\"), "\") />
			<cfset l.testName = ListGetAt(l.testName, 1, ".") /></cfsilent>
			<cfset l.testLink = Replace(l.testLink, "\", "/", "all") />
			<tr><td><a href="#l.testLink#">#l.testName#</a></td></tr></cfloop>
			</tbody></table>
			</body>
			</html></cfoutput></cfsavecontent>
			<cffile action="write" file="#ExpandPath('#variables.instance.rootpath#')#\MasterSuite.html" output="#l.html#" addnewline="no">
		</cffunction>

</cfcomponent>