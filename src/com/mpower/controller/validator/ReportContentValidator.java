package com.mpower.controller.validator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mpower.domain.ReportWizard;

public class ReportContentValidator implements Validator {

    /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    @SuppressWarnings("unchecked")
    @Override
    public boolean supports(Class clazz) {
        return ReportWizard.class.equals(clazz);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        logger.debug("in TestValidator");
        validateReportWizard(obj, errors);
    }

    public static void validateReportWizard(Object obj, Errors errors) {
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

