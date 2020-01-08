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
	
	public String getSubmitURL( FaqQuestion ques, String view, String oid ) {
		return ques.getActionURL(oid, view+"submit", "delete");
	}
	
	public String getCancelURL( FaqQuestion ques ) {
		return ques.getObjectURL( ques.getUid(), "read" );
		
	}
%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter( "catuid" ) );
	String view = getParameter( request.getParameter("view") );
	
	FaqQuestion ques = getQuestion( oid, getCategory( catuid ) );
%>

<h2>Confirm Delete Question</h2>

<form action='<%=getSubmitURL( ques, view, oid )%>' method='POST'>
	
	<label>Are you sure you want to delete this question?</label>
	<input type='radio' name='deleteQues' value='yes'/><span>Yes</span>
	<input type='radio' name='deleteQues' value='no'/><span>No</span>
	
	<input type='submit' value='Submit'/>
	<a href='<%= getCancelURL(ques) %>'>Cancel</a>
</form>