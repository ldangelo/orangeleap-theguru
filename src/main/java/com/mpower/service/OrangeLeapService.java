package com.mpower.service;

import java.util.List;

import com.mpower.ws.orangeleapV2.client.Picklist;

public interface OrangeLeapService {
	public Picklist getPicklistByName(String picklistName);
	public List<String> getPostalCodesInRadius(String country, String postalCode, int radius);
}
