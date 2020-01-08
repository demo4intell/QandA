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

	public String getURL( String type, FaqCategory cat ) {
		switch( type ) {
			case "editURL":
				return cat.getObjectURL(cat.getUid(), "edit");
			case "addQuestionURL":
				return cat.getActionURL(cat.getUid(), "perform", "addQuestion");
			case "deleteURL":
				return cat.getActionURL( cat.getUid(), "perform", "delete" );
			default:
				return "";
		}
	}
	
	public String getURL( String type, FaqQuestion ques ) {
		switch( type ) {
			case "readURL":
				return ques.getObjectURL(ques.getUid(), "read");
			case "deleteURL":
				return ques.getActionURL( ques.getUid(), "perform", "delete" );
			default:
				return "";
		}
	}

%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String message = getParameter( request.getParameter("message") );
	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = faqs.getCategoryObject(oid);
	FaqUser current = (FaqUser) session.getAttribute("u");
	request.setAttribute("requestcategory", null);
%>
<h1>Category Details</h1>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser( current ) && current.getStatus().equals("Active") ) {
%>
	
<p><a href='<%= getURL( "editURL", cat ) %>'>Edit Category</a></p>
<p><a href='<%= getURL( "addQuestionURL", cat ) %>'>Add Question</a></p>
<p><a href='<%= getURL( "deleteURL", cat ) %>'>Delete Category</a></p>
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
			<a href='<%= getURL( "readURL", q ) %>'>
				View
			</a>
			&nbsp;&nbsp;
			<% if( isCurrentUser( current ) && current.getStatus().equals("Active") ) { %>
				<a href='<%= getURL( "deleteURL", q ) %>'>Delete</a></td>
			<% } %>
	</tr>

<%
	}
%>
</table>