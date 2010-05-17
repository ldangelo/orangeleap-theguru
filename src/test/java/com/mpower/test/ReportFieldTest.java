package com.mpower.test;

import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.test.dataprovider.ReportSourceDataProvider;

public class ReportFieldTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSubSourceService reportSubSourceService;
	private ReportSourceService    reportSourceService;
	private ReportFieldGroupService reportFieldGroupService;
	private ReportFieldService  reportFieldService;
	
	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext
				.getBean("entityManagerFactory");
		
		reportSubSourceService = (ReportSubSourceService) applicationContext
				.getBean("reportSubSourceService");
		reportSourceService = (ReportSourceService) applicationContext
		.getBean("reportSourceService");
		reportFieldGroupService = (ReportFieldGroupService) applicationContext.getBean("reportFieldGroupService");
		reportFieldService = (ReportFieldService) applicationContext.getBean("reportFieldService");
	}

	@Test(dataProvider = "setupReportField", dataProviderClass = ReportSourceDataProvider.class)
	public void createReportField(ReportDataSource rs, ReportDataSubSource rss, ReportFieldGroup rfg, ReportField rf) {
		reportSourceService.save(rs);
		reportSubSourceService.save(rss);
		reportFieldGroupService.save(rfg);
		reportFieldService.save(rf);
	}

	@Test(dependsOnMethods = "createReportField")
	public void listReportField() {
	
		java.util.List<ReportField> lrfg = reportFieldService.readFieldByGroupId(1L);
		assert lrfg.size() >= 1;
	}

	@Test(dependsOnMethods = "createReportField")
	void findReportField() 
	{
		ReportField rf = reportFieldService.find(1L);

		assert rf != null;
	}

}
