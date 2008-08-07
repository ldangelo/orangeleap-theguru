package com.mpower.test;

import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.test.dataprovider.ReportSourceDataProvider;

public class ReportFieldGroupTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSubSourceService reportSubSourceService;
	private ReportSourceService    reportSourceService;
	private ReportFieldGroupService reportFieldGroupService;
	
	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext
				.getBean("entityManagerFactory");
		
		reportSubSourceService = (ReportSubSourceService) applicationContext
				.getBean("reportSubSourceService");
		reportSourceService = (ReportSourceService) applicationContext
		.getBean("reportSourceService");
		reportFieldGroupService = (ReportFieldGroupService) applicationContext.getBean("reportFieldGroupService");

	}

	@Test(dataProvider = "setupReportFieldGroup", dataProviderClass = ReportSourceDataProvider.class)
	public void createReportFieldGroup(ReportDataSource rs, ReportDataSubSource rss, ReportFieldGroup rfg) {
		reportSourceService.save(rs);
		reportSubSourceService.save(rss);
		reportFieldGroupService.save(rfg);
	}

	@Test(dependsOnMethods = "createReportFieldGroup")
	public void listReportFieldGroup() {
	
		java.util.List<ReportFieldGroup> lrfg = reportFieldGroupService.readFieldGroupBySubSourceId(1L);
		assert lrfg.size() >= 1;
	}

	@Test(dependsOnMethods = "createReportFieldGroup")
	void findReportFieldGroup() 
	{
		ReportFieldGroup rfg = reportFieldGroupService.find(1L);

		assert rfg != null;
	}

}
