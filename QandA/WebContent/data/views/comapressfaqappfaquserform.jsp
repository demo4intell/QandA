<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, 
    com.apress.faq.common.*, java.lang.reflect.Field" %>
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
	
	public String getValue( User user, String paramName ) {
		try {
			Field f = User.class.getDeclaredField( paramName );
			System.out.println(">>>field "+f);
			f.setAccessible(true);
			if( user != null ) {
				String value = String.valueOf( f.get(user) );
				return value == null || value.equals("null") || value.equals("0") ? "" : value;
			}
		} catch( Exception e ) {
			System.out.println( ">>>exception"+e.getMessage() );
		}
		return "";
	}
	
	public String getPageTitle( String view, String oid ) {
		return !isEdit( view, oid ) ? "Register User" : "Edit User Profile";
	}
	
	public boolean hasUserSelectedCategory( FaqUser u, String catuid ) {
		return u != null ? u.hasSelectedCategory( catuid ) : false;
	}
	
	public FaqUser getUser( String view, String oid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		if( isEdit( view, oid ) )
			return faqs.getUserObject(oid);
		else
			return null;			
	}
	
	public FaqUser getTempUser( FaqUser sessionU, String view, String oid ) {
		return sessionU == null ? getUser( view, oid ) : sessionU;
	}
	
	public String getSubmitURL( String view, String oid ) {
		FaqUser user = getUser( view, oid );
		return isEdit( view, oid ) ? user.getObjectURL(oid, view+"submit") : 
					URLUtil.getObjectURL(oid, view+"submit");
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
	String messages = getParameter( request.getParameter("messages") );
	
	FaqUser requestU = (FaqUser) request.getAttribute("requestuser");
	FaqUser user = getUser(view,oid);
	FaqUser tempUser = getTempUser( requestU, view, oid );	
	
%>
<h2><%= getPageTitle( view, oid ) %></h2>

<% if( !messages.equals("") ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } }%>

<form action='<%=getSubmitURL( view, oid )%>' method='POST'>
	
	<label>First Name:</label>
	<input type="text" name="firstName" length="30" 
		value='<%= getValue( tempUser, "firstName" ) %>'/>
	
	<label>Surname:</label>
	<input type="text" name="surname" length="30" 
		value='<%= getValue( tempUser, "surname" ) %>'/>				

	<label>Login Name:</label>
	<% if( user == null ) { %>
		<input type="text" name="loginName" length="30" 
			value='<%= getValue( tempUser, "loginName" ) %>'/>
	<% } else { %>
		<%= user.getLoginName() %>
	<% } %>
	
	<label>Age:</label>
	<input type="text" name="age" length="5" 
		value='<%= getValue( tempUser, "age" ) %>'/>
		
	<label>Thumbnail URL:</label>
	<input type="text" name="thumbnailURL" length="255" 
		value='<%= getValue( tempUser, "thumbnailURL" ) %>'/>
	
	<% if( user == null ) { %>
		
		<label>Password:</label>
		<input type='password' name='password' length='32'/>
		
	<% } %>
	<% for( FaqCategory cat : faqs.getCategories() ) { %>
		<input type='checkbox' name='topics' value='<%= cat.getUid() %>' 
			<%= hasUserSelectedCategory( tempUser, cat.getUid() ) ? "checked" : "" %> />
		<span><%= cat.getName() %></span>
	<% } %>
	
	<input type='submit' value='Submit'/>
	<input type='reset' value='Reset'/>
	<a href='<%= getCancelURL(user) %>'>Cancel</a>

</form>