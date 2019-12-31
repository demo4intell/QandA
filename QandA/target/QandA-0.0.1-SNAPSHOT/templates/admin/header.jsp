<%@page import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*"%>
<p><a href='<%= URLUtil.getPageURL( "categories-list.jsp" ) %>'>Home</a>
&nbsp;&nbsp;<a href='<%= URLUtil.getPageURL( "users-list.jsp" ) %>'>Users List</a></p>
<%
	FaqUser u = (FaqUser) session.getAttribute("u");
	String registerURL = URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqUser.class ), "create" );
	String loginURL = URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqLoginInfo.class ), "create" );
	String logoutURL = URLUtil.getPageURL("logout.jsp");
	
	if( u == null ) {
%>
	<p>
		<a href="<%= registerURL %>">Sign Up</a>
		&nbsp;&nbsp;<a href="<%= loginURL %>">Login</a>
	</p>
<%
	} else {
		String profileURL = URLUtil.getObjectURL( u.getUid(), "read" );
%>
	<p>Welcome <%= u.getLoginName() %>&nbsp;&nbsp;View your&nbsp;<a href='<%= profileURL %>'>profile</a>&nbsp;&nbsp;<a href='<%= logoutURL %>'>Logout</a>
<% 	} %>
<hr/>