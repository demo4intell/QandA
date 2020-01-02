<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>
    
<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	String type = request.getParameter("type");
	String messages = request.getParameter("messages");
	String useruid = request.getParameter("useruid");
	String loginId = request.getParameter("loginId");
	if( type == null )
		type = "login";
	String submitURL = "";
	if( type.equals("login") ) 
		submitURL = URLUtil.getObjectURL(oid, view+"submit");
	else
		submitURL = URLUtil.getActionURL( useruid, "performsubmit", "resetPassword")
			+ "&type=changePassword";
	
%>
<h2><%= type.equals("login") ? "Sign into the FAQ System" : "Reset Password" %></h2>

<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<div>
	<form action='<%=submitURL%>' method='POST'>
		<% if( type.equals("login") ) { %>
		<label>Login Name:</label>
		<input type="text" name="loginId" length="30"/>
		<% } else { %>
		<input type='hidden' name='loginId' value='<%= loginId %>'/>
		<input type='hidden' name='type' value='ChangePassword'/>		
		<label>Old Password:</label>
		<input type='password' name='oldPassword' length='32'/>
		<% } %>					
		<label>Password:</label>
		<input type="password" name="password" length='30'/>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</form>
		<% if( type.equals("changePassword") ) {
			String cancelURL = URLUtil.getObjectURL(useruid, "read");
		%>
		<p><a href='<%= cancelURL%>'>Cancel</a></p>
		<% } %>
</div>
