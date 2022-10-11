package com.apex.model;

public class OrderInfo {
	private String name;
	private long phone;
	private String source;
	private String destination;
	private int distance;
	private double weight;
	private double amount;
	private String trackingId;
	private String dateOfShipment;
	private String dateOfDelivery;
	
	public void setDateOfDelivery(String dateOfDelivery) {
		this.dateOfDelivery = dateOfDelivery;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getTrackingId() {
		return trackingId;
	}
	public void setTrackingId(String trackingId) {
		this.trackingId = trackingId;
	}
	public String getDateOfShipment() {
		return dateOfShipment;
	}
	public void setDateOfShipment(String dateOfShipment) {
		this.dateOfShipment = dateOfShipment;
	}
	public String getDateOfDelivery() {
		return dateOfDelivery;
	}
}
