<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = null;
	FaqQuestion ques = null;
	FaqUser current = null;
	
	public boolean isCurrentUser( ) {
		return current != null;
	}
%>
<%
	String oid = request.getParameter("oid");
	String catuid = request.getParameter("catuid");
	String message = request.getParameter("message");
	cat = faqs.getCategoryObject(catuid);
	ques = cat.getQuestionObject(oid);
	current = (FaqUser) session.getAttribute("u");
	String editURL = ques.getObjectURL(oid, "edit");
	String addAnswerURL = ques.getActionURL(oid, "perform", "addAnswer");
	session.setAttribute("sessionquestion", null);
%>
<h1>Question Details</h1>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser() ) {
%>
	
<p><a href='<%= editURL%>'>Edit Question</a></p>
<p><a href='<%= addAnswerURL%>'>Add Answer</a></p>
<%
	}
	int i = 0;
%>
<p>Question Text: <%= ques.getText() %>.</p>

<h2>Answers</h2>

<table border='2'>
	<tr>
		<td>SNo</td>
		<td>Answer Text</td>
		<td>Actions</td>
	</tr>
<%
	for( FaqAnswer a : ques.getAnswers() ) {
		i++;
		String viewAnswerURL = a.getObjectURL(a.getUid(), "read");
%>
	<tr>
		<td><%= i %></td>
		<td><%= a.getText() %></td>
		<td>
			<a href='<%= viewAnswerURL %>'>View</a>
			&nbsp;&nbsp;
			<a href=''>Delete</a></td>
	</tr>

<%
	}
%>
</table>