<cfcomponent name="selenium MX Base"  extends="mxunit.framework.TestCase" output="false">
	<!--- CORE TEST METHODS --->
		<cffunction name="setupTests" access="private">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />
			<cfargument name="tests" type="string" required="true" hint="comma separated list of test names to call" />

			<!--- before we call setup always make sure the teardown worked properly --->
			<cfset var local = structNew() />

			<!--- it may be necessary/desirable to save the state or id values of various things to a file that the teardown.cfc will use --->
			<cfif settingsFileExists(arguments.suite)>
				<cfinvoke component="#variables.instance.cfcpath##arguments.suite#.teardown" method="testUIteardown" />
			</cfif>

			<cfset local.settings = StructNew() />
			<cfloop list="#arguments.tests#" index="local.test">
				<cfinvoke method="#local.test#" returnvariable="local.data">
					<cfinvokeargument name="data" value="#local.settings#" />
				</cfinvoke>
				<cfset local.settings["#local.test#"] = local.data />
			</cfloop>

			<cfset saveSettings(local.settings, arguments.suite) />
		</cffunction>

		<cffunction name="tearDownTests" access="private">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />
			<cfset var local = structNew() />
			<!--- use the settings structure to delete anything that was previously setup --->
			<cfset local.settings = getSettings(arguments.suite) />

			<cfloop list="#structKeyList(local.settings)#" index="local.test">
				<cfset local.data = local.settings["#local.test#"] />
				<cfinvoke method="tearDown#local.test#">
					<cfinvokeargument name="data" value="#local.data#" />
				</cfinvoke>
			</cfloop>


			<cfset deleteSettingsFile(arguments.suite) />
		</cffunction>

	<!--- GENERAL HELPER METHODS --->
		<cffunction name="getSuitePath" access="private">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />
			<cfreturn ExpandPath('#variables.instance.rootpath##arguments.suite#') />
		</cffunction>

	<!--- SETTINGS FILE RELATED STUFF --->
		<cffunction name="saveSettings" access="private">
			<cfargument name="settings" type="struct"	required="true" hint="anything you want to save tucked into a structure" />
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />

			<cfset var o = "" />
			<cfset var dirPath = ExpandPath('#variables.instance.rootpath##arguments.suite#') />
			<cfwddx action="cfml2wddx" input="#arguments.settings#" output="o">

			<cffile action="write" output="#o#" file="#dirPath#/#variables.instance.testSettingsFile#">
		</cffunction>
		<cffunction name="getSettings" access="private" returntype="struct">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />

			<cfset var s = "" />
			<cfset var dirPath = getSuitePath(arguments.suite) />
			<cfif settingsFileExists(arguments.suite)>
				<cffile action="read" variable="s"  file="#dirPath#/#variables.instance.testSettingsFile#">
				<cfwddx action="wddx2cfml" input="#s#" output="s" />
			<cfelse>
				<cfset s = StructNew() />
			</cfif>

			<cfreturn s />
			
		</cffunction>
		<cffunction name="settingsFileExists" access="private">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />

			<cfset var dirPath = getSuitePath(arguments.suite) />

			<cfreturn FileExists("#dirPath#/#variables.instance.testSettingsFile#") />
		</cffunction>
		<cffunction name="deleteSettingsFile" access="private">
			<cfargument name="suite" type="string" required="true" hint="name of the directory the test is in; ie.  'charter' or 'containers'" />

			<cfif settingsFileExists(arguments.suite)>
				<cfset local.path = getSuitePath(arguments.suite) />
				<cffile action="delete" file="#local.path#\#variables.instance.testSettingsFile#" />
			</cfif>
		</cffunction>



		<!--- coldspring mixin; delete if you don't use coldspring --->
		<cfinclude template="_seleniumMXColdspring.cfm">


		<!--- framework helper mixin; don't delete this --->
		<cfinclude template="_seleniumMXHelper.cfm">
</cfcomponent>