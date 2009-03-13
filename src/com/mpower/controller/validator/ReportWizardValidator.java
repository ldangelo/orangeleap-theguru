package com.mpower.controller.validator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mpower.domain.ReportWizard;

public class ReportWizardValidator implements Validator {

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
        validateReportContent(obj, errors);
    }

    public static void validateReportSource(Object obj, Errors errors) {
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

    public static void validateReportFormat(Object obj, Errors errors) {
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

    public static void validateReportContent(Object obj, Errors errors) {
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

    public static void validateReportCriteria(Object obj, Errors errors) {
        ReportWizard wiz = (ReportWizard)obj;
        if (wiz == null)
        {
           errors.reject("error.nullpointer", "Null data received");
        }
        else
        {
           if (wiz.getReportSelectedFields().size() == 0 && wiz.getReportType() != "matrix")
           {
              errors.reject("error.code", "Report Content: No Report Fields Selected.");
           }
        }
    }

    public static void validateReportSave(Object obj, Errors errors) {
        ReportWizard wiz = (ReportWizard)obj;
        if (wiz == null)
        {
           errors.reject("error.nullpointer", "Null data received");
        }
        else
        {
           if (wiz.getReportName() == null || wiz.getReportName() == ""){
              errors.reject("error.code", "Save Report: Report Name not entered.");
           }

           if (wiz.getReportPath() == null || wiz.getReportPath() == ""){
               errors.reject("error.code", "Save Report: Report save path not selected.");
           }
        }
    }

}

