<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=application.getInitParameter("ApplicationTitle")%></title>
	</head>
	<body>
		<%@ include file="header.jsp" %>
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
		<%@ include file="footer.jsp" %>
	</body>
</html>
