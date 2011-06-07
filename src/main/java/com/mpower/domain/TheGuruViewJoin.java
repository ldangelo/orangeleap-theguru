package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@Entity
@Table(name = "THEGURU_VIEW_JOIN")
public class TheGuruViewJoin implements java.io.Serializable,
		Comparable<TheGuruViewJoin> {
	/**
	 *
	 */
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "JOIN_ID")
	private long id;

	@Column(name = "VIEW_ID")
	private long viewId;
	
	@Column(name = "JOIN_TYPE")
	private String joinType;
	
	@Column(name = "JOIN_TABLE")
	private String joinTable;
	
	@Column(name = "JOIN_TABLE_IS_VIEW")
	private boolean joinTableIsView;
	
	@Column(name = "JOIN_TABLE_ALIAS")
	private String joinTableAlias;
	
	@Column(name = "JOIN_TABLE_COLUMN_PREFIX")
	private String joinTableColumnPrefix;
	
	@Column(name = "JOIN_CRITERIA")
	private String joinCriteria;
	
	@Column(name = "FIELD_GROUP_PREFIX")
	private String fieldGroupPrefix;
	
	@Column(name = "FIELD_GROUP_OVERRIDE")
	private String fieldGroupOverride;
	
	@Column(name = "INCLUDE_ALL_FIELDS")
	private boolean includeAllFields;
	
	@Column(name = "SORT_ORDER")
	private int sortOrder;
	
	@Column(name = "PARENT_ENTITY_TYPE")
	private String parentEntityType;
	
	@Column(name = "SUB_FIELD_NAME")
	private String subFieldName;
	
	@Column(name = "DEFAULT_PAGE_TYPE")
	private String defaultPageType;
	
	@Column(name = "USE_PARENT_FIELD_GROUP_PREFIXES")
	private boolean useParentFieldGroupPrefix;
	
	@Column(name = "REQUIRES_JOIN_ID")	
	private long requiresJoinId;
	
	@Transient
	private String whereClause;

	public TheGuruViewJoin() {

	}

	public TheGuruViewJoin(long id, long viewId, String joinType,
			String joinTable, boolean joinTableIsView, String joinTableAlias,
			String joinTableColumnPrefix, String joinCriteria,
			String fieldGroupPrefix, String fieldGroupOverride,
			boolean includeAllFields, int sortOrder, String parentEntityType,
			String subFieldName, String defaultPageType,
			boolean useParentFieldGroupPrefix, long requiresJoinId, String whereClause) {
		super();
		this.id = id;
		this.viewId = viewId;
		this.joinType = joinType;
		this.joinTable = joinTable;
		this.joinTableIsView = joinTableIsView;
		this.joinTableAlias = joinTableAlias;
		this.joinTableColumnPrefix = joinTableColumnPrefix;
		this.joinCriteria = joinCriteria;
		this.fieldGroupPrefix = fieldGroupPrefix;
		this.fieldGroupOverride = fieldGroupOverride;
		this.includeAllFields = includeAllFields;
		this.sortOrder = sortOrder;
		this.parentEntityType = parentEntityType;
		this.subFieldName = subFieldName;
		this.defaultPageType = defaultPageType;
		this.useParentFieldGroupPrefix = useParentFieldGroupPrefix;
		this.requiresJoinId = requiresJoinId;
		this.whereClause = whereClause;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int compareTo(TheGuruViewJoin o) {
		if (this.sortOrder > o.sortOrder)
			return 1;
		if (this.sortOrder < o.sortOrder)
			return -1;

		return 0;
	}

	public void setViewId(long viewId) {
		this.viewId = viewId;
	}

	public long getViewId() {
		return viewId;
	}

	public void setJoinType(String joinType) {
		this.joinType = joinType;
	}

	public String getJoinType() {
		return joinType;
	}

	public void setJoinTable(String joinTable) {
		this.joinTable = joinTable;
	}

	public String getJoinTable() {
		return joinTable;
	}

	public void setJoinTableIsView(boolean joinTableIsView) {
		this.joinTableIsView = joinTableIsView;
	}

	public boolean isJoinTableIsView() {
		return joinTableIsView;
	}

	public void setJoinTableAlias(String joinTableAlias) {
		this.joinTableAlias = joinTableAlias;
	}

	public String getJoinTableAlias() {
		return joinTableAlias;
	}

	public void setJoinTableColumnPrefix(String joinTableColumnPrefix) {
		this.joinTableColumnPrefix = joinTableColumnPrefix;
	}

	public String getJoinTableColumnPrefix() {
		return joinTableColumnPrefix;
	}

	public void setJoinCriteria(String joinCriteria) {
		this.joinCriteria = joinCriteria;
	}

	public String getJoinCriteria() {
		return joinCriteria;
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

	public void setUseParentFieldGroupPrefix(boolean useParentFieldGroupPrefix) {
		this.useParentFieldGroupPrefix = useParentFieldGroupPrefix;
	}

	public boolean isUseParentFieldGroupPrefix() {
		return useParentFieldGroupPrefix;
	}

	public void setRequiresJoinId(long requiresJoinId) {
		this.requiresJoinId = requiresJoinId;
	}

	public long getRequiresJoinId() {
		return requiresJoinId;
	}

	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}

	public String getWhereClause() {
		return whereClause;
	}
}
