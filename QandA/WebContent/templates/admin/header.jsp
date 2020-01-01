<%@page import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*"%>
<%!
	public boolean isUserLoggedIn( User u ) {
		return u != null;
	}

	public String getURL( String type ) {
		if( type.equals("registerURL") )
			return URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqUser.class ), "create" );
		if( type.equals("loginURL") )
			return URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqLoginInfo.class ), "create" );
		if( type.equals("logoutURL") )
			return URLUtil.getPageURL("logout.jsp");
		if( type.equals("homeURL") )
			return URLUtil.getPageURL( "categories-list.jsp" );
		if( type.equals("usersListURL") )
			return URLUtil.getPageURL( "users-list.jsp" );
		return "";			
	}
	
	public String getURL( String type, User u ) {
		if( type.equals("profileURL") ) {
			if( u != null ) {
				return URLUtil.getObjectURL( u.getUid(), "read" );
			}
		}
		return "";
	}
%>
<%
	FaqUser u = (FaqUser) session.getAttribute("u");
	boolean isUserLoggedIn = isUserLoggedIn(u);			
%>
	<div class="start">
		<a href='<%= getURL("homeURL")  %>'>Home</a>
		<a href='<%= getURL("usersListURL") %>'>Users List</a>
		
	</div>
	<div class="list">
		<a href="<%= getURL( "registerURL" ) %>">Sign Up</a>
		<a href="<%= getURL( "loginURL" ) %>">Login</a>
		<% if( isUserLoggedIn ) { %>
			<p>Welcome <%= u.getLoginName() %>.&nbsp;View your&nbsp;<a href='<%= getURL( "profileURL", u ) %>'>profile</a>.</p>
			<a href='<%= getURL( "logoutURL" ) %>'>Logout</a>
		<% } %>
	</div>