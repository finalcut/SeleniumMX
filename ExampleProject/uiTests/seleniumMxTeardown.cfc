<cfcomponent displayname="teardown" extends="mxunit.framework.TestCase" output="false">
        <cffunction name="testUITeardown" access="public">
				<cfset var l = structNew() />
				<cfset l.coms = getComponents("teardown") />

				<cfloop list="#l.coms#" index="l.com">
					<cfinvoke
						component="#l.com#"
						method="testUIteardown" />
				</cfloop>
        </cffunction>
		<!--- framework helper mixin; don't delete this --->
		<cfinclude template="_seleniumMXHelper.cfm">
</cfcomponent>