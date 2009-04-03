package com.mpower.dao;

import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transaction;

import org.springframework.stereotype.Repository;

import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
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

}
