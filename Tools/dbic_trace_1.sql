SELECT me.id, me.idev, me.idinstitucion, me.portal, me.fechaini, me.fechafin, me.fechacreacion, me.url, me.estado, me.job, me.resultado, me.fallidas, me.validas FROM auditoria me WHERE ( me.id = ? ): '117'
SELECT me.jobid, me.path, me.name, me.pass, me.class, me.message FROM (SELECT j.id as jobid, path, name, pass, class, message FROM jobs j LEFT JOIN
urls u ON j.id = u.pid LEFT JOIN results re ON u.id = re.pid LEFT JOIN events
ev ON re.id = ev.pid WHERE j.id = ?) me: '138'
