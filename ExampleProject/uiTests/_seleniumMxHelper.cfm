		<!--- framework settings mixin; don't delete this --->
		<cfinclude template="_seleniumMXSettings.cfm">

		<cffunction name="getComponents" access="public" returntype="string">
			<cfargument name="mode" type="string" required="true" hint="setup or teardown" />
                <cfset var l = structNew() >
				<cfset var d = "" />
                <cfset l.path = ExpandPath(variables.instance.rootPath) />
				<cfset l.coms = "" />

                <cfdirectory action="list" type="dir" recurse="yes" name="d" directory="#l.path#" />
				<cfquery name="l.dir" dbtype="query">
					SELECT * FROM d WHERE directory NOT LIKE '%.svn%' AND NAME NOT LIKE '%.svn%'
				</cfquery>
                <cfloop query="l.dir">
					<cfif NOT FindNoCase(l.dir.directory, ".svn")>
						<cfif FileExists(l.dir.directory & "\#l.dir.name#\#arguments.mode#.cfc")>

							<cfset l.comPath = "#l.dir.directory#\#l.dir.name#" />
							<cfset l.comPath = Replace(l.comPath, l.path, variables.instance.cfcpath) />
							<cfset l.comPath = l.comPath & ".#arguments.mode#" />
							<cfset l.coms = ListAppend(l.coms, l.comPath) />
						</cfif>
					</cfif>
                </cfloop>
				<cfreturn l.coms />
		</cffunction>
