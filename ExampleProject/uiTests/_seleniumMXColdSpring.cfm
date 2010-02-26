		<cffunction name="setObjFactory" access="private" output="false" returntype="void">
			<cfscript>
				if (not structkeyExists(variables.instance,"objFactory") AND LEN(variables.instance.beansXML))
				{
					variables.instance.objFactory = createObject("component","coldspring.beans.DefaultXMLBeanFactory").init();
					variables.instance.objFactory.loadBeansFromXMLFile("#variables.instance.beansXML#",true);
					variables.instance.objFactory.loadBeans(variables.instance.beansXML);
				}
			</cfscript>
		</cffunction>

		<cffunction name="getObjFactory" access="private" output="false" returntype="any">
			<cfif NOT structKeyExists(variables.instance, "objFactory")>
					<cfset setObjFactory() />
			</cfif>
			<cfreturn variables.instance.objFactory>
		</cffunction>

		<cffunction name="getConfigService" access="private" output="false" returntype="any">
			<cfreturn getObjFactory().getBean("ConfigService") />
		</cffunction>


		<!--- to use these your setup should initialize variables.instance.configService to the configService you need --->
		<cffunction name="getDSN" access="private" returntype="string" output="false">
			<cfreturn getConfigService().getProperty("dsn") />
		</cffunction>

		<cffunction name="getSchemaLocation" access="private" returntype="string" output="false">
			<cfreturn getConfigService().getProperty("SchemaLocation") />
		</cffunction>
