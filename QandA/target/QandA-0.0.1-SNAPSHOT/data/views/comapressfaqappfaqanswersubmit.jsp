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
	String quesuid = request.getParameter("quesuid");
	String view = request.getParameter("view");
	
	FaqAnswer sessionA = (FaqAnswer) session.getAttribute("sessionanswer");
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = cat.getQuestionObject(quesuid);
	FaqAnswer ans = null;
	
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	if( !isOidPrefix(oid) ) {
		ans = ques.getAnswerObject(oid);		
	}
%>
	<jsp:useBean id='requestAns' scope='request' class='com.apress.faq.app.FaqAnswer'>
		<jsp:setProperty name='requestAns' property='*'/>
	</jsp:useBean>
<%
	session.setAttribute( "sessionanswer", requestAns );
	messages = "";
	setErrorMessages( requestAns.validate( ans ) );
	if( messages.length() == 0 ) {
		if( ans != null ) {
			ans.copy( requestAns, ans );
		}
		else {
			requestAns.setQuestion(ques);			
			requestAns.postCreate(current);
		}
		session.setAttribute("sessionanswer", null);
%>
	<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='<%= ans != null ? ans.getUid() : requestAns.getUid() %>' name='oid'/>
		<jsp:param value='<%= ans == null ? "New answer added!" : "" %>' name='message'/>
	</jsp:forward>	
<%
	} else {
%>
		<jsp:forward page='../../page.jsp'>
			<jsp:param name='messages' value='<%= messages %>'/>
			<jsp:param name='view' value='<%= view.substring(0, view.indexOf("submit")) %>'/>	
		</jsp:forward>
<% 	}  %>