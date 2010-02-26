<cfcomponent name="charter setup"  extends="exampleProject.uitests.seleniumMxBase" output="false">

	<cffunction name="testUIsetup" access="public">
		<cfset setupTests('Suite1','testSuite1A') />
	</cffunction>


	<!--- 
		a function should exist for EACH UI test that you need to create data for.

		Each function MUST return a struct (it can be empty) and a corresponding function must exist in the teardown.cfc 

		thus, for this example, in teardown.cfc there needs to be a tearDownExampleTest function (also private) that takes in a struct as an 
		argument

		These two functions are TIGHTLY coupled so you need to know about both.

		<cffunction name="exampleTest"	access="private" returntype="struct">
			<cfargument name="data" type="struct" required="true" hint="gives access to data created in other tests run before this one.. ordered via the comma delimited list in setupTests" />

			<cfset var local = structNew() />

			<cfreturn local />
		</cffunction>
	--->

		<cffunction name="testLogin"	access="private" returntype="struct">
			<cfargument name="data" type="struct" required="true" hint="gives access to data created in other tests run before this one.. ordered via the comma delimited list in setupTests" />

			<cfset var outData = structNew() />
			<cfset var local = structNew() />
			<!--- do whatever you need to do here, storing stuff you want in teardown in the "outData" struct" --->

				<!--- if you use ColdSpring you can access and use your objects like this:

				<cfset local.user = getObjFactory().getBean("user") />
				<cfset local.user.setUsername("someUsername") />
				<cfset local.user.setPassword("somePassword") />
				<cfset outData.userID = getObjFactory().getBean("userDAO").save(local.user) />
				
				
				--->

			<cfset outData.userID = 1 />

			<cfreturn outData />
		</cffunction>

</cfcomponent>