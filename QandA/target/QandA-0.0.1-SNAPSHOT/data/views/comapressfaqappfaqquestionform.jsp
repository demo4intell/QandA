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
	String action = request.getParameter("action");
	FaqQuestion sessionQ = (FaqQuestion) session.getAttribute("sessionquestion");
	FaqCategory cat = faqs.getCategoryObject(catuid);
	FaqQuestion ques = null;
	
	if( view.equals("edit") && !isOidPrefix(oid) )
		ques = cat.getQuestionObject(oid);

	String submitURL = "";
	if( action == null || !action.equals("addQuestion") )
		submitURL = ques == null ? URLUtil.getObjectURL(oid, view+"submit")+"&catuid="+catuid : ques.getObjectURL(oid, view+"submit");
	else
		submitURL = ques == null ? URLUtil.getActionURL(catuid, "performsubmit", action) : cat.getActionURL(catuid, "performsubmit", action);
	
	
	String messages = request.getParameter("messages");
	FaqQuestion tempQues = sessionQ;
	if( tempQues == null )
		tempQues = ques;	
%>

<h1><%= ques == null ? "New Question" : "Edit Question Details" %></h1>
<% if( messages != null ) { 
	for( String m : messages.split("@") ) {
%>
	<h2><%= m %></h2>
<% } } %>
<form action='<%=submitURL%>' method='POST'>
	<table>
		<tr>
			<td align='left'>Question Text:</td>
			<td align='right'>
				<input type="text" name="text" length="30" 
					value='<%= tempQues != null && tempQues.getText() != null ? tempQues.getText() : "" %>'/>
			</td>
		</tr>

	</table>
	<p>
		<input type='submit' value='Submit'/>
		<input type='reset' value='Reset'/>
	</p>
</form>
<% String cancelURL = ques == null ? cat.getObjectURL(cat.getUid(), "read") : ques.getObjectURL(ques.getUid(), "read"); %>
<p><a href='<%= cancelURL %>'>Cancel</a></p>