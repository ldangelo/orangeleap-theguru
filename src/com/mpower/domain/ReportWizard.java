package com.mpower.domain;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.SortedSet;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTWIZARD")
public class ReportWizard implements java.io.Serializable {

	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTWIZARD_ID")
	private Long id;
	
	@Column(name = "REPORT_NAME")
	private String reportName;
	@Column(name = "REPORT_COMMENT")
	private String reportComment;
	
	@Column(name="ROW_COUNT")
	private Integer rowCount;

	@Column(name="REPORTDATASOURCE_ID")
	private long srcId;

	@Column(name = "REPORTSUBSOURCE_ID")
	private long subSourceId;

	@Transient
	private ReportDataSource src;

	@Transient
	private ReportDataSubSource subsource;

	@Transient
	private List<ReportDataSource> sources;

	@Transient
	private List<ReportDataSubSource> subsources;

	@ManyToMany()
	@IndexColumn(name="REPORTFIELD_ID")
	private List<ReportField> fields;

	@ManyToMany()
	@IndexColumn(name="REPORTFIELDGROUP_ID")
	@Column(name = "FIELDGROUPS")
	private List<ReportFieldGroup> fieldGroups;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTADVANCEDFILTER_ID")
	private List<ReportAdvancedFilter> advancedFilters;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTGROUPBYFIELD_ID")
	private List<ReportGroupByField> reportGroupByFields;
	
	@Transient
	private List<ReportChartSettings> reportChartSettings;
	
	@Column(name = "REPORT_TYPE")
	private String reportType;
	private Boolean recordCount;
	private String reportColumnOrder;
	private String reportPath;
	
	public ReportWizard() {
		reportType = "tabular";
		srcId = 0;
		subSourceId = 0;
		rowCount = -1;
		recordCount = false;

		//
		// create an advanced filter list decorated as a LazyList
		//advancedFilters = LazyList.decorate(new ArrayList<ReportAdvancedFilter>(),FactoryUtils.instantiateFactory(ReportAdvancedFilter.class, new Class[]{ReportAdvancedFilter.class},new Object[]{}));
		advancedFilters = LazyList.decorate(new ArrayList<ReportAdvancedFilter>(),FactoryUtils.instantiateFactory(ReportAdvancedFilter.class));
		reportGroupByFields = LazyList.decorate(new ArrayList<ReportGroupByField>(),FactoryUtils.instantiateFactory(ReportGroupByField.class));
		reportChartSettings = LazyList.decorate(new ArrayList<ReportChartSettings>(),FactoryUtils.instantiateFactory(ReportChartSettings.class));
	}

	public List<ReportAdvancedFilter> getAdvancedFilters() {
		return advancedFilters;
	}

	public List<ReportGroupByField> getReportGroupByFields() {
		return reportGroupByFields;
	}
	
	public List<ReportChartSettings> getReportChartSettings() {
		return reportChartSettings;
	}
	
	public ReportDataSource getDataSource() {
		logger.info("**** in getSrc()");
		return src;
	}
	
	public List<ReportDataSource> getDataSources() {
		return sources;
	}

	public ReportDataSubSource getDataSubSource() {
		logger.info("**** in getDatasubSource");
		return subsource;
	}

	public List<ReportDataSubSource> getDataSubSources() {
		return subsources;
	}

	public List<ReportFieldGroup> getFieldGroups() {
		return fieldGroups;
	}

	public List<ReportField> getFields() {
		return fields;
	}

	public Boolean getRecordCount() {
		return recordCount;
	}

	public String getReportComment() {
		return reportComment;
	}
	
	public ReportDataSource getReportDataSource() {
		return src;
	}

	public String getReportName() {
		return reportName;
	}

	public String getReportType() {
		logger.info("**** getReportType");
		return reportType;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public long getSrcId() {
		return srcId;
	}

	public long getSubSourceId() {
		return subSourceId;
	}

	public String getReportColumnOrder() {
		if (reportColumnOrder == null)
			reportColumnOrder = "";
		if (reportColumnOrder.length() == 0) {			
			Iterator<ReportField> it = fields.iterator();			
			while(it.hasNext()) {
				ReportField f = (ReportField) it.next();
				
				if (f.getSelected()) {
					if (reportColumnOrder.length() > 0)
						reportColumnOrder += ",";
					reportColumnOrder += f.getId();
				}					
			}			
		}
		return reportColumnOrder;
	}

	public void setAdvancedFilters(List<ReportAdvancedFilter> advancedFilters) {
		this.advancedFilters = advancedFilters;
	}

	public void setReportGroupByFields(List<ReportGroupByField> reportGroupByFields) {
		this.reportGroupByFields = reportGroupByFields;
	}
	
	public void setReportChartSettings(List<ReportChartSettings> reportChartSettings) {
		this.reportChartSettings = reportChartSettings;
	}	
	
	public void setDataSource(ReportDataSource src) {
		logger.info("**** in setSrc()");
		this.src = src;
	}

	public void setDataSources(List<ReportDataSource> sources) {
		this.sources = sources;
	}

	public void setDataSubSource(ReportDataSubSource subsource) {
		logger.info("**** in setDatasubSource");
		this.subsource = subsource;
	}

	public void setDataSubSources(List<ReportDataSubSource> subsource) {
		this.subsources = subsource;
	}

	public void setFieldGroups(List<ReportFieldGroup> fieldGroups) {
		this.fieldGroups = fieldGroups;
	}

	public void setFields(List<ReportField> fields) {
		this.fields = fields;
	}

	public void setRecordCount(Boolean count) {
		recordCount = count;
	}

	public void setReportComment(String reportComment) {
		this.reportComment = reportComment;
	}
		
	public void setReportDataSource(ReportDataSource src) {
		this.src = src;
	}

	public void setReportName(String name) {
		reportName = name;
	}

	public void setReportType(String type) {
		logger.info("**** setReportType");
		reportType = type;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public void setSrcId(long srcId) {
		this.srcId = srcId;
	}

	public void setSubSourceId(long srcId) {
		this.subSourceId = srcId;
	}

	public void setReportColumnOrder(String order) {
		this.reportColumnOrder = order;
	}

	public List<ReportField> getSelectedReportFieldsInOrder() {
		List<ReportField> fieldList = new LinkedList<ReportField>();
		StringTokenizer stringTokenizer = new StringTokenizer(getReportColumnOrder(), ",");
		while (stringTokenizer.hasMoreTokens()) {
			int fieldId = Integer.parseInt(stringTokenizer.nextToken());
			Iterator iteratorFields = fields.iterator();
			while(iteratorFields.hasNext()) {
				ReportField reportField = (ReportField) iteratorFields.next();				
				if (reportField.getId() == fieldId) {
					if (reportField.getSelected())
						fieldList.add(reportField);
					break;
				}
			}
		}
		
		// if no fields are selected, use the default fields
		if (fieldList.size() == 0){ 
			fieldList = getDefaultReportFields();
		}
		return fieldList;
	}

	public List<ReportField> getDefaultReportFields() {
		List<ReportField> fieldList = new LinkedList<ReportField>();
		Iterator iteratorFields = fields.iterator();
		while(iteratorFields.hasNext()) {
			ReportField reportField = (ReportField) iteratorFields.next();				
			if (reportField.getIsDefault()) {
					reportField.setSelected(true);
					fieldList.add(reportField);
			}
		}
		return fieldList;
	}
	
	public Boolean IsFieldGroupByField(long fieldId) {
		Boolean result = false;
		if (reportGroupByFields != null)
		{
			Iterator iteratorReportGroupByFields = reportGroupByFields.iterator();
			while(iteratorReportGroupByFields.hasNext()) {
				ReportGroupByField  reportGroupByField = (ReportGroupByField) iteratorReportGroupByFields.next();
				if (reportGroupByField != null && reportGroupByField.fieldId == fieldId) {
					result = true;
					break;
				}
			}
		}
		return result;
	}
	
	public String getReportPath() {
		return reportPath;
	}

	public void setReportPath(String reportPath) {
		this.reportPath = reportPath;
	}
}