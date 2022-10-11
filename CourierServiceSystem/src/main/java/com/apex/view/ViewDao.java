package com.apex.view;

import java.sql.ResultSet;
import java.sql.Statement;

import com.apex.utils.DatabaseUtils;

public class ViewDao {
	private static final String TABLE_NAME = "Orders";
	
	public static ResultSet getOrders(String trackingID) throws Exception {
		String getOrdersSql = "select * from " + TABLE_NAME + " where Tracking_ID='" + trackingID + "'";
		Statement statement = DatabaseUtils.getConnection().createStatement();
		
		return statement.executeQuery(getOrdersSql);
	}
}
