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
	
	String editURL = user.getObjectURL(oid, "edit");
	String resetPasswordURL = user.getActionURL(oid, "perform", "resetPassword");
	session.setAttribute("sessionuser", null);
%>
<h2>User Details</h2>
<%
	if( !message.equals("") ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser( current, user ) ) {
%>
	
<p><a href='<%= getURL( "editURL", user ) %>'>Edit User</a></p>
<p><a href='<%= getURL( "resetPasswordURL", user ) %>'>Reset Password</a></p>
<%
	}
%>
<p>First name is <%= user.getFirstName() %>.</p>
<p>Last name is <%= user.getSurname() %>.</p>
<p>Login name is <%= user.getLoginName() %>.</p>
<p>Age is <%= user.getAge() %>.</p>
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