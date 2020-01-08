<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>
<%!
	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public String getType( String type ) {
		return type.equals("") ? "login" : type;
	}
	
	public String getURL( String urlType, String oid, String view, String type, String useruid ) {
		switch( urlType ) {
			case "submitURL":
				return type.equals("login") ? URLUtil.getObjectURL(oid, view+"submit") : 
					URLUtil.getActionURL( useruid, "performsubmit", "resetPassword") + 
					"&type=changePassword";
			case "cancelURL":
				return type.equals("changePassword") ? URLUtil.getObjectURL(useruid, "read")
						: URLUtil.getPageURL("landing");
			default:
				return "";
		}
	}
	
	public String getPageTitle( String type ) {
		return type.equals("login") ? "Sign into the FAQ System" : "Reset Password";
	}

%>
    
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String type = getType( getParameter( request.getParameter("type") ) );	
	String messages = getParameter( request.getParameter("messages") );
	String useruid = getParameter( request.getParameter("useruid") );
	String loginId = getParameter( request.getParameter("loginId") );
	
%>
<h2><%= getPageTitle(type) %></h2>

<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>

<div>
	<form action='<%=getURL( "submitURL", oid, view, type, useruid )%>' method='POST'>
	
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
	<p><a href='<%= getURL("cancelURL", oid, view, type, useruid )%>'>Cancel</a></p>
</div>