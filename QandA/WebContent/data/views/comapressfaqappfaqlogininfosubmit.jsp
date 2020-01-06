<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
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

%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	
	String view = getParameter( request.getParameter("view") );
	String type = getParameter( request.getParameter("type") );
	type = type.equals("") ? "login" : type;
	
	String useruid = getParameter( request.getParameter("useruid") );
	if( view.equals("createsubmit") ) {
%>
	<jsp:useBean id='l' scope='request' class='com.apress.faq.app.FaqLoginInfo'>
		<jsp:setProperty name='l' property='*'/>
	</jsp:useBean>
	
	
<%
		l.postCreate(null);
		String messages = setErrorMessages( l.validate( null ) );
		if( messages.length() == 0 && l.getLoggedIn() != null ) {
			if( type.equals("login") ) {
				session.setAttribute("u", l.getLoggedIn() );
%>
				<jsp:forward page='../../page.jsp'>
					<jsp:param name='viewtype' value='file'/>
					<jsp:param name='messages' value='<%= messages %>'/>		
				</jsp:forward>
<% 			} else {
				l.getLoggedIn().setPassword( l.getPassword() );
%>
				<jsp:forward page='../../page.jsp'>
					<jsp:param name='viewtype' value='object'/>
					<jsp:param name='view' value='read'/>
					<jsp:param name='oid' value='<%= useruid %>'/>
					<jsp:param name='message' value='Password has been successfully modified.'/>		
				</jsp:forward>
<%
			}
		} else {
			if( type.equals("login") ) {
%>
				<jsp:forward page='../../page.jsp'>
					<jsp:param name='viewtype' value='object'/>
					<jsp:param name='oid' value='cafafli'/>
					<jsp:param name='view' value='create'/>
					<jsp:param name='messages' value='<%= messages %>'/>		
				</jsp:forward>
<%
			} else {
%>
				<jsp:forward page='../../page.jsp'>
					<jsp:param name='viewtype' value='action'/>
					<jsp:param name='view' value='perform'/>
					<jsp:param name='oid' value='<%= useruid %>'/>
					<jsp:param name='messages' value='<%= messages %>'/>		
				</jsp:forward>
<%
			}
		}
	}
%>