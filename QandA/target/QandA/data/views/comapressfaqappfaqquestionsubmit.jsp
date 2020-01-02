<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.*" %>
<%! FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String messages = "";

	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}
	
	public void setErrorMessages( ArrayList<String> errorMessages ) {
		messages = "";
		for( String m : errorMessages ) {
			messages += m +"@";
		}		
	}
	
%>
<%
	String oid = request.getParameter("oid");
	String catuid = request.getParameter("catuid");
	String view = request.getParameter("view");
	
	FaqQuestion sessionQ = (FaqQuestion) session.getAttribute("sessionquestion");
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = null;
	
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	if( !isOidPrefix(oid) ) {
		ques = cat.getQuestionObject(oid);		
	}
%>
	<jsp:useBean id='requestQues' scope='request' class='com.apress.faq.app.FaqQuestion'>
		<jsp:setProperty name='requestQues' property='*'/>
	</jsp:useBean>
<%
	session.setAttribute( "sessionquestion", requestQues );
	messages = "";
	setErrorMessages( requestQues.validate( ques ) );
	if( messages.length() == 0 ) {
		if( ques != null ) {
			ques.copy( requestQues, ques );
		}
		else {
			requestQues.setCategory(cat);			
			requestQues.postCreate(current);
		}
		session.setAttribute("sessionquestion", null);
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
			<jsp:param name='view' value='<%= view.substring(0, view.indexOf("submit")) %>'/>	
		</jsp:forward>
<% 	}  %>