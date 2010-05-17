package com.mpower.dao;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportFieldGroup;

@Repository("reportFieldGroupDao")
public class JPAReportFieldGroupDao implements ReportFieldGroupDao {
	@PersistenceContext
	private EntityManager em;
	
	
	public ReportFieldGroup copy(ReportFieldGroup group) {
		return new ReportFieldGroup(group);
	}

	
	public void delete(ReportFieldGroup group) {
		em.remove(group);

	}

	
	public ReportFieldGroup findById(long Id) {
		return em.find(ReportFieldGroup.class,Id);
	}

	
	public List<ReportFieldGroup> getAll() {
		Query q = em
		.createQuery("SELECT reportdatafieldgroup from com.mpower.domain.ReportFieldGroup reportdatafieldgroup");
		List<ReportFieldGroup> lrdfg = q.getResultList();
		return lrdfg;
}

	
	public List<ReportFieldGroup> getAllByReportDataSubSourceId(Long id) {
		Query q = em.createQuery("select reportFieldGroup from ReportFieldGroup reportFieldGroup left join reportFieldGroup.reportDataSubSource as reportSubSource where reportSubSource.id = ?");

		q.setParameter(1, id);
		List<ReportFieldGroup> lrfg = q.getResultList();
		
		return lrfg;
	}

	
	public void save(ReportFieldGroup group) {
		if (group.getId() != null && em.find(ReportFieldGroup.class, group) != null) {
			em.merge(group);
			return;
		}
		em.persist(group);

	}

	
	public ReportFieldGroup update(ReportFieldGroup group) {
		em.merge(group);
		return null;
	}

}
