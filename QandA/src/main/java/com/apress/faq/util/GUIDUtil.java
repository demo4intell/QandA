package com.apress.faq.util;

import java.util.UUID;

public class GUIDUtil {
	
	public static String getUID( String className ) {
		return getPrefix( className ) + "-" + UUID.randomUUID().toString();
	}
	
	public static String getPrefix( String className ) {
		String prefix = "";
		String[] parts = className.split( "\\." );
		for( int i = 0; i < parts.length - 1; i++ ) {
			prefix += parts[i].charAt(0);
		}
		String lastPart = parts[ parts.length - 1 ];
		for( int i = 0; i < lastPart.length(); i++ ) {
			if( Character.isUpperCase( lastPart.charAt(i) ) ) {
				prefix += Character.toString( lastPart.charAt(i) ).toLowerCase();
			}
		}
		return prefix;
	}
	
	public static boolean isOidPrefix( String oid ) {
		return ( oid.indexOf("-") == -1 );
	}


}
