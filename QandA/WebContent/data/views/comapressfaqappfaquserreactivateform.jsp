<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>

<%!

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public String getPrefix() {
		return FaqAppUtilManager.getPrefix( FaqLoginInfo.class );		
	}

	public String getBaseFile( ) {
		String baseFile = FaqAppUtilManager.getClass(getPrefix()).replaceAll("\\.", "").toLowerCase();
		return "../views/" + baseFile + "form.jsp";
	}
	
	public String getSubmitURL( FaqUser user, String view, String oid ) {
		return user.getActionURL(oid, view+"submit", "deactivate");
	}
	
	public String getCancelURL( FaqUser u ) {
		return u == null ? URLUtil.getPageURL("categories-list") : 
			u.getObjectURL( u.getUid(), "read" );
		
	}



%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	FaqUser user = faqs.getUserObject(oid);
%>

<h2>Confirm Reactivate User Profile</h2>

<form action='<%=getSubmitURL( user, view, oid )%>' method='POST'>
	
	<label>Are you sure you want to reactivate this account?</label>
	<input type='radio' name='reactivateUser' value='yes'/><span>Yes</span>
	<input type='radio' name='reactivateUser' value='no'/><span>No</span>
	
	<input type='submit' value='Submit'/>
	<a href='<%= getCancelURL(user) %>'>Cancel</a>
</form>