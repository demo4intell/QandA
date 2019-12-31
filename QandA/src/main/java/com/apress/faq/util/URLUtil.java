package com.apress.faq.util;

public class URLUtil {

	public static String getPageURL( String file ) {
		return "page.jsp?viewtype=file&file="+file;
	}
	
	public static String getPageURL() {
		return "page.jsp";
	}
	
	public static String getObjectURL( String oid, String view ) {
		return "page.jsp?viewtype=object&oid="+oid+"&view="+view;
	}
	
	public static String getActionURL( String oid, String view, String action ) {
		return "page.jsp?viewtype=action&oid="+oid+"&view="+view+"&action="+action;
	}
}
