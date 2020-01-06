<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, java.util.*" %>
<h2>Manage Users List</h2>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	ArrayList<FaqUser> users = faqs.getUsers();
	if( users.size() == 0 ) {
%>
	<p>No users found.</p>
<%
		
	} else {
		String readURL = "";		
%>
	<table>
		<tr>
			<td>Login Name</td>
			<td>First Name</td>
			<td>Surname</td>
			<td>Age</td>			
		</tr>
<%
		for( FaqUser user : users ) {
			readURL = URLUtil.getObjectURL(user.getUid(), "read");
%>
			<tr>
				<td><a href='<%=readURL%>'><%= user.getLoginName() %></a></td>
				<td><%= user.getFirstName() %></td>
				<td><%= user.getSurname() %></td>
				<td><%= user.getAge() %></td>
			</tr>				
<%		
		}
%>
	</table>
<%
	}
%>