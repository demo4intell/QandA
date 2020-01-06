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
	
	public FaqUser getUser( String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		if( !isOidPrefix(oid) )
			return faqs.getUserObject(oid);
		return null;
	}
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	
	//FaqUser sessionU = (FaqUser) request.getAttribute("sessionuser");
	FaqUser user = getUser( oid );
	
%>
	<jsp:useBean id='requestUser' scope='request' class='com.apress.faq.app.FaqUser'>
		<jsp:setProperty name='requestUser' property='*'/>
	</jsp:useBean>
<%
	requestUser.updateCategoryTopics();
	//session.setAttribute( "sessionuser", requestUser );
	request.setAttribute("sessionuser", requestUser);
	String messages = setErrorMessages( requestUser.validate( user ) );
	if( messages.length() == 0 ) {
		if( user != null ) {
			user.copy( requestUser, user );
		}
		else {
			requestUser.postCreate(requestUser);
		}
		//session.setAttribute("sessionuser", null);
		request.setAttribute("sessionuser", null);
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