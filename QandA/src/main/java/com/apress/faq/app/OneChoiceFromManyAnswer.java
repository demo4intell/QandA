package com.apress.faq.app;

public class OneChoiceFromManyAnswer implements TestAnswer {

	private AnswerChoice choice;
	private OneChoiceFromManyQuestion question;
	
	public void setChoice( AnswerChoice choice ) {
		this.choice = choice;
	}
	
	public AnswerChoice getChoice() {
		return this.choice;
	}
	
	@Override
	public void setQuestion(TestQuestion question) {
		// TODO Auto-generated method stub
		this.question = (OneChoiceFromManyQuestion) question;		
	}

	@Override
	public TestQuestion getQuestion() {
		// TODO Auto-generated method stub
		return this.question;
	}

}
