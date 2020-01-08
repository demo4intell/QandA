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
		if( !isOidPrefix(oid) )
			return faqs.getCategoryObject( oid );
		return null;
	}
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	
	FaqCategory requestC = (FaqCategory) request.getAttribute("requestcategory");
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	FaqCategory cat = getCategory( oid );
	
%>
	<jsp:useBean id='requestCat' scope='request' class='com.apress.faq.app.FaqCategory'>
		<jsp:setProperty name='requestCat' property='*'/>
	</jsp:useBean>
<%
	request.setAttribute( "requestcategory", requestCat );
	String messages = setErrorMessages( requestCat.validate( cat ) );
	if( messages.length() == 0 ) {
		if( cat != null ) {
			cat.copy( requestCat, cat );
		}
		else {
			requestCat.postCreate(current);
		}
		request.setAttribute("requestcategory", null);
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