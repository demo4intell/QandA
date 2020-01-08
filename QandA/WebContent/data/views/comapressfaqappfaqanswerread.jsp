<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	public boolean isCurrentUser( FaqUser current ) {
		return current != null;
	}

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}
	
	public String getURL( String type, FaqAnswer ans ) {
		String ansuid = ans.getUid();
		switch( type ) {
			case "editURL":
				return ans.getObjectURL( ansuid, "edit" );
			case "deleteURL":
				return ans.getActionURL( ansuid, "perform", "delete" );
			default:
				return "";
		}
	}

%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String quesuid = getParameter( request.getParameter("quesuid") );	
	String message = getParameter( request.getParameter("message") );
	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = cat.getQuestionObject(quesuid);
	FaqAnswer ans = ques.getAnswerObject(oid);
	FaqUser current = (FaqUser) session.getAttribute("u");
	request.setAttribute("requestanswer", null);
%>
<h2>Answer Details</h2>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser( current ) && current.getStatus().equals("Active") ) {
%>
	
<p><a href='<%= getURL("editURL", ans ) %>'>Edit Answer</a></p>
<p><a href='<%= getURL("deleteURL", ans ) %>'>Delete Answer</a></p>
<%
	}
	int i = 0;
%>
<p>Answer Text: <%= ans.getText() %>.</p>