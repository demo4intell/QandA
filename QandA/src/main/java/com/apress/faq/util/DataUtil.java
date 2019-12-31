package com.apress.faq.util;

import java.util.regex.Pattern;

public class DataUtil {
	
	public static boolean isNumeric( String s ) {
		Pattern pattern = Pattern.compile("-?\\d+?");
		return pattern.matcher(s).matches();		
	}
	
	public static boolean isEmptyString( String s ) {
		return ( s == null || s.length() == 0 );
	}

}
