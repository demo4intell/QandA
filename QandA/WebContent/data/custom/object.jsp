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
			( view.equals("create") || view.equals("edit") ? "form" : "read" );
		
	}
	
	public String getBaseFile( String prefix, String view ) {
		String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
		baseFile = "../views/" + baseFile + getFormType( view ) + ".jsp";
		return baseFile;
	}
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String prefix = getPrefix( oid );
%>
<jsp:include page='<%= getBaseFile( prefix, view ) %>'>
	<jsp:param name='prefix' value='<%= prefix %>'/>
</jsp:include>