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
	
	@Override
	public ReportWizard find(Long id) {
		return em.find(ReportWizard.class,id);
	}

	@Override
	public List<ReportWizard> getAll() {
		Query q = em
		.createQuery("SELECT reportwizard from com.mpower.domain.ReportWizard reportwizard");
		return  q.getResultList();
	}

	@Override
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
		em.persist(wiz);

		
	}

}
