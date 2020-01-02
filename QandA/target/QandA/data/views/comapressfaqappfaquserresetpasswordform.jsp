<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>

<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
%>
<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	FaqUser user = faqs.getUserObject(oid);
	String prefix = FaqAppUtilManager.getPrefix( FaqLoginInfo.class );
	String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
	baseFile = baseFile + "form.jsp";
%>

<jsp:include page='<%= baseFile %>'>
	<jsp:param name='viewtype' value='object'/>
	<jsp:param name='oid' value="<%= prefix %>"/>
	<jsp:param name='type' value='changePassword'/>
	<jsp:param name='loginId' value='<%= user.getLoginName() %>'/>
	<jsp:param name='useruid' value='<%= user.getUid() %>'/>
	<jsp:param name='view' value="create"/>
</jsp:include>