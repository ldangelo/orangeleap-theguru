package com.mpower.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mpower.domain.dwr.OrangeLeapPicklistItem;

public interface DWROrangeLeapService {
  public List<OrangeLeapPicklistItem> getPicklistItemsByPicklistName(String picklistName);
  public String getOrangeLeapDataAsSelectOptions(String requestType, Map<String, String> criteria);
}