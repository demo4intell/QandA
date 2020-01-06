<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%!

	public String getURL( String type ) {
		switch( type ) {
			case "registerURL":
				return URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqUser.class ), "create" );
			case "loginURL":
				return URLUtil.getObjectURL( FaqAppUtilManager.getPrefix( FaqLoginInfo.class ), "create" );
			case "logoutURL":
				return URLUtil.getPageURL("logout");
			case "homeURL":
				return URLUtil.getPageURL( "categories-list" );
			case "usersListURL":
				return URLUtil.getPageURL( "users-list" );
			default:
				return "";
		}
	}

	public String getURL( String type, User u ) {
		if( type.equals("profileURL") ) {
			if( u != null ) {
				return URLUtil.getObjectURL( u.getUid(), "read" );
			}
		}
		return "";
	}
	
	public boolean isUserLoggedIn( User u ) {
		return u != null;
	}
	
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=application.getInitParameter("ApplicationTitle")%></title>
		<link href="https://fonts.googleapis.com/css?family=Lusitana&display=swap" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="container">
			<header class="header">
				<%@ include file="header.jsp" %>
			</header>
			<main>
				<% String viewType = getParameter( request.getParameter("viewtype") );
				String file = "../../data/custom/" + ( viewType.equals("file") ? 
							getParameter( request.getParameter("file") ) : viewType ) +".jsp";
				%>
				<%@ include file="breadcrumbs.jsp" %>
				<jsp:include page='<%= file %>' />				
			</main>
			<footer class="footer">
				<%@ include file="footer.jsp" %>
			</footer>
		</div>

	</body>
</html>
