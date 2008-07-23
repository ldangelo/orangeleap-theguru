package com.mpower.test;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportWizardService;
import com.mpower.test.dataprovider.ReportWizardDataProvider;

public class ReportWizardTest extends BaseTest
{

	private EntityManagerFactory emf;
	private ReportWizardService  reportWizardService;
	
	
	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext.getBean("entityManagerFactory");
//	    personService = (PersonService) applicationContext.getBean("personService");
        reportWizardService = (ReportWizardService) applicationContext.getBean("reportWizardService");

    }

	 @Test (dataProvider = "setupCreateReportWizard", dataProviderClass = ReportWizardDataProvider.class)
	    public void listReportSource(ReportWizard rs) {
	        EntityManager em = emf.createEntityManager();
	        
	        List<ReportWizard> lrw = reportWizardService.getAll();
	        
	        assert lrw.size() == 0;
	    }


}
