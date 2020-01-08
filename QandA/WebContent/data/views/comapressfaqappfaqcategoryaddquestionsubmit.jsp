<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, java.util.*" %>
<%!
	public String getParameter( String paramObject ) {
		if( paramObject == null )
			return "";
		else
			return paramObject;					
	}

	public String getPrefix() {
		return FaqAppUtilManager.getPrefix( FaqQuestion.class );
	}
	
	public String getBaseFile() {
		String baseFile = FaqAppUtilManager.getClass(getPrefix()).replaceAll("\\.", "").toLowerCase();
		baseFile = baseFile + "submit.jsp";
		return baseFile;
	}

%>

<%
	String oid = getParameter( request.getParameter("oid") );
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	FaqCategory cat = faqs.getCategoryObject(oid);
%>

<jsp:include page='<%= getBaseFile() %>'>
	<jsp:param name='viewtype' value='object'/>
	<jsp:param name='oid' value="<%= getPrefix() %>"/>
	<jsp:param name='action' value='addQuestion'/>
	<jsp:param name='catuid' value='<%= cat.getUid() %>'/>					
	<jsp:param name='view' value="createsubmit"/>
</jsp:include>