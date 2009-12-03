package com.mpower.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mpower.domain.ReportWizard;

@Repository("reportWizardDao")
public class JPAReportWizardDao implements ReportWizardDao {
	@PersistenceContext
	private EntityManager em;

	public ReportWizard find(Long id) {
		return em.find(ReportWizard.class,id);
	}

	public ReportWizard findByUri(String reportPath, String reportName) {
		if (!reportPath.startsWith("/"))
			reportPath = "/" + reportPath;
		Query q = em.createQuery("select reportwizard from ReportWizard reportwizard where reportwizard.reportPath = :reportPath and reportwizard.reportSaveAsName = :reportSaveAsName");
		q.setParameter("reportPath", reportPath);
		q.setParameter("reportSaveAsName", reportName);
		List<ReportWizard> reportWizardResultList = q.getResultList();
		if (reportWizardResultList.size() == 0)
			return null;
		else
			return reportWizardResultList.get(0);
	}

	public List<ReportWizard> findSegmentationsByReportDataSourceId(Long reportDataSourceId) {
		Query q = em.createQuery("select reportwizard from ReportWizard reportwizard where reportwizard.srcId = :reportDataSourceId and reportwizard.useReportAsSegmentation = true");

		q.setParameter("reportDataSourceId", reportDataSourceId);
		List<ReportWizard> reportWizardResultList = q.getResultList();

		return reportWizardResultList;
	}

	public List<ReportWizard> findSegmentationsBySegmentationTypeName(String segmentationTypeName) {
		return findSegmentationsBySegmentationTypeName(segmentationTypeName, 0, 0, null, null);
	}

	public List<ReportWizard> findSegmentationsBySegmentationTypeName(String segmentationTypeName, int startIndex, int resultCount, String sortField, String sortOrder) {
		String queryString = "select reportwizard from ReportWizard reportwizard, ReportSegmentationType reportSegmentationType where reportWizard.reportSegmentationTypeId = reportSegmentationType.id and reportSegmentationType.segmentationType = :segmentationTypeName and reportwizard.useReportAsSegmentation = true";
		if (sortField != null && sortField.length() > 0) {
			queryString += " order by reportWizard." + sortField;
			if (sortOrder != null && sortOrder.length() > 0) {
				queryString += " " + sortOrder;
			}
		}
		Query q = em.createQuery(queryString);
		if (startIndex > 0)
			q.setFirstResult(startIndex);
		if (resultCount > 0)
			q.setMaxResults(resultCount);
		q.setParameter("segmentationTypeName", segmentationTypeName);
		List<ReportWizard> reportWizardResultList = q.getResultList();

		return reportWizardResultList;
	}

	@Override
	public long getSegmentationCountBySegmentationTypeName(String segmentationTypeName) {
		String queryString = "select count(reportwizard.id) from ReportWizard reportwizard, ReportSegmentationType reportSegmentationType where reportWizard.reportSegmentationTypeId = reportSegmentationType.id and reportSegmentationType.segmentationType = :segmentationTypeName and reportwizard.useReportAsSegmentation = true";
		Query q = em.createQuery(queryString);
		q.setParameter("segmentationTypeName", segmentationTypeName);
		long result = Long.parseLong(q.getSingleResult().toString());
		return result;
	}

	public List<ReportWizard> findAllSegmentations() {
		Query q = em.createQuery("select reportwizard from ReportWizard reportwizard where reportwizard.useReportAsSegmentation = true");

		List<ReportWizard> reportWizardResultList = q.getResultList();

		return reportWizardResultList;
	}

	public List<ReportWizard> getAll() {
		Query q = em
		.createQuery("SELECT reportwizard from com.mpower.domain.ReportWizard reportwizard");
		return  q.getResultList();
	}


	public void save(ReportWizard wiz) {
/*		Iterator<ReportFieldGroup> it = wiz.getFieldGroups().iterator();
		while (it.hasNext()) {
			ReportFieldGroup fGroup = (ReportFieldGroup) it.next();
			em.merge(fGroup);
		}

		Iterator<ReportField> fieldIt = wiz.getFields().iterator();
		while( fieldIt.hasNext()) {
			ReportField f = (ReportField) fieldIt.next();
			em.merge(f);
		}
*/
		if (wiz.getId() != null)
			em.merge(wiz);
		else
			em.persist(wiz);
	}

	@Transactional
	public void updateSegmentationExecutionInformation(Long reportId, String lastRunByUserName, Date lastRunDate, int resultCount, long executionTime) {
	    ReportWizard wiz = em.find(ReportWizard.class, reportId);
	    wiz.setLastRunByUserName(lastRunByUserName);
	    wiz.setLastRunDateTime(lastRunDate);
	    wiz.setResultCount(resultCount);
	    wiz.setExecutionTime(executionTime);
	    em.merge(wiz);
	}
}
