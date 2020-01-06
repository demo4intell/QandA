<%@page import="com.apress.faq.app.*, com.apress.faq.util.*, com.apress.faq.common.*, 
java.util.*, javax.servlet.http.*"%>
<%
	FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
	
	if( viewType.equals("object") || viewType.equals("action") ) {
		String oid = getParameter( request.getParameter("oid") );
		String quesuid = getParameter( request.getParameter("quesuid") );
		String catuid = getParameter( request.getParameter("catuid") );
		String objectType = "";
		if( !getParameter( request.getParameter("catuid") ).equals("") ) {
			FaqCategory cat = faqs.getCategoryObject(catuid);
			String viewCatURL = cat.getObjectURL(catuid, "read");
%>
			<p>
				<a href='<%= getURL("homeURL") %>'>Home</a>&nbsp;&gt;&nbsp;
				<a href='<%= viewCatURL %>'>Category</a>&nbsp;
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