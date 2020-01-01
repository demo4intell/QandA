package com.apress.faq.app;

import java.util.ArrayList;

import com.apress.faq.util.AppUtilManager;

public class QuestionnaireUtil {
	
	private static QuestionnaireUtil singleton;
	private ArrayList<TestQuestion> questions = new ArrayList<TestQuestion>();
	
	private QuestionnaireUtil() {
	}
	
	public static QuestionnaireUtil getCategoriesSingleton() {
		if( singleton == null ) {
			singleton = new QuestionnaireUtil();
			singleton.initApp();
		}
		return (QuestionnaireUtil) singleton;
	}
	
	public void initApp() {
		//read json file and initialize questions
	}

}
