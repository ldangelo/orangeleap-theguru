package com.mpower.dao;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportCustomFilterDefinition;
import com.mpower.domain.ReportFieldGroup;

@Repository("reportCustomFilterDefinitionDao")
public class JPAReportCustomFilterDefinitionDao implements ReportCustomFilterDefinitionDao {
	@PersistenceContext
	private EntityManager em;
		
	public void delete(ReportCustomFilterDefinition customFilter) {
		em.remove(customFilter);
	}
	
	public ReportCustomFilterDefinition findById(long Id) {
		return em.find(ReportCustomFilterDefinition.class,Id);
	}
	
	public List<ReportCustomFilterDefinition> getAll() {
		Query q = em
		.createQuery("SELECT reportCustomFilterDefinition from ReportCustomFilterDefinition reportCustomFilterDefinition");
		List<ReportCustomFilterDefinition> lrcfd = q.getResultList();
		return lrcfd;
	}
	
	public List<ReportCustomFilterDefinition> getAllByReportDataSubSourceId(Long id) {
		Query q = em.createQuery("select reportCustomFilterDefinition from ReportCustomFilterDefinition reportCustomFilterDefinition left join reportCustomFilterDefinition.reportDataSubSource as reportSubSource where reportSubSource.id = ?");

		q.setParameter(1, id);
		List<ReportCustomFilterDefinition> lrcfd = q.getResultList();
		
		return lrcfd;
	}

	public void save(ReportCustomFilterDefinition customFilter) {
		if (customFilter.getId() != null && em.find(ReportCustomFilterDefinition.class, customFilter) != null) {
			em.merge(customFilter);
			return;
		}
		em.persist(customFilter);
	}
	
	public ReportCustomFilterDefinition update(ReportCustomFilterDefinition customFilter) {
		em.merge(customFilter);
		return null;
	}

	@Override
	public ReportCustomFilterDefinition copy(ReportCustomFilterDefinition customFilter) {
		return new ReportCustomFilterDefinition(customFilter);
	}

}
