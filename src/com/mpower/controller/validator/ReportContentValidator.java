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
        ReportWizard wiz = (ReportWizard)obj;
        if (wiz == null)
        {
           errors.reject("error.nullpointer", "Null data received");
        }
        else
        {
           if (wiz.getReportSelectedFields().size() == 0)
           {
              errors.reject("error.code", "Report Content: No Report Fields Selected.");
           }
        }
    }
}


