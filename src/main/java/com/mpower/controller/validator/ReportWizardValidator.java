package com.mpower.controller.validator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springmodules.validation.commons.PageAware;

import com.mpower.domain.ReportWizard;

public class ReportWizardValidator implements Validator {

    /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    private int page;
    
    public void setPage(int page){
    	this.page = page;
    }
    public int getPage(){
    	return this.page;
    }
 
    public ReportWizardValidator() {
    	page = 0;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public boolean supports(Class clazz) {
        return ReportWizard.class.equals(clazz);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        logger.debug("in ReportWizardValidator");
    }
}

