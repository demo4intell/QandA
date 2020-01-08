<%@page import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*"%>
<%
	FaqUser u = (FaqUser) session.getAttribute("u");
	boolean isUserLoggedIn = isUserLoggedIn(u);			
%>
	<div class="start">
		<a href='<%= getURL("homeURL") %>'>Home</a>
		<a href='<%= getURL("catListURL") %>'>Categories List</a>
		<% if( isUserLoggedIn ) { %>
		<a href='<%= getURL("usersListURL") %>'>Users List</a>
		<% } %>
		
	</div>
	<div class="list">
		<% if( !isUserLoggedIn ) { %>
			<a href="<%= getURL( "registerURL" ) %>">Sign Up</a>
			<a href="<%= getURL( "loginURL" ) %>">Login</a>
		<% } else { %>
			<p>Welcome <%= u.getLoginName() %>.&nbsp;View your&nbsp;
				<a href='<%= getURL( "profileURL", u ) %>'>profile</a>.
			</p>
			<a href='<%= getURL( "logoutURL" ) %>'>Logout</a>
		<% } %>
	</div>