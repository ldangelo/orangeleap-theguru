package com.mpower.dao;

import java.util.List;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericValidator;
import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportWizard;

@Repository("reportWizardDao")
public class JPAReportWizardDao implements ReportWizardDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	public void Save(ReportWizard wizard) {
		em.persist(wizard);

	}

	@Override
	public void delete(ReportWizard wizard) {
		em.remove(wizard);

	}

	@Override
	public ReportWizard findById(long Id) {
		// TODO Auto-generated method stub
		return em.find(ReportWizard.class, Id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReportWizard> getAll() {
		Query q = em.createQuery("SELECT reportwizard from com.mpower.domain.ReportWizard reportwizard");
		return q.getResultList();

	}

	@Override
	public ReportWizard update(ReportWizard wizard) {
		return em.merge(wizard);
	}

}
