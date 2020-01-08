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

	public FaqQuestion getQuestion( String oid, FaqCategory cat ) {
		return cat.getQuestionObject(oid);
	}

%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String deleteQues = getParameter( request.getParameter("deleteQues") );
	
	FaqQuestion ques = getQuestion( oid, getCategory( catuid ) );
	if( deleteQues.equals("yes") )
		ques.delete();
%>

<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='object' name='viewtype'/>
		<jsp:param value='<%= catuid %>' name='oid'/>
		<jsp:param value='<%= deleteQues.equals("yes") ? "One Question has been removed." : "" %>' name='message'/>
</jsp:forward>