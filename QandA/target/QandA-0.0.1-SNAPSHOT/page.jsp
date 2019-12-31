<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>

<%
	String viewType = request.getParameter("viewtype");
	String file = request.getParameter("file");
	if( viewType == null || file == null )
		file = "categories-list.jsp";
	if( viewType == null || viewType.equals("file") ) {
%>
		<jsp:forward page='templates/admin/main-template.jsp'>
			<jsp:param name='viewtype' value='file'/>
			<jsp:param name='file' value="<%= file %>"/>
		</jsp:forward>
<% 	} else {
%>
	<jsp:forward page='templates/admin/main-template.jsp'/>
<%	}
%>