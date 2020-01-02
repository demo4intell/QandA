<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.ArrayList"%>
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = null;
	FaqUser current = null;
	
	public boolean isCurrentUser( ) {
		return current != null;
	}
%>
<%
	String oid = request.getParameter("oid");
	String message = request.getParameter("message");
	cat = faqs.getCategoryObject(oid);
	current = (FaqUser) session.getAttribute("u");
	String editURL = cat.getObjectURL(oid, "edit");
	String addQuestionURL = cat.getActionURL(oid, "perform", "addQuestion");
	session.setAttribute("sessioncategory", null);
%>
<h1>Category Details</h1>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser() ) {
%>
	
<p><a href='<%= editURL%>'>Edit Category</a></p>
<p><a href='<%= addQuestionURL%>'>Add Question</a></p>
<%
	}
	int i = 0;
%>
<p>Category name is <%= cat.getName() %>.</p>
<p>Image URL is <%= cat.getImageURL() %>.</p>

<h2>Questions</h2>

<table border='2'>
	<tr>
		<td>SNo</td>
		<td>Question Text</td>
		<td>Num of Answers</td>
		<td>Actions</td>
	</tr>
<%
	for( FaqQuestion q : cat.getQuestions() ) {
		i++;
		String viewQuestionURL = q.getObjectURL(q.getUid(), "read");
%>
	<tr>
		<td><%= i %></td>
		<td><%= q.getText() %></td>
		<td><%= q.getAnswers().size() %></td>
		<td>
			<a href='<%= viewQuestionURL %>'>
				View
			</a>
			&nbsp;&nbsp;
			<a href=''>Delete</a></td>
	</tr>

<%
	}
%>
</table>