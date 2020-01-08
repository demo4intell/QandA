<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	public boolean isCurrentUser( FaqUser current, FaqUser user ) {
		return current != null && current.getUid().equals(user.getUid());
	}

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}
	
	public String getURL( String type, FaqUser user ) {
		switch( type ) {
			case "editURL":
				return user.getObjectURL(user.getUid(), "edit");
			case "resetPasswordURL":
				return user.getActionURL(user.getUid(), "perform", "resetPassword");
			case "deactivateURL":
				return user.getActionURL( user.getUid(), "perform", "deactivate" );
			case "reactivateURL":
				return user.getActionURL( user.getUid(), "perform", "reactivate" );
			default:
				return "";
		}
	}

%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String message = getParameter( request.getParameter("message") );
		
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqUser user = faqs.getUserObject(oid);
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	session.setAttribute("requestuser", null);
%>
<h2>User Details</h2>
<%
	if( !message.equals("") ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser( current, user ) && current.getStatus().equals("Active") ) {
%>
	
<p><a href='<%= getURL( "editURL", user ) %>'>Edit User</a></p>
<p><a href='<%= getURL( "resetPasswordURL", user ) %>'>Reset Password</a></p>
<% if( user.getStatus().equals("Active") && !current.getLoginName().equals("admin") ) { %>
	<p><a href='<%= getURL( "deactivateURL", user ) %>'>Deactivate Account</a></p>
<% } } %>
<% if( user.getStatus().equals("Inactive") && current.getLoginName().equals("admin") ) { %>
	<p><a href='<%= getURL( "reactivateURL", user ) %>'>Reactivate Account</a></p>
<% } %>

<p>First name is <%= user.getFirstName() %>.</p>
<p>Last name is <%= user.getSurname() %>.</p>
<p>Login name is <%= user.getLoginName() %>.</p>
<p>Age is <%= user.getAge() %>.</p>
<p>Thumbnail URL is <%= user.getThumbnailURL() %>.</p>
<p>Status is <%= user.getStatus() %></p>
<p>You selected these topics:</p>
<%
	if( user.getCategoryTopics().size() == 0 ) {
%>
	<p>No topics selected.</p>
<%
	} else {
		for( FaqCategory cat : user.getCategoryTopics() ) {
%>
	<p><%= cat.getName() %></p>	
<%
		}
	}
%>