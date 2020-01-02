<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>
    
<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	
	
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}
	
%>
<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	FaqCategory sessionC = (FaqCategory) session.getAttribute("sessioncategory");
	FaqCategory cat = null;
	String submitURL = URLUtil.getObjectURL(oid, view+"submit");
	if( view.equals("edit") && !isOidPrefix(oid) ) {
		cat = faqs.getCategoryObject(oid);
		submitURL = cat.getObjectURL(oid, view+"submit");
	}
	
	String messages = request.getParameter("messages");
	FaqCategory tempCat = sessionC;
	if( tempCat == null )
		tempCat = cat;	
%>

<h2><%= cat == null ? "New Category" : "Edit Category Details" %></h2>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=submitURL%>' method='POST'>
	<table>
		<tr>
			<td align='left'>Category Name:</td>
			<td align='right'>
				<input type="text" name="name" length="30" value='<%= tempCat != null && tempCat.getName() != null ? tempCat.getName() : "" %>'/>
			</td>
		</tr>
		<tr>
			<td align='left'>Image URL:</td>
			<td align='right'>
				<input type="text" name="imageURL" length="30" value='<%= tempCat != null && tempCat.getImageURL() != null ? tempCat.getImageURL() : "" %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<% String cancelURL = cat == null ? URLUtil.getPageURL("categories-list.jsp") : cat.getObjectURL(cat.getUid(), "read"); %>
<p><a href='<%= cancelURL %>'>Cancel</a></p>