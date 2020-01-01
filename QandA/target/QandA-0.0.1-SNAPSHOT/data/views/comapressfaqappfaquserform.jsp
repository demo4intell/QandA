<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>
    
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	
	
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}
	
%>
<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	FaqUser sessionU = (FaqUser) session.getAttribute("sessionuser");
	FaqUser user = null;
	String submitURL = URLUtil.getObjectURL(oid, view+"submit");
	if( view.equals("edit") && !isOidPrefix(oid) ) {
		user = faqs.getUserObject(oid);
		submitURL = user.getObjectURL(oid, view+"submit");
	}
		
	String messages = request.getParameter("messages");
	FaqUser tempUser = sessionU;
	if( tempUser == null )
		tempUser = user;	
%>
<h2><%= user == null ? "Register User" : "Edit User Profile" %></h2>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=submitURL%>' method='POST'>
	<label>First Name:</label>
	<input type="text" name="firstName" length="30" value='<%= tempUser != null && tempUser.getFirstName() != null ? tempUser.getFirstName() : "" %>'/>
	<label>Surname:</label>
	<input type="text" name="surname" length="30" value='<%= tempUser != null && tempUser.getSurname() != null ? tempUser.getSurname() : "" %>'/>				
	<label>Login Name:</label>
	<% if( user == null ) { %>
	<input type="text" name="loginName" length="30" value='<%= tempUser != null && tempUser.getLoginName() != null ? tempUser.getLoginName() : "" %>'/><% } else { %>
	<%= user.getLoginName() %>
	<% } %>
	<label>Age:</label>
	<input type="text" name="age" length="5" value='<%= tempUser != null && tempUser.getAge() > 0 ? tempUser.getAge() : "" %>'/>					
	<% if( user == null ) { %>
	<label>Password:</label>
	<input type='password' name='password' length='32'/>
	<% } %>
	<%
		for( FaqCategory cat : faqs.getCategories() ) {
	%>
	<input type='checkbox' name='topics' value='<%= cat.getUid() %>' <%= tempUser != null ? ( tempUser.hasSelectedCategory( cat.getUid() ) ? "checked" : "" ) : "" %> /><%= cat.getName() %>
	<%	}	%>
	<input type='submit' value='Submit'/>
	<input type='reset' value='Reset'/>
	<% String cancelURL = "";
		if( user == null )
			cancelURL = URLUtil.getPageURL("categories-list.jsp");
		else 
			cancelURL = user.getObjectURL( user.getUid(), "read" );
	%>
	<a href='<%= cancelURL %>'><button>Cancel</button></a>
</form>