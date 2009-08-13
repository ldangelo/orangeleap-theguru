package com.mpower.util;

import org.springframework.context.ApplicationContext;

import com.mpower.domain.ReportWizard;
import com.mpower.service.customfilterdefinitionlookup.ReportCustomFilterDefinitionLookupService;

public class ReportCustomFilterDefinitionLookup {

	public String getLookupHtml(ApplicationContext applicationContext, String beanName, ReportWizard reportWizard) {
		ReportCustomFilterDefinitionLookupService reportCustomFilterDefinitionLookupService = (ReportCustomFilterDefinitionLookupService)applicationContext.getBean(beanName);
		String result = "";
		if (reportCustomFilterDefinitionLookupService != null) {
			result = reportCustomFilterDefinitionLookupService.getLookupHtml(reportWizard);
		}
		return result;
	}
}
