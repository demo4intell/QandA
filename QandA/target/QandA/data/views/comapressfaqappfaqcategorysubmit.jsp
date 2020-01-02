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
	
	FaqCategory sessionC = (FaqCategory) session.getAttribute("sessioncategory");
	FaqCategory cat = null;
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	if( !isOidPrefix(oid) ) {
		cat = faqs.getCategoryObject(oid);		
	}
%>
	<jsp:useBean id='requestCat' scope='request' class='com.apress.faq.app.FaqCategory'>
		<jsp:setProperty name='requestCat' property='*'/>
	</jsp:useBean>
<%
	session.setAttribute( "sessioncategory", requestCat );
	messages = "";
	setErrorMessages( requestCat.validate( cat ) );
	if( messages.length() == 0 ) {
		if( cat != null ) {
			cat.copy( requestCat, cat );
		}
		else {
			requestCat.postCreate(current);
		}
		session.setAttribute("sessioncategory", null);
%>
	<jsp:forward page='../../page.jsp'>
		<jsp:param value='read' name='view'/>
		<jsp:param value='<%= cat != null ? cat.getUid() : requestCat.getUid() %>' name='oid'/>
		<jsp:param value='<%= cat == null ? "New category added!" : "" %>' name='message'/>
	</jsp:forward>	
<%
	} else {
%>
		<jsp:forward page='../../page.jsp'>
			<jsp:param name='messages' value='<%= messages %>'/>
			<jsp:param name='view' value='<%= view.substring(0, view.indexOf("submit")) %>'/>	
		</jsp:forward>
<% 	}  %>