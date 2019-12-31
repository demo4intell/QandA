<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*" %>

<%!
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
%>
<%
	String oid = request.getParameter("oid");
	String view = request.getParameter("view");
	FaqCategory cat = faqs.getCategoryObject(oid);
	String prefix = FaqAppUtilManager.getPrefix( FaqQuestion.class );
	String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
	baseFile = baseFile + "form.jsp";
%>

<jsp:include page='<%= baseFile %>'>
	<jsp:param name='viewtype' value='object'/>
	<jsp:param name='oid' value="<%= prefix %>"/>
	<jsp:param name='catuid' value='<%= cat.getUid() %>'/>
	<jsp:param name='view' value="create"/>
	<jsp:param name='action' value='addQuestion'/>
</jsp:include>