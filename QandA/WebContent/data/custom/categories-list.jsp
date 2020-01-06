<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import='com.apress.faq.app.*, com.apress.faq.util.*'%>
<%! 
	public String getPrefix( Class classValue ) {
		return GUIDUtil.getPrefix(classValue.getName());
	}

	public String getURL( String uid, String view ) {
		return URLUtil.getObjectURL(uid, view);
	}

	public String getAddCategoryURL() {
		return getURL( getPrefix( FaqCategory.class ), "create" );
	}
	
	public boolean isUserLoggedIn( FaqUser u ) {
		return u != null;
	}

	public boolean hasSelectedCategory( FaqUser u, String catUid ) {
		return isUserLoggedIn( u ) && u.hasSelectedCategory(catUid);
	}
%>
<h2>Manage FAQ Categories</h2>
<% 	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqUser current = (FaqUser) session.getAttribute("u");
	
	for( FaqCategory category : faqs.getCategories() ) { 
%>
	<p class="item">
		<a href='<%= getURL( category.getUid(), "read" ) %>'>
			<%=category.getName() %>
		</a>
		<%= hasSelectedCategory( current, category.getUid() ) ? "&check;" : "" %>
</p>
<% } 
   if( isUserLoggedIn(current) ) { %>
		<a href='<%= getAddCategoryURL() %>'>Add Category</a>
<% }%>