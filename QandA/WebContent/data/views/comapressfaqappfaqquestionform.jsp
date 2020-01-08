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
	
	public FaqCategory getCategory( String catuid ) {
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		return faqs.getCategoryObject(catuid);
	}
	
	public FaqQuestion getQuestion( String view, String oid, FaqCategory cat ) {
		if( isEdit( view, oid ) )
			return cat.getQuestionObject(oid);
		else
			return null;
	}
	
	public FaqQuestion getTempQues( FaqQuestion ques, FaqQuestion calcQues ) {
		return ques == null ? calcQues : ques;
	}
	
	public String getSubmitURL( String view, String oid, String action, FaqCategory cat, FaqQuestion ques  ) {
		String catuid = cat.getUid();
		if( action == null || !action.equals("addQuestion") )
			return ques == null ? 
					URLUtil.getObjectURL(oid, view+"submit")+"&catuid="+catuid 
					: ques.getObjectURL(oid, view+"submit");
		else
			return ques == null ? URLUtil.getActionURL(catuid, "performsubmit", action)
					: cat.getActionURL(cat.getUid(), "performsubmit", action);
	}
	
	public String getPageTitle( FaqQuestion ques ) {
		return ques == null ? "New Question" : "Edit Question Details";
	}
	
	public String getValue( FaqQuestion ques, String paramName ) {
		try {
			Field f = FaqQuestion.class.getDeclaredField( paramName );
			f.setAccessible(true);
			if( ques != null ) {
				String value = String.valueOf( f.get(ques) );
				return value == null || value.equals("null") || value.equals("0") ? "" : value;
			}
		} catch( Exception e ) {
			System.out.println( ">>>exception"+e.getMessage() );
		}
		return "";
	}
	
	public String getCancelURL( FaqQuestion ques, FaqCategory cat ) {
		return ques == null ? cat.getObjectURL(cat.getUid(), "read") : 
			ques.getObjectURL(ques.getUid(), "read");
	}
	
	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String catuid = getParameter( request.getParameter("catuid") );
	String action = getParameter( request.getParameter("action") );
	String messages = getParameter( request.getParameter("messages") );
	
	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqQuestion requestQ = (FaqQuestion) request.getAttribute("requestquestion");
	FaqCategory cat = getCategory( catuid );
	FaqQuestion ques = getQuestion( view, oid, cat );
	FaqQuestion tempQues = getTempQues( requestQ, ques );
%>

<h2><%= getPageTitle( ques ) %></h2>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=getSubmitURL( view, oid, action, cat, ques )%>' method='POST'>
	<table>
		<tr>
			<td align='left'>Question Text:</td>
			<td align='right'>
				<input type="text" name="text" length="30" 
					value='<%= getValue( tempQues, "text" ) %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<p><a href='<%= getCancelURL( ques, cat ) %>'>Cancel</a></p>