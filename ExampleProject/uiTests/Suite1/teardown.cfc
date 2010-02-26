<cfcomponent name="charter teardown"  extends="exampleProject.uitests.seleniumMxBase" output="false">

	<cffunction name="testUIteardown" access="public">
		<cfset super.tearDownTests('charter') />
	</cffunction>


	<cffunction name="teardownTestLogin"	access="private" returntype="void">
		<cfargument name="data" type="struct" required="true" />
		<!-- try using a helper method or two if you want --->
		<cfset myHelperMethod(data.userID) />

		<!--- do some more cleanup too! --->
	</cffunction>



	<cffunction name="myHelperMethod" access="private" returntype="void">
		<cfargument name="id" type="numeric" required="true">
		
		<!--- if you use ColdSpring you can access and use your objects like this:

		<cfset getObjFactory().getBean("userDAO").delete(arguments.id) />

		--->

	</cffunction>

</cfcomponent>