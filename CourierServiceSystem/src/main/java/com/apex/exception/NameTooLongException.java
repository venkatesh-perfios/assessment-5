package com.apex.exception;

public class NameTooLongException extends Exception {
	private static final long serialVersionUID = 1L;

	public NameTooLongException(String msg) {
		super(msg);
	}
}
