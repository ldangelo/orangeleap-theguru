package com.mpower.test;

import java.awt.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mpower.domain.ReportDataSource;
import com.mpower.service.ReportSourceService;
import com.mpower.test.BaseTest;
import com.mpower.test.dataprovider.ReportSourceDataProvider;

public class ReportSourceTest extends BaseTest {
	private EntityManagerFactory emf;
	private ReportSourceService reportSourceService;

	@BeforeClass
	public void setup() {
		emf = (EntityManagerFactory) applicationContext
				.getBean("entityManagerFactory");
		
		reportSourceService = (ReportSourceService) applicationContext
				.getBean("reportSourceService");

	}

	@Test(dataProvider = "setupCreateReportSource", dataProviderClass = ReportSourceDataProvider.class)
	public void createReportSources(ReportDataSource rs) {
		reportSourceService.save(rs);
	}

	@Test(dependsOnMethods = "createReportSources")
	public void listReportSource() {
		EntityManager em = emf.createEntityManager();

		java.util.List<ReportDataSource> lrs = reportSourceService.readSources();
		assert lrs.size() >= 1;
	}

	@Test(dependsOnMethods = "createReportSources")
	void findReportSource() {
		ReportDataSource rds = reportSourceService.find(1L);

		assert rds != null;
	}

	@Test
	public void emptyTest() {

	}
}
