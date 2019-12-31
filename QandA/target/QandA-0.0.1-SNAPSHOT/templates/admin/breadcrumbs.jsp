<%@page import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*"%>
<%!
	public boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}

%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	if( viewType.equals("object") || viewType.equals("action") ) {
		String oid = request.getParameter("oid");
		String quesuid = request.getParameter("quesuid");
		String catuid = request.getParameter("catuid");
		String objectType = "";
		String homeURL = URLUtil.getPageURL( "categories-list.jsp" );
%>
<%
		if( catuid != null ) {
%>
		<p>
			<a href='<%= homeURL %>'>Home</a>&nbsp;
<%
			//question or answer
			FaqCategory cat = faqs.getCategoryObject(catuid);
			String viewCatURL = cat.getObjectURL(catuid, "read");
%>
			&gt;&nbsp;<a href='<%= viewCatURL %>'>Category</a>&nbsp;
<%
			if( quesuid != null ) {
				FaqQuestion ques = cat.getQuestionObject(quesuid);
				String viewQuesURL = ques.getObjectURL(quesuid, "read");
%>
				&gt;&nbsp;<a href='<%= viewQuesURL %>'>Question</a>&nbsp;
<%
			}
%>
		</p>
<%
		}
	}
%>