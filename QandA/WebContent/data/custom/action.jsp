<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>
<%!
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public String getPrefix( String oid ) {
		return isOidPrefix(oid) ? oid : oid.substring( 0, oid.indexOf("-") );
	}
	
	public String getFormType( String view ) {
		return view.endsWith("submit") ? "submit" : 
			( view.equals("perform") ? "form" : "" );
		
	}
	
	public String getBaseFile( String prefix, String view, String action, String isForm ) {
		String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
		baseFile = "../views/" + baseFile + action.toLowerCase();
		if( isForm.equals("true") )
			baseFile += getFormType( view );
		baseFile += ".jsp";
		return baseFile;
	}
	
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String action = getParameter( request.getParameter("action") );
	String isForm = getParameter( request.getParameter("isForm") );
	if( isForm.length() == 0 )
		isForm="true";
	String prefix = getPrefix( oid );
%>
<jsp:include page='<%= getBaseFile( prefix, view, action, isForm ) %>'>
	<jsp:param name='prefix' value='<%= prefix %>'/>
</jsp:include>