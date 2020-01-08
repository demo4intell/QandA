<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
<%!

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public FaqCategory getCategory( String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		return faqs.getCategoryObject(oid);
	}

%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String deleteCat = getParameter( request.getParameter("deleteCat") );
	
	FaqCategory cat = getCategory( oid );
	if( deleteCat.equals("yes") )
		cat.delete();
%>

<jsp:forward page='../../page.jsp'>
		<jsp:param value='file' name='viewtype'/>
		<jsp:param value='categories-list' name='file'/>
		<jsp:param value='<%= deleteCat.equals("yes") ? "One Category has been removed." : "" %>' name='message'/>
</jsp:forward>