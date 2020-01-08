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
		return FaqAppUtilManager.getPrefix( FaqLoginInfo.class );		
	}


	public String getBaseFile( ) {
		String baseFile = FaqAppUtilManager.getClass(getPrefix()).replaceAll("\\.", "").toLowerCase();
		return "../views/" + baseFile + "submit.jsp";
	}

%>
<%
	String oid = getParameter( request.getParameter("oid") );
	FaqUser user = FaqAppUtilManager.getCategoriesSingleton().getUserObject(oid);
%>

<jsp:include page='<%= getBaseFile() %>'>
	<jsp:param name='viewtype' value='object'/>
	<jsp:param name='oid' value="<%= getPrefix() %>"/>
	<jsp:param name='loginId' value='<%= user.getLoginName() %>'/>
	<jsp:param name='useruid' value='<%= user.getUid() %>'/>					
	<jsp:param name='type' value='changePassword'/>
	<jsp:param name='view' value="createsubmit"/>
</jsp:include>