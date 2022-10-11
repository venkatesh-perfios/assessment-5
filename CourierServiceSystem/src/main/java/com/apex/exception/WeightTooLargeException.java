package com.apex.exception;

public class WeightTooLargeException extends Exception {
	private static final long serialVersionUID = 1L;

	public WeightTooLargeException(String msg) {
		super(msg);
	}
}
