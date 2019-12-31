<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
<%
	String prefix = FaqAppUtilManager.getPrefix( FaqQuestion.class );
	String baseFile = FaqAppUtilManager.getClass(prefix).replaceAll("\\.", "").toLowerCase();
	baseFile = baseFile + "submit.jsp";
	
	String oid = request.getParameter("oid");
	FaqCategory cat = FaqAppUtilManager.getCategoriesSingleton().getCategoryObject(oid);
%>

<jsp:include page='<%= baseFile %>'>
	<jsp:param name='viewtype' value='object'/>
	<jsp:param name='oid' value="<%= prefix %>"/>
	<jsp:param name='action' value='addQuestion'/>
	<jsp:param name='catuid' value='<%= cat.getUid() %>'/>					
	<jsp:param name='view' value="createsubmit"/>
</jsp:include>