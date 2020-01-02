<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import='com.apress.faq.app.*, com.apress.faq.util.*'%>
<%! FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqUser current = null;
	
	public boolean canAddCategory( ) {
		return current != null;
	}
	
%>
<h2>Manage FAQ Categories</h2>
<% 	String prefix = GUIDUtil.getPrefix("com.apress.faq.app.FaqCategory");
	String addCategoryURL = URLUtil.getObjectURL(prefix, "create");
	current = (FaqUser) session.getAttribute("u");
	for( FaqCategory category : faqs.getCategories() ) { %>
<p class="item">
	<a href='<%= URLUtil.getObjectURL( category.getUid(), "read" ) %>'>
		<%=category.getName() %>
	</a><% if( current != null && current.hasSelectedCategory( category.getUid() ) ) { %>&check;<%}%>
</p>
<% } if( canAddCategory( ) ) { %><a href='<%= addCategoryURL %>'>Add Category</a><%}%>