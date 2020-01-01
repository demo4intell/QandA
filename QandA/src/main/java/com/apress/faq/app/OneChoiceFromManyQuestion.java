package com.apress.faq.app;

import java.util.ArrayList;

public class OneChoiceFromManyQuestion implements TestQuestion {
	
	private String text;
	private int credits;
	private FaqCategory category;
	private OneChoiceFromManyQuestion createdFrom;
	private ArrayList<AnswerChoice> choices = new ArrayList<>();
	private OneChoiceFromManyAnswer answer;

	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return this.text;
	}

	@Override
	public void setText(String text) {
		// TODO Auto-generated method stub
		this.text = text;
	}

	@Override
	public int getCredits() {
		// TODO Auto-generated method stub
		return this.credits;
	}

	@Override
	public void setCredits(int credits) {
		// TODO Auto-generated method stub
		this.credits = credits;
	}

	@Override
	public void setAnswer(TestAnswer answer) {
		// TODO Auto-generated method stub
		this.answer = (OneChoiceFromManyAnswer) answer;
	}

	@Override
	public TestAnswer getAnswer() {
		// TODO Auto-generated method stub
		return this.answer;
	}

	@Override
	public void setCreatedFrom(TestQuestion question) {
		// TODO Auto-generated method stub
		this.createdFrom = (OneChoiceFromManyQuestion) question;
	}

	@Override
	public TestQuestion getCreatedFrom() {
		// TODO Auto-generated method stub
		return this.createdFrom;
	}
	
	public void setChoices( ArrayList<AnswerChoice> choices ) {
		this.choices = choices;
	}
	
	public ArrayList<AnswerChoice> getChoices() {
		return this.choices;
	}
	
	public void addChoice( AnswerChoice choice ) {
		this.choices.add( choice );
	}

	@Override
	public void setCategory(FaqCategory category) {
		// TODO Auto-generated method stub
		this.category = category;
	}

	@Override
	public FaqCategory getCategory() {
		// TODO Auto-generated method stub
		return this.category;
	}

}
