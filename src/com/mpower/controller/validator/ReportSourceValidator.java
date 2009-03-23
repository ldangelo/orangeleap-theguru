package com.mpower.controller.validator;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import com.mpower.domain.ReportWizard;

public class ReportSourceValidator extends ReportWizardValidator {

	@SuppressWarnings("unchecked")
    @Override
    public boolean supports(Class clazz) {
        return ReportWizard.class.equals(clazz);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        logger.debug("in SourceValidator");
        ReportWizard wiz = (ReportWizard)obj;
        if (wiz == null)
        {
           errors.reject("error.nullpointer", "Null data received");
        }
        else
        {
           if (wiz.getSrcId() == -1)
           {
              errors.reject("error.code", "Report Source: Primary Report Source not Selected.");
           }
           if (wiz.getSubSourceId() == -1)
           {
              errors.reject("error.code", "Report Source: Secondary Report Source not Selected.");
           }
        }
    }
}


