<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqUser user = null;
	FaqUser current = null;
	
	public boolean isCurrentUser( ) {
		return current != null && current.getUid().equals(user.getUid());
	}
%>
<%
	String oid = request.getParameter("oid");
	String message = request.getParameter("message");
	user = faqs.getUserObject(oid);
	current = (FaqUser) session.getAttribute("u");
	String editURL = user.getObjectURL(oid, "edit");
	String resetPasswordURL = user.getActionURL(oid, "perform", "resetPassword");
	session.setAttribute("sessionuser", null);
%>
<h1>User Details</h1>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser() ) {
%>
	
<p><a href='<%= editURL%>'>Edit User</a></p>
<p><a href='<%= resetPasswordURL %>'>Reset Password</a></p>
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
	<p><%= cat.getName() %>	
<%
		}
	}
%>