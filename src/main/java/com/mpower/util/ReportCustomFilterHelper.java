package com.mpower.util;

import java.util.LinkedList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import com.mpower.domain.ReportCustomFilterCriteria;
import com.mpower.domain.ReportCustomFilterDefinition;
import com.mpower.domain.ReportFilter;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportCustomFilterDefinitionService;

public class ReportCustomFilterHelper {
	private ReportCustomFilterDefinitionService reportCustomFilterDefinitionService;
	private ReportCustomFilterDefinitionLookup reportCustomFilterDefinitionLookup;

	public List<ReportFilter> refreshReportCustomFilters(ApplicationContext applicationContext, ReportWizard wiz) {
		List<ReportFilter> reportFilters = wiz.getReportFilters();
		List<ReportFilter> newReportFilters = new LinkedList<ReportFilter>();
		for (ReportFilter reportFilter : reportFilters) {
			// If it's a custom filter, get the filter definition and repopulate the criteria
			if (reportFilter.getFilterType() == 2) {
				ReportCustomFilterDefinition reportCustomFilterDefinition = reportCustomFilterDefinitionService.find(
						reportFilter.getReportCustomFilter().getCustomFilterDefinitionId());
				reportCustomFilterDefinition = getReportCustomFilterDefinitionLookups(applicationContext, wiz, reportCustomFilterDefinition, reportFilter.getReportCustomFilter().getReportCustomFilterCriteria());
				reportFilter.getReportCustomFilter().setDisplayHtml(reportCustomFilterDefinition.getDisplayHtml());
				newReportFilters.add(reportFilter);

			} else {
				newReportFilters.add(reportFilter);
			}
		}
		return newReportFilters;
	}

	public List<ReportCustomFilterDefinition> getReportCustomFilterDefinitions(ApplicationContext applicationContext, ReportWizard wiz) {
		List<ReportCustomFilterDefinition> filterDefinitions = reportCustomFilterDefinitionService.readReportCustomFilterDefinitionBySubSourceId(wiz.getSubSourceId());
		List<ReportCustomFilterDefinition> newFilterDefinitions = new LinkedList<ReportCustomFilterDefinition>();
		for (ReportCustomFilterDefinition filterDefinition : filterDefinitions) {
			newFilterDefinitions.add(getReportCustomFilterDefinitionLookups(applicationContext, wiz, filterDefinition, null));
			//filterDefinition = getReportCustomFilterDefinitionLookups(applicationContext, wiz, filterDefinition, null);
		}
		return newFilterDefinitions;
	}

	public ReportCustomFilterDefinition getReportCustomFilterDefinitionLookups(ApplicationContext applicationContext, ReportWizard wiz, ReportCustomFilterDefinition filterDefinition, List<ReportCustomFilterCriteria> selectedValues) {
		ReportCustomFilterDefinition result = new ReportCustomFilterDefinition(filterDefinition);
		result.setId(filterDefinition.getId());
		int criteriaIndex = 0;
		String displayHtml = result.getDisplayHtml();
		int stringIndex = displayHtml.indexOf("{", 0);
		String lookupReferenceBeanString = "{lookupReferenceBean:";
		while (stringIndex > 0)
		{
			int beginIndex = displayHtml.indexOf("{", stringIndex);
			int endIndex = displayHtml.indexOf("}", beginIndex) + 1;
			String field = displayHtml.substring(beginIndex, endIndex);
			String selectedValue = "";
			if (selectedValues != null)
				selectedValue = selectedValues.get(criteriaIndex).getCriteria();
			// If it is a lookup reference, get the bean name and call the lookup.  Otherwise, just set the value
			if (field.startsWith(lookupReferenceBeanString)) {
				String beanName = field.replace("{lookupReferenceBean:", "").replace("}", "");
				displayHtml = displayHtml.substring(0, beginIndex) +
					reportCustomFilterDefinitionLookup.getLookupHtml(applicationContext, beanName, wiz, criteriaIndex, selectedValue)
					+ displayHtml.substring(endIndex);
			} else {
				if (selectedValues != null)
				  displayHtml = displayHtml.replace(field, selectedValue);
			}

			stringIndex = displayHtml.indexOf("{", stringIndex + 1);
			criteriaIndex++;
		}
		result.setDisplayHtml(displayHtml);
		return result;
	}

	public ReportCustomFilterDefinitionService getReportCustomFilterDefinitionService() {
		return reportCustomFilterDefinitionService;
	}

	public void setReportCustomFilterDefinitionService(
			ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) {
		this.reportCustomFilterDefinitionService = reportCustomFilterDefinitionService;
	}

	public ReportCustomFilterDefinitionLookup getReportCustomFilterDefinitionLookup() {
		return reportCustomFilterDefinitionLookup;
	}

	public void setReportCustomFilterDefinitionLookup(
			ReportCustomFilterDefinitionLookup reportCustomFilterDefinitionLookup) {
		this.reportCustomFilterDefinitionLookup = reportCustomFilterDefinitionLookup;
	}
}
