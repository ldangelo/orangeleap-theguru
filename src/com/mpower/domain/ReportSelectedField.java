package com.mpower.domain;

public class ReportSelectedField implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8582013308660972485L;
	
	private long fieldId;
	private boolean groupBy;
	private String sortOrder;
	private boolean sum;
	private boolean average;
	private boolean count;
	private boolean max;
	private boolean min;
	
	public void setFieldId(long fieldId) {
		this.fieldId = fieldId;
	}
	
	public long getFieldId() {
		return fieldId;
	}
	
	public void setGroupBy(boolean groupBy) {
		this.groupBy = groupBy;
	}
	
	public boolean getGroupBy() {
		return groupBy;
	}
	
	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}
	
	public String getSortOrder() {
		return sortOrder;
	}
	
	public void setSum(boolean sum) {
		this.sum = sum;
	}
	
	public boolean getSum() {
		return sum;
	}
	
	public void setAverage(boolean average) {
		this.average = average;
	}
	
	public boolean getAverage() {
		return average;
	}
	
	public void setMax(boolean max) {
		this.max = max;
	}
	
	public boolean getMax() {
		return max;
	}
	
	public void setMin(boolean min) {
		this.min = min;
	}
	
	public boolean getMin() {
		return min;
	}
	
	public void setCount(boolean count) {
		this.count = count;
	}

	public boolean getCount() {
		return count;
	}

	public boolean getIsSummarized() {
		if (sum || average || max || min || count)
			return true;
		else
			return false;
	}	
}
