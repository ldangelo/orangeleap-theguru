package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "REPORTSELECTEDFIELD")
public class ReportSelectedField implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8582013308660972485L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSELECTEDFIELD_ID")
	private long id;

	@Column(name = "FIELD_ID")
	private long fieldId;
	
	@Column(name = "GROUP_BY")
	private boolean groupBy;
	
	@Column(name = "SORT_ORDER")
	private String sortOrder;
	
	@Column(name = "SUM")
	private boolean sum;
	
	@Column(name = "AVERAGE")
	private boolean average;
	
	@Column(name = "COUNT")
	private boolean count;
	
	@Column(name = "MAX")
	private boolean max;
	
	@Column(name = "MIN")
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

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}	
}
