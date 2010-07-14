package com.mpower.domain.dwr;

import java.lang.String;

import com.mpower.ws.orangeleapV2.client.PicklistItem;

public class OrangeLeapPicklistItem {
	private String displayName;
	private String itemName;

	public OrangeLeapPicklistItem(PicklistItem picklistItem) {
		itemName = picklistItem.getItemName();
		displayName = picklistItem.getLongDescription();
	}

	public String getDisplayName() {
		return displayName;
	}

	public String getItemName() {
		return itemName;
	}
}