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
<h1><%= user == null ? "Register User" : "Edit User Profile" %></h1>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=submitURL%>' method='POST'>
	<table>
		<tr>
			<td align='left'>First Name:</td>
			<td align='right'>
				<input type="text" name="firstName" length="30" value='<%= tempUser != null && tempUser.getFirstName() != null ? tempUser.getFirstName() : "" %>'/>
			</td>
		</tr>
		<tr>					
			<td align='left'>Surname:</td>
			<td align='right'>
				<input type="text" name="surname" length="30" value='<%= tempUser != null && tempUser.getSurname() != null ? tempUser.getSurname() : "" %>'/>
			</td>				
		</tr>
		<tr>
			<td align='left'>Login Name:</td>
			<td align='right'>
				<% if( user == null ) { %><input type="text" name="loginName" length="30" value='<%= tempUser != null && tempUser.getLoginName() != null ? tempUser.getLoginName() : "" %>'/><% } else { %>
					<%= user.getLoginName() %>
			<% } %>
			</td>
		</tr>
		<tr>
			<td align='left'>Age:</td>
			<td align='right'>
				<input type="text" name="age" length="5" value='<%= tempUser != null && tempUser.getAge() > 0 ? tempUser.getAge() : "" %>'/>
			</td>					
		</tr>
		<% if( user == null ) { %>
		<tr>
			<td align='left'>Password:</td>
			<td align='right'>
				<input type='password' name='password' length='32'/>
			</td>
		</tr>
		<% } %>
	</table>

<%
	for( FaqCategory cat : faqs.getCategories() ) {
%>
	<br/>
	<input type='checkbox' name='topics' value='<%= cat.getUid() %>' <%= tempUser != null ? ( tempUser.hasSelectedCategory( cat.getUid() ) ? "checked" : "" ) : "" %> /><%= cat.getName() %>
<%	}	%>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<% String cancelURL = "";
	if( user == null )
		cancelURL = URLUtil.getPageURL("categories-list.jsp");
	else 
		cancelURL = user.getObjectURL( user.getUid(), "read" );
%>
<p><a href='<%= cancelURL %>'>Cancel</a></p>