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
	
	@Override
	public ReportFieldGroup copy(ReportFieldGroup group) {
		return new ReportFieldGroup(group);
	}

	@Override
	public void delete(ReportFieldGroup group) {
		em.remove(group);

	}

	@Override
	public ReportFieldGroup findById(long Id) {
		return em.find(ReportFieldGroup.class,Id);
	}

	@Override
	public List<ReportFieldGroup> getAll() {
		Query q = em
		.createQuery("SELECT reportdatafieldgroup from com.mpower.domain.ReportFieldGroup reportdatafieldgroup");
		List<ReportFieldGroup> lrdfg = q.getResultList();
		return lrdfg;
}

	@Override
	public List<ReportFieldGroup> getAllByReportDataSubSourceId(Long id) {
		Query q = em.createQuery("SELECT reportdatafieldgroup from com.mpower.domain.ReportFieldGroup reportdatafieldgroup");
		return q.getResultList();
	}

	@Override
	public void save(ReportFieldGroup group) {
		em.persist(group);

	}

	@Override
	public ReportFieldGroup update(ReportFieldGroup group) {
		em.persist(group);
		return null;
	}

}
