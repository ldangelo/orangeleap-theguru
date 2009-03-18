package com.mpower.test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.test.dataprovider.ReportSourceDataProvider;

public class ReportSubSourceTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSubSourceService reportSubSourceService;
	private ReportSourceService    reportSourceService;

	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext
				.getBean("entityManagerFactory");
		
		reportSubSourceService = (ReportSubSourceService) applicationContext
				.getBean("reportSubSourceService");
		reportSourceService = (ReportSourceService) applicationContext
		.getBean("reportSourceService");

	}

	@Test(dataProvider = "setupCreateReportSubSource", dataProviderClass = ReportSourceDataProvider.class)
	public void createReportSubSources(ReportDataSource rs, ReportDataSubSource rss) {
		reportSourceService.save(rs);
		reportSubSourceService.save(rss);
	}

	@Test(dependsOnMethods = "createReportSubSources")
	public void listReportSubSource() {
	
		java.util.List<ReportDataSubSource> lrs = reportSubSourceService.readSubSourcesByReportSubSourceGroupId(1L);
		assert lrs.size() >= 1;
	}

	@Test(dependsOnMethods = "createReportSubSources")
	void findReportSubSource() 
	{
		ReportDataSubSource rds = reportSubSourceService.find(1L);

		assert rds != null;
	}
	
	@Test(dependsOnMethods = "createReportSubSources")
	void findReportSubSourceBySourceId()
	{
		java.util.List<ReportDataSubSource> lrdss = reportSubSourceService.readSubSourcesByReportSubSourceGroupId(1L);
	
		assert lrdss != null;
		
		ReportDataSubSource rdss = lrdss.get(0);
		assert rdss != null;
	}

}
