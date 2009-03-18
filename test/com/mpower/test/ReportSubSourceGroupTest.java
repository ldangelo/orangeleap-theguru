package com.mpower.test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSourceGroup;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceGroupService;
import com.mpower.test.dataprovider.ReportSourceDataProvider;

public class ReportSubSourceGroupTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSubSourceGroupService reportSubSourceGroupService;
	private ReportSourceService    reportSourceService;

	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext
				.getBean("entityManagerFactory");
		
		reportSubSourceGroupService = (ReportSubSourceGroupService) applicationContext
				.getBean("reportSubSourceGroupService");
		reportSourceService = (ReportSourceService) applicationContext
		.getBean("reportSourceService");

	}

	@Test(dataProvider = "setupCreateReportSubSourceGroup", dataProviderClass = ReportSourceDataProvider.class)
	public void createReportSubSourceGroups(ReportDataSource rs, ReportDataSubSourceGroup rss) {
		reportSourceService.save(rs);
		reportSubSourceGroupService.save(rss);
	}

	@Test(dependsOnMethods = "createReportSubSourceGroups")
	public void listReportSubSourceGroup() {
	
		java.util.List<ReportDataSubSourceGroup> lrs = reportSubSourceGroupService.readSubSourceGroupsByReportSourceId(1L);
		assert lrs.size() >= 1;
	}

	@Test(dependsOnMethods = "createReportSubSourceGroups")
	void findReportSubSourceGroup() 
	{
		ReportDataSubSourceGroup rds = reportSubSourceGroupService.find(1L);

		assert rds != null;
	}
	
	@Test(dependsOnMethods = "createReportSubSourceGroups")
	void findReportSubSourceGroupBySourceId()
	{
		java.util.List<ReportDataSubSourceGroup> lrdss = reportSubSourceGroupService.readSubSourceGroupsByReportSourceId(1L);
	
		assert lrdss != null;
		
		ReportDataSubSourceGroup rdss = lrdss.get(0);
		assert rdss != null;
	}

}
