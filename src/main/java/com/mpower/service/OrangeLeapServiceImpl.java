package com.mpower.service;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.mpower.ws.orangeleapV2.client.GetPickListByNameRequest;
import com.mpower.ws.orangeleapV2.client.GetPickListByNameResponse;
import com.mpower.ws.orangeleapV2.client.OrangeLeapWebServiceClientV2;
import com.mpower.ws.orangeleapV2.client.Picklist;
import com.mpower.ws.orangeleapV2.client.PicklistItem;
import com.mpower.ws.orangeleapV3.client.GetPostalCodesByRadiusRequest;
import com.mpower.ws.orangeleapV3.client.GetPostalCodesByRadiusResponse;
import com.mpower.ws.orangeleapV3.client.OrangeLeapWebServiceClientV3;
import com.mpower.ws.orangeleapV3.client.PostalCodeByRadius;

@Service("orangeLeapService")
public class OrangeLeapServiceImpl implements OrangeLeapService {

	public Picklist getPicklistByName(String picklistName) {
		OrangeLeapWebServiceClientV2 client = new OrangeLeapWebServiceClientV2();
		GetPickListByNameRequest wsrequest = new GetPickListByNameRequest();
		wsrequest.setName(picklistName);
		GetPickListByNameResponse response = client.getOrangeLeap().getPickListByName(wsrequest);
		return response.getPicklist();
	}
	
	public List<String> getPostalCodesInRadius(String country, String postalCode, int radius) {
		List<String> result = new ArrayList<String>();   
		OrangeLeapWebServiceClientV3 client = new OrangeLeapWebServiceClientV3();
		GetPostalCodesByRadiusRequest request = new GetPostalCodesByRadiusRequest();
		request.setCountry(country);
		request.setPostalCode(postalCode);
		request.setRadius(radius);
		GetPostalCodesByRadiusResponse response = client.getOrangeLeap().getPostalCodesByRadius(request);
		for (PostalCodeByRadius postalCodeByRadius : response.getPostalCodesByRadius()) {
			if (postalCodeByRadius.getZipCode() != null)
				result.add(postalCodeByRadius.getZipCode());
		}
		return result;
	}
}
