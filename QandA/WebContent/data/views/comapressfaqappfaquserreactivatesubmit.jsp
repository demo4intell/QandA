<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
<%!

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}
%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String reactivateUser = getParameter( request.getParameter("reactivateUser") );
	FaqUser user = faqs.getUserObject(oid);
	if( reactivateUser.equals("yes") )
		user.setStatus("Active");
%>

<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='object' name='viewtype'/>
		<jsp:param value='<%= user.getUid()%>' name='oid'/>
		<jsp:param value='<%= reactivateUser.equals("yes") ? "This profile has been reactivated." : "" %>' name='message'/>
</jsp:forward>