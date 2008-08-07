package com.mpower.test.dataprovider;

import java.util.HashMap;

import org.testng.annotations.DataProvider;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportFieldType;

public class ReportSourceDataProvider {
	@SuppressWarnings("unchecked")
	@DataProvider(name = "setupCreateReportSource")
	public static Object[][] setupCreateReportSource() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");
		HashMap<Long, ReportField> fields = new HashMap<Long, ReportField>();

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setIsDefault(true);
		rf1.setCanBeSummarized(false);
		rf1.setReportFieldGroup(rfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setIsDefault(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(rfg);
		
		rfg.setReportDataSubSource(rss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs } };
	}
	
	@SuppressWarnings("unchecked")
	@DataProvider(name = "setupCreateReportSubSource")
	public static Object[][] setupCreateReportSubSource() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");
		HashMap<Long, ReportField> fields = new HashMap<Long, ReportField>();

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setIsDefault(true);
		rf1.setCanBeSummarized(false);
		rf1.setReportFieldGroup(rfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setIsDefault(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(rfg);
		
		rfg.setReportDataSubSource(rss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs, rss } };
	}
	
	@DataProvider(name = "setupReportFieldGroup")
	public static Object[][] setupFieldGroup() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");
		HashMap<Long, ReportField> fields = new HashMap<Long, ReportField>();

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setIsDefault(true);
		rf1.setCanBeSummarized(false);
		rf1.setReportFieldGroup(rfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setIsDefault(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(rfg);
		
		rfg.setReportDataSubSource(rss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs, rss, rfg } };
	}
	
	@DataProvider(name = "setupReportField")
	public static Object[][] setupField() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");
		HashMap<Long, ReportField> fields = new HashMap<Long, ReportField>();

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setIsDefault(true);
		rf1.setCanBeSummarized(false);
		rf1.setReportFieldGroup(rfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setIsDefault(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(rfg);
		
		rfg.setReportDataSubSource(rss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs, rss, rfg, rf1 } };
	}
	
}
