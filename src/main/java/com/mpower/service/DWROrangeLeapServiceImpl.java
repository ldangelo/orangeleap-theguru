package com.mpower.service;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import com.mpower.domain.dwr.OrangeLeapPicklistItem;
import com.mpower.ws.orangeleapV2.client.Picklist;
import com.mpower.ws.orangeleapV2.client.PicklistItem;

public class DWROrangeLeapServiceImpl implements DWROrangeLeapService {

	@Resource(name = "orangeLeapService")
	private OrangeLeapService orangeLeapService;

	public List<OrangeLeapPicklistItem> getPicklistItemsByPicklistName(String picklistName) {
		Picklist picklist = orangeLeapService.getPicklistByName(picklistName);
		List<OrangeLeapPicklistItem> result = new ArrayList<OrangeLeapPicklistItem>();
		for (PicklistItem picklistItem : picklist.getPicklistItems()) {
			OrangeLeapPicklistItem item = new OrangeLeapPicklistItem(picklistItem);
			result.add(item);
		}
		return result;
	}
  
	public String getOrangeLeapDataAsSelectOptions(String requestType, Map<String, String> criteria) {
		String result = "";
		if (requestType.toUpperCase().equals("PICKLISTITEMS")) {
			String picklistName = "";
			String defaultValue = "";
			for (String key : criteria.keySet()) {
			  	if (key.toUpperCase().equals("PICKLISTNAME")) {
			  		picklistName = criteria.get(key);
			  	}
			  	if (key.toUpperCase().equals("DEFAULTVALUE")) {
			  		defaultValue = criteria.get(key);
			  	}
			}
			if (picklistName.length() > 0) {
				Picklist picklist = orangeLeapService.getPicklistByName(picklistName);
				for (PicklistItem picklistItem : picklist.getPicklistItems()) {
					result += "<option value=\"" + picklistItem.getItemName() + "\"";
					if (picklistItem.getItemName().equals(defaultValue))
						result += " selected=true ";
					result += ">" + picklistItem.getLongDescription() + "</option>";
				}
			}
	  	}
		return result;
  }
}