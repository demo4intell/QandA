<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*"%>

<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	String prefix = "";
	if( view != null ) {
		
		prefix = oid.indexOf("-") == -1 ? oid : oid.substring( 0, oid.indexOf("-") );
		System.out.println(">>prefix "+prefix);
		String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
		String file = "";
		switch( view ) {
			case "create":
			case "edit":
			case "read":
				file = view.equals("create") || view.equals("edit") ? "form" : "read";
				baseFile = "../views/" + baseFile + file +".jsp";
%>
				<jsp:include page='<%= baseFile %>'>
					<jsp:param name='prefix' value='<%= prefix %>'/>
				</jsp:include>
<%
				break;
			case "createsubmit":
			case "editsubmit":
				baseFile = "../views/" + baseFile + "submit.jsp";
%>
				<jsp:include page='<%= baseFile %>'>
					<jsp:param name='prefix' value='<%= prefix %>'/>
				</jsp:include>
<%
				break;
		}
	}
%>