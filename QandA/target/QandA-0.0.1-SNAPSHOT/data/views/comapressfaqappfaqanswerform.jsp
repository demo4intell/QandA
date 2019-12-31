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
	String catuid = request.getParameter("catuid");
	String quesuid = request.getParameter("quesuid");
	String action = request.getParameter("action");
	FaqAnswer sessionA = (FaqAnswer) session.getAttribute("sessionanswer");
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = cat.getQuestionObject(quesuid);
	FaqAnswer ans = null;
	
	if( view.equals("edit") && !isOidPrefix(oid) )
		ans = ques.getAnswerObject(oid);

	String submitURL = "";
	if( action == null || !action.equals("addAnswer") )
		submitURL = ans == null ? URLUtil.getObjectURL(oid, view+"submit")+"&catuid="+catuid+"&quesuid="+quesuid : ans.getObjectURL(oid, view+"submit");
	else
		submitURL = ans == null ? URLUtil.getActionURL(quesuid, "performsubmit", action)+"&catuid="+catuid : ques.getActionURL(quesuid, "performsubmit", action);
	
	
	String messages = request.getParameter("messages");
	FaqAnswer tempAns = sessionA;
	if( tempAns == null )
		tempAns = ans;	
%>

<h1><%= ans == null ? "New Answer" : "Edit Answer Details" %></h1>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=submitURL%>' method='POST'>
	<table>
		<tr>
			<td align='left'>Answer Text:</td>
			<td align='right'>
				<input type="text" name="text" length="30" 
					value='<%= tempAns != null && tempAns.getText() != null ? tempAns.getText() : "" %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<% String cancelURL = ans == null ? ques.getObjectURL(ques.getUid(), "read") : ans.getObjectURL(ans.getUid(), "read"); %>
<p><a href='<%= cancelURL %>'>Cancel</a></p>