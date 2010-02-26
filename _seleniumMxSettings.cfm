	<cfset variables.instance = structNew() />
	<!--- relative path from webroot to the directory this file is in; MAKE Sure the trailing / is still there! --->
	<cfset variables.instance.rootpath = "/yourproject/uitests/" />
	<!--- In each ui test suite directory the setup method may store some info for the teardown in a file; what do you want the file to be called? --->
	<cfset variables.instance.testSettingsFile = "testSettings.dat" />

	<!--- If you use ColdSpring what is the path to your coldspring.xml file? --->
	<cfset variables.instance.beansXML = "#ExpandPath('/yourproject/config/ColdSpring.xml')#">

	<!--- DONT EDIT THIS ONE : Unless your test components aren't loaded properly due to some weird mapping.  Using the default settings this ends up being exampleProject.uitests. --->
	<cfset variables.instance.cfcpath = Mid(replace(variables.instance.rootPath, "/", ".", "all"), 2, Len(variables.instance.rootpath)-1) />
