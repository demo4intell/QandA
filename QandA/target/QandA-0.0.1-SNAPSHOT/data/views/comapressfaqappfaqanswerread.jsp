<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = null;
	FaqQuestion ques = null;
	FaqAnswer ans = null;
	FaqUser current = null;
	
	public boolean isCurrentUser( ) {
		return current != null;
	}
%>
<%
	String oid = request.getParameter("oid");
	String catuid = request.getParameter("catuid");
	String quesuid = request.getParameter("quesuid");
	
	String message = request.getParameter("message");
	cat = faqs.getCategoryObject(catuid);
	ques = cat.getQuestionObject(quesuid);
	ans = ques.getAnswerObject(oid);
	current = (FaqUser) session.getAttribute("u");
	String editURL = ans.getObjectURL(oid, "edit");
	session.setAttribute("sessionanswer", null);
%>
<h2>Answer Details</h2>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser() ) {
%>
	
<p><a href='<%= editURL%>'>Edit Answer</a></p>
<%
	}
	int i = 0;
%>
<p>Answer Text: <%= ans.getText() %>.</p>