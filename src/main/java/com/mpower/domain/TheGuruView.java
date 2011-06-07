package com.mpower.domain;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "THEGURU_VIEW")
public class TheGuruView implements java.io.Serializable,
		Comparable<TheGuruView> {
	/**
	 *
	 */
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "VIEW_ID")
	private long id;

	@Column(name = "VIEW_NAME")
	private String viewName;

	@Column(name = "VIEW_DISPLAY_TEXT")
	private String viewDisplayText;
	
	@Column(name = "PRIMARY_TABLE")
	private String primaryTable;
	
	@Column(name = "PRIMARY_TABLE_IS_VIEW")
	private boolean primaryTableIsView;
	
	@Column(name = "PRIMARY_TABLE_ALIAS")
	private String primaryTableAlias;
	
	@Column(name = "PRIMARY_TABLE_COLUMN_PREFIX")
	private String primaryTableColumnPrefix;
	
	@Column(name = "FIELD_GROUP_PREFIX")
	private String fieldGroupPrefix;
	
	@Column(name = "FIELD_GROUP_OVERRIDE")
	private String fieldGroupOverride;
	
	@Column(name = "INCLUDE_ALL_FIELDS")
	private boolean includeAllFields;
	
	@Column(name = "WHERE_CLAUSE", length=8000)
	private String whereClause;
	
	@Column(name = "SORT_ORDER")
	private int sortOrder;
	
	@Column(name = "PARENT_ENTITY_TYPE")
	private String parentEntityType;
	
	@Column(name = "SUB_FIELD_NAME")
	private String subFieldName;
	
	@Column(name = "DEFAULT_PAGE_TYPE")
	private String defaultPageType;
	
	@Column(name = "SQL_OVERRIDE")	
	private String sqlOverride;

	@ManyToMany(mappedBy="reportDataSubSource")
	@IndexColumn(name="REPORTCUSTOMFILTERDEFINITION_ID")
	@Column(name = " REPORTDATASUBSOURCE_REPORTCUSTOMFILTERDEFINITION_ID")
	private List<ReportCustomFilterDefinition> reportCustomFilterDefinitions;


	public TheGuruView() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int compareTo(TheGuruView o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

	public void setReportCustomFilterDefinitions(List<ReportCustomFilterDefinition> reportCustomFilterDefinitions) {
		this.reportCustomFilterDefinitions = reportCustomFilterDefinitions;
	}

	public List<ReportCustomFilterDefinition> getReportCustomFilterDefinitions() {
		return reportCustomFilterDefinitions;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public String getViewName() {
		return viewName;
	}

	public void setViewDisplayText(String viewDisplayText) {
		this.viewDisplayText = viewDisplayText;
	}

	public String getViewDisplayText() {
		return viewDisplayText;
	}

	public void setPrimaryTable(String primaryTable) {
		this.primaryTable = primaryTable;
	}

	public String getPrimaryTable() {
		return primaryTable;
	}

	public void setPrimaryTableIsView(boolean primaryTableIsView) {
		this.primaryTableIsView = primaryTableIsView;
	}

	public boolean isPrimaryTableIsView() {
		return primaryTableIsView;
	}

	public void setPrimaryTableAlias(String primaryTableAlias) {
		this.primaryTableAlias = primaryTableAlias;
	}

	public String getPrimaryTableAlias() {
		return primaryTableAlias;
	}

	public void setPrimaryTableColumnPrefix(String primaryTableColumnPrefix) {
		this.primaryTableColumnPrefix = primaryTableColumnPrefix;
	}

	public String getPrimaryTableColumnPrefix() {
		return primaryTableColumnPrefix;
	}

	public void setFieldGroupPrefix(String fieldGroupPrefix) {
		this.fieldGroupPrefix = fieldGroupPrefix;
	}

	public String getFieldGroupPrefix() {
		return fieldGroupPrefix;
	}

	public void setFieldGroupOverride(String fieldGroupOverride) {
		this.fieldGroupOverride = fieldGroupOverride;
	}

	public String getFieldGroupOverride() {
		return fieldGroupOverride;
	}

	public void setIncludeAllFields(boolean includeAllFields) {
		this.includeAllFields = includeAllFields;
	}

	public boolean isIncludeAllFields() {
		return includeAllFields;
	}

	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}

	public String getWhereClause() {
		return whereClause;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}

	public int getSortOrder() {
		return sortOrder;
	}

	public void setParentEntityType(String parentEntityType) {
		this.parentEntityType = parentEntityType;
	}

	public String getParentEntityType() {
		return parentEntityType;
	}

	public void setSubFieldName(String subFieldName) {
		this.subFieldName = subFieldName;
	}

	public String getSubFieldName() {
		return subFieldName;
	}

	public void setDefaultPageType(String defaultPageType) {
		this.defaultPageType = defaultPageType;
	}

	public String getDefaultPageType() {
		return defaultPageType;
	}

	public void setSqlOverride(String sqlOverride) {
		this.sqlOverride = sqlOverride;
	}

	public String getSqlOverride() {
		return sqlOverride;
	}
}
