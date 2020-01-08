<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.*" %>
<%! 
	public String setErrorMessages( ArrayList<String> errorMessages ) {
		String messages = "";
		for( String m : errorMessages ) {
			messages += m +"@";
		}
		return messages;
	}

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}
	
	public FaqCategory getCategory( String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		return faqs.getCategoryObject( oid );
	}
	
	public FaqQuestion getQuestion( String oid, FaqCategory cat ) {
		if( !isOidPrefix(oid) ) {
			return cat.getQuestionObject(oid);		
		}
		return null;
	}
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String view = getParameter( request.getParameter("view") );
	
	FaqQuestion requestQ = (FaqQuestion) request.getAttribute("requestquestion");
	FaqUser current = (FaqUser) session.getAttribute("u");
	FaqCategory cat = getCategory( catuid );
	FaqQuestion ques = getQuestion( oid, cat );
%>
	<jsp:useBean id='requestQues' scope='request' class='com.apress.faq.app.FaqQuestion'>
		<jsp:setProperty name='requestQues' property='*'/>
	</jsp:useBean>
<%
	request.setAttribute( "requestquestion", requestQues );
	String messages = setErrorMessages( requestQues.validate( ques ) );
	if( messages.length() == 0 ) {
		if( ques != null ) {
			ques.copy( requestQues, ques );
		}
		else {
			requestQues.setCategory(cat);			
			requestQues.postCreate(current);
		}
		request.setAttribute("requestquestion", null);
%>
	<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='<%= ques != null ? ques.getUid() : requestQues.getUid() %>' name='oid'/>
		<jsp:param value='<%= ques == null ? "New question added!" : "" %>' name='message'/>
	</jsp:forward>
<%
	} else {
%>
		<jsp:forward page='../../page.jsp'>
			<jsp:param name='messages' value='<%= messages %>'/>
			<jsp:param name='view' value='<%= view.substring( 0, view.indexOf("submit") ) %>'/>
		</jsp:forward>
<% 	}  %>