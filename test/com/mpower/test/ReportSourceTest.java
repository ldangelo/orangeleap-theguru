package com.mpower.test;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.service.ReportSourceService;
import com.mpower.test.dataprovider.ReportSourceDataProvider;


public class ReportSourceTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSourceService  reportSourceService;
	
	
	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext.getBean("entityManagerFactory");
//	    personService = (PersonService) applicationContext.getBean("personService");
        reportSourceService = (ReportSourceService) applicationContext.getBean("reportSourceService");

    }

	 @Test (dataProvider = "setupCreateReportSource", dataProviderClass = ReportSourceDataProvider.class)
	 public void createReportSources(ReportDataSource rs) {
		 reportSourceService.save(rs);
	 }

	 @Test
	 public void listReportSource() {
		 EntityManager em = emf.createEntityManager();
	        
		 List<ReportDataSource> lrs = reportSourceService.readSources();
		 assert lrs.size() == 1;
	 }

	@Test void findReportSource() {
		ReportDataSource rds = reportSourceService.find(1L);
		
		assert rds != null;
	}

	@Test
	public void emptyTest() {
		
	}
}
