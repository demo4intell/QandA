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
	
	public void setQuestions( ArrayList<TestQuestion> questions ) {
		this.questions = questions;
	}
	
	public ArrayList<TestQuestion> getQuestions() {
		return this.questions;
	}
	
	public void addQuestion( TestQuestion question ) {
		this.questions.add( question );
	}
	
	public void removeQuestion( TestQuestion question ) {
		this.questions.remove( question );
	}

}
