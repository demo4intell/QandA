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

	public String getURL( String type, FaqQuestion ques ) {
		String quesuid = ques.getUid();
		switch( type ) {
			case "editURL":
				return ques.getObjectURL( quesuid, "edit" );
			case "addAnswerURL":
				return ques.getActionURL(ques.getUid(), "perform", "addAnswer");
			case "deleteURL":
				return ques.getActionURL( ques.getUid(), "perform", "delete" );
			default:
				return "";
		}
	}
	
	public String getURL( String type, FaqAnswer answer ) {
		String ansuid = answer.getUid();
		switch( type ) {
			case "readURL":
				return answer.getObjectURL(ansuid, "read");
			case "deleteURL":
				return answer.getActionURL(ansuid, "perform", "delete");				
			default:
				return "";
		}
	}

%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String message = getParameter( request.getParameter("message") );
	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = cat.getQuestionObject(oid);
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	session.setAttribute("sessionquestion", null);
%>
<h1>Question Details</h1>
<%
	if( message != null ) {
%>
	<h2><%= message %></h2>
<%
	}
	if( isCurrentUser( current ) && current.getStatus().equals("Active") ) {
%>
	
<p><a href='<%= getURL( "editURL", ques ) %>'>Edit Question</a></p>
<p><a href='<%= getURL( "addAnswerURL", ques )%>'>Add Answer</a></p>
<p><a href='<%= getURL( "deleteURL", ques )%>'>Delete Question</a></p>
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
%>
	<tr>
		<td><%= i %></td>
		<td><%= a.getText() %></td>
		<td>
			<a href='<%= getURL("readURL", a ) %>'>View</a>
			&nbsp;&nbsp;
			<% if( isCurrentUser( current ) && current.getStatus().equals("Active") ) { %>
				<a href='<%= getURL( "deleteURL", a )%>'>Delete</a>
			<% } %>
		</td>
	</tr>

<%
	}
%>
</table>