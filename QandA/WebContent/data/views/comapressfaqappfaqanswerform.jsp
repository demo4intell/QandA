<%@ page language="java" contentType="text/html; charset=ISO-885+9-1"
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
	
	public FaqQuestion getQuestion( String quesuid, FaqCategory cat ) {
		return cat.getQuestionObject(quesuid);
	}
	
	public FaqAnswer getAnswer( String view, String oid, FaqQuestion ques ) {
		if( isEdit( view, oid ) )
			return ques.getAnswerObject(oid);
		else
			return null;
	}
	
	public FaqAnswer getTempAns( FaqAnswer ans, FaqAnswer calcAns ) {
		return ans == null ? calcAns : ans;
	}
	
	public String getSubmitURL( String view, String oid, String action, String catuid, 
			FaqQuestion ques, FaqAnswer ans ) {
		String quesuid = ques.getUid();
		if( action == null || !action.equals("addAnswer") )
			return ans == null ? URLUtil.getObjectURL(oid, view+"submit") + 
					"&catuid=" + catuid + "&quesuid=" + quesuid : ans.getObjectURL( oid, 
							view+"submit");
		else
			return ans == null ? URLUtil.getActionURL( quesuid, "performsubmit", 
					action ) + "&catuid=" + catuid : ques.getActionURL( quesuid, 
							"performsubmit", action );
	}
	
	public String getCancelURL( FaqQuestion ques, FaqAnswer ans ) {
		return ans == null ? ques.getObjectURL(ques.getUid(), "read") : 
			ans.getObjectURL(ans.getUid(), "read");
	}
	
	public String getPageTitle( FaqAnswer ans ) {
		return ans == null ? "New Answer" : "Edit Answer Details";
	}
	
	public String getValue( FaqAnswer ans, String paramName ) {
		try {
			Field f = FaqAnswer.class.getDeclaredField( paramName );
			f.setAccessible(true);
			if( ans != null ) {
				String value = String.valueOf( f.get(ans) );
				return value == null || value.equals("null") || value.equals("0") ? "" : value;
			}
		} catch( Exception e ) {
			System.out.println( ">>>exception"+e.getMessage() );
		}
		return "";
	}

	
%>
<%
	String oid = getParameter( request.getParameter("oid") );
	String view = getParameter( request.getParameter("view") );
	String catuid = getParameter( request.getParameter("catuid") );
	String quesuid = getParameter( request.getParameter("quesuid") );
	String action = getParameter( request.getParameter("action") );
	String messages = getParameter( request.getParameter("messages") );
	
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqAnswer requestA = (FaqAnswer) request.getAttribute("requestanswer");
	FaqCategory cat = getCategory(catuid);
	FaqQuestion ques = getQuestion(quesuid, cat);
	FaqAnswer ans = getAnswer( view, oid, ques );
	System.out.println( "ans "+ans );
	FaqAnswer tempAns = getTempAns( requestA, ans );
	System.out.println( "ans "+tempAns );
%>

<h2><%= getPageTitle( ans ) %></h2>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%= getSubmitURL( view, oid, action, catuid, ques, ans ) %>' method='POST'>
	<table>
		<tr>
			<td align='left'>Answer Text:</td>
			<td align='right'>
				<input type="text" name="text" length="30" 
					value='<%= getValue( tempAns, "text") %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<p><a href='<%= getCancelURL( ques, ans ) %>'>Cancel</a></p>