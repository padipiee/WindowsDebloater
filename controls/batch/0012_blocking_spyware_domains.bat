echo.
echo Blocking spyware domains...
set spy_domains=^
	nullroute,^
	statsfe2.update.microsoft.com.akadns.net,fe2.update.microsoft.com.akadns.net,^
	survey.watson.microsoft.com,watson.microsoft.com,^
	watson.ppe.telemetry.microsoft.com,vortex.data.microsoft.com,^
	vortex-win.data.microsoft.com,telecommand.telemetry.microsoft.com,^
	telecommand.telemetry.microsoft.com.nsatc.net,oca.telemetry.microsoft.com,^
	sqm.telemetry.microsoft.com,sqm.telemetry.microsoft.com.nsatc.net,^
	watson.telemetry.microsoft.com,watson.telemetry.microsoft.com.nsatc.net,^
	redir.metaservices.microsoft.com,choice.microsoft.com,^
	choice.microsoft.com.nsatc.net,wes.df.telemetry.microsoft.com,^
	services.wes.df.telemetry.microsoft.com,sqm.df.telemetry.microsoft.com,^
	telemetry.microsoft.com,telemetry.appex.bing.net,telemetry.urs.microsoft.com,^
	settings-sandbox.data.microsoft.com,watson.live.com,statsfe2.ws.microsoft.com,^
	corpext.msitadfs.glbdns2.microsoft.com,www.windowssearch.com,ssw.live.com,^
	sls.update.microsoft.com.akadns.net,i1.services.social.microsoft.com,^
	diagnostics.support.microsoft.com,corp.sts.microsoft.com,^
	statsfe1.ws.microsoft.com,feedback.windows.com,feedback.microsoft-hohm.com,^
	feedback.search.microsoft.com,rad.msn.com,preview.msn.com,^
	df.telemetry.microsoft.com,reports.wes.df.telemetry.microsoft.com,^
	vortex-sandbox.data.microsoft.com,settings.data.microsoft.com,^
	oca.telemetry.microsoft.com.nsatc.net,pre.footprintpredict.com,^
	spynet2.microsoft.com,spynetalt.microsoft.com,win10.ipv6.microsoft.com,^
	fe3.delivery.dsp.mp.microsoft.com.nsatc.net,cache.datamart.windows.com,^
	db3wns2011111.wns.windows.com,settings-win.data.microsoft.com,^
	v10.vortex-win.data.microsoft.com,apps.skype.com,^
	g.msn.com,bat.r.msn.com,client-s.gateway.messenger.live.com,^
	arc.msn.com,rpt.msn.com,bn1303.settings.live.net,client.wns.windows.com,^
	ieonlinews.microsoft.com,inprod.support.services.microsoft.com,^
	geover-prod.do.dsp.mp.microsoft.com,geo-prod.do.dsp.mp.microsoft.com,^
	kv201-prod.do.dsp.mp.microsoft.com,cp201-prod.do.dsp.mp.microsoft.com,^
	disc201-prod.do.dsp.mp.microsoft.com,array201-prod.do.dsp.mp.microsoft.com,^
	array202-prod.do.dsp.mp.microsoft.com,array203-prod.do.dsp.mp.microsoft.com,^
	array204-prod.do.dsp.mp.microsoft.com,tsfe.trafficshaping.dsp.mp.microsoft.com,^
	dl.delivery.mp.microsoft.com,tlu.dl.delivery.mp.microsoft.com,^
	statsfe1-df.ws.microsoft.com,statsfe2-df.ws.microsoft.com,^
	public-family.api.account.microsoft.com,dub407-m.hotmail.com,^
	www.bing.com,c.bing.com,g.bing.com,appex.bing.com,^
	urs.microsoft.com,c.urs.microsoft.com,t.urs.microsoft.com,activity.windows.com,^
	uif.microsoft.com,iecvlist.microsoft.com,ieonline.microsoft.com,c.microsoft.com,^
	nexus.officeapps.live.com,nexusrules.officeapps.live.com,c1.microsoft.com,^
	c.s-microsoft.com,apprep.smartscreen.microsoft.com,otf.msn.com,c.msn.com,^
	rr.office.microsoft.com,web.vortex.data.microsoft.com,ocsa.office.microsoft.com,^
	ocos-office365-s2s.msedge.net,odc.officeapps.live.com,uci.officeapps.live.com,^
	roaming.officeapps.live.com,urs.smartscreen.microsoft.com
set hosts=%SystemRoot%\System32\drivers\etc\hosts
for %%i in (%spy_domains%) do (
	find /c " %%i" %hosts% > nul
	if errorlevel 1 (
		echo %%i
		echo 0.0.0.0 %%i>>%hosts%
		set hosts_added=1
	)
)
if not defined hosts_added (
	echo Spyware domains already blocked.
) else (
	echo.
	echo | set /p=Flushing DNS cache 
	ipconfig /flushdns > nul
	echo [OK]
)