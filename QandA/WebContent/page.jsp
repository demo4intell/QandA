<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>
<%!
	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

%>
<%
	String viewType = getParameter( request.getParameter("viewtype") );
	String file = getParameter( request.getParameter("file") );
	file = ( viewType.equals("") || file.equals("") ) ? "landing" : file;
	if( viewType.equals("") || viewType.equals("file") ) {
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