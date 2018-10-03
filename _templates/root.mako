<%
in_docs = getattr(next.module, 'in_docs', False)

if in_docs:
    self.attr.site_base = site_base = zf.config.site_url
else:
    self.attr.site_base = site_base = ""

%>

<html>
<%def name="title()">
Mako Templates for Python
</%def>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<head>
<title>${self.title()} </title>

<%block name="headers"/>

${self.style()}

<%def name="style()">
	<link rel="stylesheet" href="/css/site.css"></link>
	<link rel="stylesheet" href="/css/highlight.css"></link>
</%def>

</head>
<body>
    <div id="wrap">
    <div class="rightbar">

    <div class="slogan">
    Hyperfast and lightweight templating for the Python platform.
    </div>

    <div class="toolbar">
    <a href="/">Home</a>
    &nbsp; | &nbsp;
    <a href="/community.html">Community</a>
    &nbsp; | &nbsp;
    <a href="http://docs.makotemplates.org">Documentation</a>
    &nbsp; | &nbsp;
    <a href="/download.html">Download</a>

    </div>


    </div>

    <a href="/"><img src="/images/makoLogo.png" /></a>

    <hr/>

    ${next.body()}
<div class="clearfix">
<hr/>
<div class="copyright">Website content copyright &copy; by Michael Bayer. All rights reserved.  Mako and its documentation are licensed under the MIT license.  mike(&)zzzcomputing.com</div>
</div>
</div>
</body>
</html>
