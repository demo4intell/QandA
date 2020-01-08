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

	public FaqAnswer getAnswer( String oid, FaqQuestion ques ) {
		return ques.getAnswerObject(oid);
	}

%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String quesuid = getParameter( request.getParameter("quesuid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String deleteAnswer = getParameter( request.getParameter("deleteAnswer") );
	
	FaqAnswer ans = getAnswer( oid, getQuestion( quesuid, getCategory( catuid ) ) );
	if( deleteAnswer.equals("yes") )
		ans.delete();
%>

<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='object' name='viewtype'/>
		<jsp:param value='<%= quesuid %>' name='oid'/>
		<jsp:param value='<%= deleteAnswer.equals("yes") ? "One Answer has been removed." : "" %>' name='message'/>
</jsp:forward>