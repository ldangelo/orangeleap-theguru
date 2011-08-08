UPDATE JIFileResource, JIResource
SET JIFileResource.data = REPLACE(JIFileResource.data, 'pattern="dd/MM/yyyy"', 'pattern="MMMMM dd, yyyy"')
WHERE JIResource.id = JIFileResource.id
AND JIResource.name IN ('mpower_template_jrxml', 'mpower_template_landscape_jrxml')
AND file_type = 'jrxml'
AND data like '%pattern="dd/MM/yyyy"%';