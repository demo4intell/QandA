<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
<%! FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String messages = "";
	public void setErrorMessages( ArrayList<String> errorMessages ) {
		for( String m : errorMessages ) {
			messages += m +"@";
		}		
	}
%>
<%
	String view = request.getParameter("view");
	String type = request.getParameter("type");
	String useruid = request.getParameter("useruid");
	if( type == null )
		type = "login";
	if( view.equals("createsubmit") ) {
%>
	<jsp:useBean id='l' scope='request' class='com.apress.faq.app.FaqLoginInfo'>
		<jsp:setProperty name='l' property='*'/>
	</jsp:useBean>
	
	
<%
		l.postCreate(null);
		messages = "";
		setErrorMessages( l.validate( null ) );
		System.out.println( messages );
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