package com.mpower.util;

import com.mpower.domain.FilterOperator;
import com.mpower.domain.ReportFieldType;

public class InputControlParameters {
	private String label;
	private ReportFieldType type;
	private FilterOperator  filter;
	
	public String getLabel() {
		String v = label;
		
		if (filter == FilterOperator.CONTAINS)
			v += " Contains";
		if (filter == FilterOperator.EQUAL)
			v += " Equals";
		if (filter == FilterOperator.EXCLUDES)
			v += " Exludes";
		if (filter == FilterOperator.GT)
			v += " Greater Than";
		if (filter == FilterOperator.GTEQ)
			v += " Greater Than Or Equal To";
		if (filter == FilterOperator.INCLUDES)
			v += " Includes";
		if (filter == FilterOperator.LT)
			v += " Less Than";
		if (filter == FilterOperator.LTEQ)
			v += " Less Than or Equal To";
		if (filter == FilterOperator.NOTEQ)
			v += " Not Equal To";
		if (filter == FilterOperator.STARTSWITH)
			v += " Starts With";
		
		return v;
	}

	public void setLabel(String label) {
		this.label = label;
	}
	public ReportFieldType getType() {
		return type;
	}
	public void setType(ReportFieldType type) {
		this.type = type;
	}
	public FilterOperator getFilter() {
		return filter;
	}
	public void setFilter(FilterOperator filter) {
		this.filter = filter;
	}

	public void setFilter(Integer operator) {
		// TODO Auto-generated method stub
		switch (operator) {
		case 0:
			this.filter = FilterOperator.NONE; 
			break;
		case 1:
			this.filter = FilterOperator.EQUAL; 
			break;
		case 2:
			this.filter = FilterOperator.NOTEQ; 
			break;
		case 3:
			this.filter = FilterOperator.LT; 
			break;
		case 4:
			this.filter = FilterOperator.GT; 
			break;
		case 5:
			this.filter = FilterOperator.LTEQ; 
			break;
		case 6:
			this.filter = FilterOperator.GTEQ; 
			break;
		case 7:
			this.filter = FilterOperator.CONTAINS; 
			break;
		case 8:
			this.filter = FilterOperator.STARTSWITH; 
			break;
		case 9:
			this.filter = FilterOperator.INCLUDES; 
			break;
		case 10:
			this.filter = FilterOperator.EXCLUDES; 
			break;
			
			
		}

			
	}
}
