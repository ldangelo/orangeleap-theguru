package com.mpower.test.dataprovider;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.SortedSet;

import org.testng.annotations.DataProvider;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportWizard;

public class ReportWizardDataProvider {
	@DataProvider(name = "setupCreateReportWizard")
	public static Object[][] setupCreateReportSource() {
		ReportWizard rw = new ReportWizard();
		ReportDataSource rs = new ReportDataSource();

		rw.setReportName("Leo's Test");

		ReportDataSubSource rss = new ReportDataSubSource();
		LinkedList<ReportDataSubSource> rssl = new LinkedList<ReportDataSubSource>();
		rssl.add(rss);

		rs.setName("People");

		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");
		SortedSet<ReportField> fields = (SortedSet<ReportField>) new HashSet<ReportField>();

		ReportField rf1 = new ReportField();
		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setIsDefault(true);
		rf1.setCanBeSummarized(false);
		fields.add(rf1);

		ReportField rf2 = new ReportField();
		rf2.setDisplayName("First Name");
		rf2.setColumnName("First_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setIsDefault(true);
		rf2.setCanBeSummarized(false);
		fields.add(rf1);

		rfg.setFields(fields);

		SortedSet<ReportFieldGroup> lrfg = (SortedSet<ReportFieldGroup>) new HashSet<ReportFieldGroup>();
		lrfg.add(rfg);
		rss.setFieldGroups(lrfg);
		rw.setReportDataSource(rs);
		return new Object[][] { new Object[] { rw } };
	}
}
