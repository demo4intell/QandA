<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>

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

	public String getSubmitURL( FaqAnswer ans, String view, String oid ) {
		return ans.getActionURL(oid, view+"submit", "delete");
	}
	
	public String getCancelURL( FaqAnswer ans ) {
		return ans.getObjectURL( ans.getUid(), "read" );
		
	}
%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String quesuid = getParameter( request.getParameter("quesuid") );
	String catuid = getParameter( request.getParameter( "catuid" ) );
	String view = getParameter( request.getParameter("view") );
	
	FaqAnswer ans = getAnswer( oid, getQuestion( quesuid, getCategory( catuid ) ) );
%>

<h2>Confirm Delete Answer</h2>

<form action='<%=getSubmitURL( ans, view, oid )%>' method='POST'>
	
	<label>Are you sure you want to delete this answer?</label>
	<input type='radio' name='deleteAnswer' value='yes'/><span>Yes</span>
	<input type='radio' name='deleteAnswer' value='no'/><span>No</span>
	
	<input type='submit' value='Submit'/>
	<a href='<%= getCancelURL(ans) %>'>Cancel</a>
</form>