<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.*" %>
<%! 
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}
	
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
	
	public FaqCategory getCategory( String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		return faqs.getCategoryObject( oid );
	}
	
	public FaqQuestion getQuestion( String oid, FaqCategory cat ) {
		return cat.getQuestionObject(oid);
	}

	public FaqAnswer getAnswer( String oid, FaqQuestion ques ) {
		if( !isOidPrefix(oid) ) {
			return ques.getAnswerObject(oid);		
		}
		return null;
	}
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String catuid = getParameter( request.getParameter("catuid") );
	String quesuid = getParameter( request.getParameter("quesuid") );
	String view = getParameter( request.getParameter("view") );
	
	FaqAnswer requestA = (FaqAnswer) request.getAttribute("requestanswer");
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	FaqCategory cat = getCategory( catuid );
	FaqQuestion ques = getQuestion( quesuid, cat );
	FaqAnswer ans = getAnswer( oid, ques );
	
%>
	<jsp:useBean id='requestAns' scope='request' class='com.apress.faq.app.FaqAnswer'>
		<jsp:setProperty name='requestAns' property='*'/>
	</jsp:useBean>
<%
	request.setAttribute( "requestanswer", requestAns );
	String messages = setErrorMessages( requestAns.validate( ans ) );
	
	if( messages.length() == 0 ) {
		if( ans != null ) {
			ans.copy( requestAns, ans );
		}
		else {	
			requestAns.setQuestion(ques);
			requestAns.postCreate(current);
		}
		request.setAttribute("requestanswer", null);
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