package com.mpower.util;

import java.util.Iterator;
import com.mpower.domain.ReportChartSettings;
import com.mpower.domain.ReportCrossTabColumn;
import com.mpower.domain.ReportCrossTabMeasure;
import com.mpower.domain.ReportCrossTabRow;
import com.mpower.domain.ReportCustomFilterCriteria;
import com.mpower.domain.ReportFilter;
import com.mpower.domain.ReportSelectedField;
import com.mpower.domain.ReportWizard;

public class ReportWizardHelper {

	public static void PopulateWizardFromSavedReport(ReportWizard emptyWizard, ReportWizard savedWizard, boolean copyIds) {
		emptyWizard.setDataSubSourceGroupId(savedWizard.getDataSubSourceGroupId());
		if (copyIds)
			emptyWizard.setId(savedWizard.getId());
		emptyWizard.setRecordCount(savedWizard.getRecordCount());
		emptyWizard.setUseReportAsSegmentation(savedWizard.getUseReportAsSegmentation());
		emptyWizard.setSegmentationQuery(savedWizard.getSegmentationQuery());
		emptyWizard.setReportSegmentationTypeId(savedWizard.getReportSegmentationTypeId());
		emptyWizard.setExecutionTime(savedWizard.getExecutionTime());
		emptyWizard.setResultCount(savedWizard.getResultCount());
		emptyWizard.setLastRunDateTime(savedWizard.getLastRunDateTime());
		emptyWizard.setLastRunByUserName(savedWizard.getLastRunByUserName());

		emptyWizard.getReportChartSettings().clear();
		emptyWizard.getReportChartSettings().addAll(savedWizard.getReportChartSettings());
		emptyWizard.setReportComment(savedWizard.getReportComment());
		if (copyIds)
			emptyWizard.getReportCrossTabFields().setId(savedWizard.getReportCrossTabFields().getId());
		emptyWizard.getReportCrossTabFields().getReportCrossTabColumns().clear();
		emptyWizard.getReportCrossTabFields().getReportCrossTabColumns().addAll(savedWizard.getReportCrossTabFields().getReportCrossTabColumns());
		emptyWizard.getReportCrossTabFields().getReportCrossTabMeasure().clear();
		emptyWizard.getReportCrossTabFields().getReportCrossTabMeasure().addAll(savedWizard.getReportCrossTabFields().getReportCrossTabMeasure());
		emptyWizard.getReportCrossTabFields().setReportCrossTabOperation(savedWizard.getReportCrossTabFields().getReportCrossTabOperation());
		emptyWizard.getReportCrossTabFields().getReportCrossTabRows().clear();
		emptyWizard.getReportCrossTabFields().getReportCrossTabRows().addAll(savedWizard.getReportCrossTabFields().getReportCrossTabRows());
		emptyWizard.getReportFilters().clear();

	    Iterator itReportFilters = savedWizard.getReportFilters().iterator();
	    while (itReportFilters.hasNext()){
	    	ReportFilter reportFilter = (ReportFilter)itReportFilters.next();
	    	ReportFilter newReportFilter = new ReportFilter();
	    	newReportFilter.setFilterType(reportFilter.getFilterType());
	    	if (copyIds)
	    		newReportFilter.setId(reportFilter.getId());
	    	newReportFilter.setOperator(reportFilter.getOperator());
	    	newReportFilter.setOperatorNot(reportFilter.getOperatorNot());
	    	newReportFilter.setReportStandardFilter(reportFilter.getReportStandardFilter());
	    	if (!copyIds)
	    		newReportFilter.getReportStandardFilter().setId(0);
	    	if (copyIds)
	    		newReportFilter.getReportCustomFilter().setCustomFilterId(reportFilter.getReportCustomFilter().getCustomFilterId());
	    	newReportFilter.getReportCustomFilter().setCustomFilterDefinitionId(reportFilter.getReportCustomFilter().getCustomFilterDefinitionId());
    		newReportFilter.getReportCustomFilter().setDisplayHtml(reportFilter.getReportCustomFilter().getDisplayHtml());
	    	newReportFilter.getReportCustomFilter().getReportCustomFilterCriteria().addAll(reportFilter.getReportCustomFilter().getReportCustomFilterCriteria());

	    	if (!copyIds) {
	    		Iterator<ReportCustomFilterCriteria> itReportCustomFilterCriteria = newReportFilter.getReportCustomFilter().getReportCustomFilterCriteria().iterator();
		    	while (itReportCustomFilterCriteria.hasNext()){
		    		ReportCustomFilterCriteria reportCustomFilterCriteria = (ReportCustomFilterCriteria)itReportCustomFilterCriteria.next();
		    		reportCustomFilterCriteria.setCustomFilterCriteriaId(0);
		    	}
	    	}

	    	emptyWizard.getReportFilters().add(newReportFilter);
	    }

		emptyWizard.setReportLayout(savedWizard.getReportLayout());
		if (copyIds)
			emptyWizard.setReportName(savedWizard.getReportName());
		else
			emptyWizard.setReportName("Copy of " + savedWizard.getReportName());
		emptyWizard.setReportPath(savedWizard.getReportPath());
		emptyWizard.getReportSelectedFields().clear();
		emptyWizard.getReportSelectedFields().addAll(savedWizard.getReportSelectedFields());
		emptyWizard.setReportTemplateJRXML(savedWizard.getReportTemplateJRXML());
		emptyWizard.setReportTemplatePath(savedWizard.getReportTemplatePath());
		emptyWizard.setReportType(savedWizard.getReportType());
		emptyWizard.setRowCount(savedWizard.getRowCount());
		emptyWizard.setSrcId(savedWizard.getSrcId());
		emptyWizard.setSubSourceId(savedWizard.getSubSourceId());
		emptyWizard.setUniqueRecords(savedWizard.getUniqueRecords());

		if (!copyIds)
		{
		    Iterator<ReportSelectedField> itReportFields = emptyWizard.getReportSelectedFields().iterator();
		    while (itReportFields.hasNext()){
		    	ReportSelectedField reportField = (ReportSelectedField)itReportFields.next();
		    	reportField.setId(0);
		    }

		    Iterator<ReportChartSettings> itReportChartSettings = emptyWizard.getReportChartSettings().iterator();
		    while (itReportChartSettings.hasNext()){
		    	ReportChartSettings reportChartSetting = (ReportChartSettings)itReportChartSettings.next();
		    	reportChartSetting.setId(0);
		    }

		    Iterator<ReportCrossTabColumn> itReportCrossTabColumn = emptyWizard.getReportCrossTabFields().getReportCrossTabColumns().iterator();
		    while (itReportCrossTabColumn.hasNext()){
		    	ReportCrossTabColumn reportCrossTabColumn = (ReportCrossTabColumn)itReportCrossTabColumn.next();
		    	reportCrossTabColumn.setId(0);
		    }

		    Iterator<ReportCrossTabRow> itReportCrossTabRow = emptyWizard.getReportCrossTabFields().getReportCrossTabRows().iterator();
		    while (itReportCrossTabRow.hasNext()){
		    	ReportCrossTabRow reportCrossTabRow = (ReportCrossTabRow)itReportCrossTabRow.next();
		    	reportCrossTabRow.setId(0);
		    }

		    Iterator<ReportCrossTabMeasure> itReportCrossTabMeasure = emptyWizard.getReportCrossTabFields().getReportCrossTabMeasure().iterator();
		    while (itReportCrossTabMeasure.hasNext()){
		    	ReportCrossTabMeasure reportCrossTabMeasure = (ReportCrossTabMeasure)itReportCrossTabMeasure.next();
		    	reportCrossTabMeasure.setId(0);
		    }
		}
	}
}
