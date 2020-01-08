<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>

<%!

	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public FaqCategory getCategory( String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		return faqs.getCategoryObject(oid);
	}
	
	public String getSubmitURL( FaqCategory cat, String view, String oid ) {
		return cat.getActionURL(oid, view+"submit", "delete");
	}
	
	public String getCancelURL( FaqCategory cat ) {
		return cat.getObjectURL( cat.getUid(), "read" );
		
	}
%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	
	FaqCategory cat = getCategory( oid );
%>

<h2>Confirm Delete Category</h2>

<form action='<%=getSubmitURL( cat, view, oid )%>' method='POST'>
	
	<label>Are you sure you want to delete this category?</label>
	<input type='radio' name='deleteCat' value='yes'/><span>Yes</span>
	<input type='radio' name='deleteCat' value='no'/><span>No</span>
	
	<input type='submit' value='Submit'/>
	<a href='<%= getCancelURL(cat) %>'>Cancel</a>
</form>