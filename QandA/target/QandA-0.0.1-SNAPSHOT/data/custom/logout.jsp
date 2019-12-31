<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import='com.apress.faq.app.*, com.apress.faq.util.*'%>

<%
	session.invalidate();   
%>
<jsp:forward page='../../page.jsp'>
	<jsp:param name='viewtype' value='file'/>
	<jsp:param name="file" value="categories-list.jsp"/>
</jsp:forward>