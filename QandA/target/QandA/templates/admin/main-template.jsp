<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>
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
				<% String viewType = request.getParameter("viewtype"); %>
				<%@ include file="breadcrumbs.jsp" %>
				<%
					if( viewType.equals("file") ) {
						String file = request.getParameter("file");
						file = "../../data/custom/"+file;
				%>
				<jsp:include page='<%= file %>' />
				<%
					} else if( viewType.equals("object") ) {
				%>
				<jsp:include page='../../data/custom/object.jsp'/>
				<% 	} else if( viewType.equals("action") ) { %>
						<jsp:include page='../../data/custom/action.jsp'/>
				<% } %>
			</main>
			<footer class="footer">
				<%@ include file="footer.jsp" %>
			</footer>
		</div>

	</body>
</html>
