package com.trad.exception;

public class JsonException extends Throwable{

	private static final long serialVersionUID = 1L;

	public JsonException() {
		super();
	}
	
	public JsonException(String message, Throwable cause) {
		super(message, cause);
	}

	public JsonException(String message) {
		super(message);
	}

	public JsonException(Throwable cause) {
		super(cause);
	}

	@Override
	public String getLocalizedMessage() {
		return super.getLocalizedMessage();
	}

	@Override
	public String getMessage() {
		return super.getMessage();
	}
}
