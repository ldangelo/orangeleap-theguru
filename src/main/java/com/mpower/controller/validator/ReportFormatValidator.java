package com.mpower.controller.validator;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import com.mpower.domain.ReportWizard;

public class ReportFormatValidator extends ReportWizardValidator {

	@SuppressWarnings("unchecked")
    @Override
    public boolean supports(Class clazz) {
        return ReportWizard.class.equals(clazz);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        logger.debug("in ContentValidator");
        ReportWizard wiz = (ReportWizard)obj;
        if (wiz == null)
        {
           errors.reject("error.nullpointer", "Null data received");
        }
        else
        {
           if (wiz.getReportType() == null)
           {
              errors.reject("error.code", "Report Format: Report Format not Selected.");
           }
        }
    }
}


