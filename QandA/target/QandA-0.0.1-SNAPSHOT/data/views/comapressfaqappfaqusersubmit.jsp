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
	String view = request.getParameter("view");
	
	FaqUser sessionU = (FaqUser) session.getAttribute("sessionuser");
	FaqUser user = null;
	
	if( !isOidPrefix(oid) ) {
		user = faqs.getUserObject(oid);		
	}
%>
	<jsp:useBean id='requestUser' scope='request' class='com.apress.faq.app.FaqUser'>
		<jsp:setProperty name='requestUser' property='*'/>
	</jsp:useBean>
<%
	requestUser.updateCategoryTopics();
	session.setAttribute( "sessionuser", requestUser );
	messages = "";
	setErrorMessages( requestUser.validate( user ) );
	if( messages.length() == 0 ) {
		if( user != null ) {
			user.copy( requestUser, user );
		}
		else {
			requestUser.postCreate(requestUser);
		}
		session.setAttribute("sessionuser", null);
%>
	<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='<%= user != null ? user.getUid() : requestUser.getUid() %>' name='oid'/>
		<jsp:param value='<%= user == null ? "Please login with your new details" : "" %>' name='message'/>
	</jsp:forward>	
<%
	} else {
%>
		<jsp:forward page='../../page.jsp'>
			<jsp:param name='messages' value='<%= messages %>'/>
			<jsp:param name='view' value='<%= view.substring(0, view.indexOf("submit")) %>'/>	
		</jsp:forward>
<% 	}  %>