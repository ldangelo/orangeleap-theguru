package com.mpower.controller.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import com.mpower.domain.ReportWizard;

public class ReportContentValidator extends ReportWizardValidator {

	@SuppressWarnings("unchecked")
	@Override
	public boolean supports(Class clazz) {
		return ReportWizard.class.equals(clazz);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		logger.debug("in ContentValidator");
		ReportWizard wiz = (ReportWizard) obj;
		if (wiz == null) {
			errors.reject("error.nullpointer", "Null data received");
		} else if (wiz.getReportType().compareToIgnoreCase("tabular") == 0
				&& wiz.getReportSelectedFields().size() == 0) {
			errors.reject("error.code",
					"Report Content: No Report Fields Selected.");
		} else if (wiz.getReportType().compareToIgnoreCase("matrix") == 0
				&& wiz.getReportCrossTabFields().getReportCrossTabColumns()
						.size() == 1
				&& wiz.getReportCrossTabFields().getReportCrossTabColumns()
						.get(0).getFieldId() == -1) {
			errors.reject("error.code",
					"Report Content: No Report Columns Selected.");
		} else if (wiz.getReportType().compareToIgnoreCase("matrix") == 0
				&& wiz.getReportCrossTabFields().getReportCrossTabRows().size() == 1
				&& wiz.getReportCrossTabFields().getReportCrossTabRows().get(0)
						.getFieldId() == -1) {
			errors.reject("error.code",
					"Report Content: No Report Rows Selected.");
		} else if (wiz.getReportType().compareToIgnoreCase("matrix") == 0
				&& wiz.getReportCrossTabFields().getReportCrossTabMeasure()
						.size() == 1
				&& wiz.getReportCrossTabFields().getReportCrossTabMeasure()
						.get(0).getFieldId() == -1) {
			errors.reject("error.code",
					"Report Content: No Report Measure Selected.");
		}
	}
}
