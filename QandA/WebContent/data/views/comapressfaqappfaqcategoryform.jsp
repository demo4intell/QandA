<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.lang.reflect.*" %>
    
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
	
	public boolean isEdit( String view, String oid ) {
		return view.equals("edit") && !isOidPrefix(oid);
	}

	public FaqCategory getCategory( String view, String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		if( isEdit( view, oid ) )
			return faqs.getCategoryObject(oid);
		else
			return null;
	}
	
	public String getSubmitURL( String view, String oid ) {
		FaqCategory cat = getCategory( view, oid );
		return isEdit( view, oid ) ? cat.getObjectURL(oid, view+"submit") : 
					URLUtil.getObjectURL(oid, view+"submit");
	}
	
	public FaqCategory getTempCat( FaqCategory cat, FaqCategory calcCat ) {
		return cat == null ? calcCat : cat;
	}
	
	public String getValue( FaqCategory cat, String paramName ) {
		try {
			Field f = FaqCategory.class.getDeclaredField( paramName );
			f.setAccessible(true);
			if( cat != null ) {
				String value = String.valueOf( f.get(cat) );
				return value == null || value.equals("null") || value.equals("0") ? "" : value;
			}
		} catch( Exception e ) {
			System.out.println( ">>>exception"+e.getMessage() );
		}
		return "";
	}
	
	public String getPageTitle( String view, String oid ) {
		return !isEdit(view,oid) ? "New Category" : "Edit Category Details";
	}
	
	public String getCancelURL( FaqCategory cat ) {
		return cat == null ? URLUtil.getPageURL("categories-list") : 
			cat.getObjectURL( cat.getUid(), "read" );
		
	}	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String messages = getParameter( request.getParameter("messages") );
	
	FaqCategory requestC = (FaqCategory) request.getAttribute("requestcategory");
	FaqCategory cat = getCategory( view, oid );
	FaqCategory tempCat = getTempCat( requestC, cat );
%>

<h2><%= getPageTitle( view, oid ) %></h2>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=getSubmitURL( view, oid )%>' method='POST'>
	<table>
		<tr>
			<td align='left'>Category Name:</td>
			<td align='right'>
				<input type="text" name="name" length="30" 
					value='<%= getValue( tempCat, "name" ) %>'/>
			</td>
		</tr>
		<tr>
			<td align='left'>Image URL:</td>
			<td align='right'>
				<input type="text" name="imageURL" length="30" 
					value='<%= getValue( tempCat, "imageURL" ) %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<p><a href='<%= getCancelURL( cat ) %>'>Cancel</a></p>