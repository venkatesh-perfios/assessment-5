package com.apex.exception;

public class SourceSameAsDestinationException extends Exception {
	private static final long serialVersionUID = 1L;

	public SourceSameAsDestinationException(String msg) {
		super(msg);
	}
}
