<%!
    in_docs = True
%><%

if in_docs:
    self.attr.site_base = site_base = zf.config.site_url
else:
    self.attr.site_base = site_base = ""
%>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>
        <%text>
        <%block name="head_title">
        Mako Templates for Python
        </%block>
        </%text>
    </title>

    <%text>

    <%!
        import sys
        if sys.version_info.major >= 3:
            from urllib.parse import urlparse
        else:
            import urlparse
    %>

    <%block name="css">
        <!-- begin iterate through SQLA css_files -->
        % for cssfile in self.attr.default_css_files:
            <link rel="stylesheet" href="${pathto(cssfile, 1)}" type="text/css" />
        % endfor
        <!-- end iterate through SQLA css_files -->

        <!-- begin iterate through sphinx environment local css_files -->
        % for cssfile in css_files:
            % if not cssfile.startswith("http"):
            <link rel="stylesheet" href="${pathto(cssfile, 1)}" type="text/css" />
            % endif
        % endfor
        <!-- end iterate through sphinx environment local css_files -->

        <link rel="stylesheet" type="text/css" media="all" href="${site_base}/css/site.css"/>
        <link rel="stylesheet" type="text/css" media="all" href="${site_base}/css/carbonads.css"/>


        <!-- begin iterate through sphinx environment remote css_files -->
        % for cssfile in css_files:
            % if cssfile.startswith("http"):
            <link rel="stylesheet" href="${pathto(cssfile, 1)}" type="text/css" />
            % endif
        % endfor
        <!-- end iterate through sphinx environment remote css_files -->
    </%block>


    <%block name="headers">


    <%
        ending = "/" if builder == "readthedocsdirhtml" else ".html"
        canonical_page = pagename + ending
    %>
    % if canonical_url:
        <%
            # make sure we're just on the base
            canonical_url_ = "%s://%s/" % (urlparse.urlparse(canonical_url)[0:2])

        %>
        % if single_version:
          <!--
          Single version, so link without a language or version
          http://docs.readthedocs.org/en/latest/canonical.html
          -->
          <link rel="canonical" href="${canonical_url_}${canonical_page.replace("index.html", "").replace("index/", "")}" />
        % else:
          <!--
          Always link to the latest version, as canonical.
          http://docs.readthedocs.org/en/latest/canonical.html
          -->
          <link rel="canonical" href="${canonical_url_}${rtd_language}/latest/${canonical_page.replace("index.html", "").replace("index/", "")}" />
        % endif
    % else:
        <link rel="canonical" href="http://docs.makotemplates.org/${rtd_language}/latest/${canonical_page.replace("index.html", "").replace("index/", "")}" />
    % endif

    <script type="text/javascript">
        var doc_version = "${current_version}";
        var doc_slug = "${slug}";
        var static_root = "${pathto('_static', 1)}"

        // copied from:
        // https://github.com/rtfd/readthedocs.org/commit/edbbb4c753454cf20c128d4eb2fef60d740debaa#diff-2f70e8d9361202bfe3f378d2ff2c510bR8
        var READTHEDOCS_DATA = {
            project: "${slug}",
            version: "${current_version}",
            page: "${pagename}",
            theme: "${html_theme}"
          };


    </script>
    <!-- end RTD <head> via SQLAlchemy adapter -->

    </%block>

    ## other blocks that zzzeeksphinx->static_base.mako calls
    <%def name="bannerad()">
        </%text><%include file="/bannerad.mako"/><%text>
    </%def>

    <%block name="footer"/>
    <%block name="lower_scripts"/>


    </%text>


</head>

<body>
    <div id="wrap">
    <div class="rightbar">

    <div class="slogan">
    Hyperfast and lightweight templating for the Python platform.
    </div>

    <div class="toolbar">
    <a href="${site_base}/">Home</a>
    &nbsp; | &nbsp;
    <a href="${site_base}/community.html">Community</a>
    &nbsp; | &nbsp;
    <a href="http://docs.makotemplates.org">Documentation</a>
    &nbsp; | &nbsp;
    <a href="${site_base}/download.html">Download</a>

    </div>


    </div>

    <a href="${site_base}/"><img src="${site_base}/images/makoLogo.png" /></a>

    <hr/>

    <%text>
    ${next.body()}
    </%text>

<div class="clearfix">
<hr/>
<div class="copyright">Website content copyright &copy; by Michael Bayer. All rights reserved.  Mako and its documentation are licensed under the MIT license.  mike(&)zzzcomputing.com</div>
</div>
</div>
</body>
</html>
