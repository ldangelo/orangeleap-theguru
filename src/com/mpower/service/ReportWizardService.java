package com.mpower.service;

import com.mpower.domain.ReportWizard;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

public interface ReportWizardService  {
	public List<ReportWizard> getAll();
}
