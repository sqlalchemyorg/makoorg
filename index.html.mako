<%inherit file="root.mako"/>

<%namespace name="func" file="functions.mako" import="*"/>
<%def name="title()">
    welcome to Mako!
</%def>
<%
    # this is a hack to get the functions
    # from functions.mako
    # to be present in the
    # local namespace for usage in filter
    highlight_mako
    highlight_python
%>
<h1>Mako Templates for Python</h1>


<!-- test hiya ! -->

<p>Mako is a template library written in Python. It provides a
familiar, non-XML syntax which compiles into Python modules for
maximum performance. Mako's syntax and API borrows from the best
ideas of many others, including Django and Jinja2 templates, Cheetah,
Myghty, and Genshi. Conceptually, Mako is an embedded Python
(i.e. Python Server Page) language, which refines the familiar
ideas of componentized layout and inheritance to produce one of
the most straightforward and flexible models available, while
also maintaining close ties to Python calling and scoping
semantics.</p>
<p>Mako is used by the <a
href="http://www.python.org/">python.org
website</a>, as well as <a href="http://reddit.com">reddit.com</a> where it delivers over <a href="http://mashable.com/2011/02/02/reddit-surpasses-1-billion-monthly-pageviews/">one billion page views per month</a>.

It is the default template
language included with the <a
href="https://www.pylonsproject.org/">Pylons and Pyramid</a> web frameworks.
</p>
<h2>Nutshell:</h2>
<pre class="codesample"><%text filter="highlight_mako">
<%inherit file="base.html"/>
<%
    rows = [[v for v in range(0,10)] for row in range(0,10)]
%>
<table>
    % for row in rows:
        ${makerow(row)}
    % endfor
</table>

<%def name="makerow(row)">
    <tr>
    % for name in row:
        <td>${name}</td>\
    % endfor
    </tr>
</%def>
</%text></pre>

<h2>Philosophy:</h2>
<p>Python is a great scripting language.  Don't reinvent the wheel...your templates can handle it !</p>

<h2>Features:</h2>

<ul>
    <li>Super-simple API.  For basic usage, just one class, ${code('Template')} is needed:
    <pre class="codesample"><%text filter="highlight_python">from mako.template import Template
print Template("hello ${data}!").render(data="world")
    </%text></pre>
    For filesystem management and template caching, add the ${code('TemplateLookup')} class.
    </li>

    <li>
    Super fast. As templates are ultimately compiled into Python bytecode,
    Mako's approach is extremely efficient, and was originally written to be
    just as fast as Cheetah.  Today, Mako is very close in speed to
    Jinja2, which uses a similar approach and for which Mako was an inspiration.
    </li>
    <li>Standard template features
    <ul>
        <li>control structures constructed from real Python code (i.e. loops, conditionals)</li>
        <li>straight Python blocks, inline or at the module-level</li>
        <li>plain old includes</li>
    </ul></li>
    <li>Callable blocks
    <ul>
        <li>two types - the <%text><code><%def></code></%text> tag provides Python <code>def</code>
        semantics, whereas the <%text><code><%block></code></%text> tag behaves more like a
        Jinja2 content block.</li>
        <li>can access variables from their enclosing scope as well as the template's request context</li>
        <li>can be nested arbitrarily</li>
        <li>can specify regular Python argument signatures</li>
        <li>outer-level callable blocks can be called by other templates or controller code (i.e. "method call")</li>
        <li>Calls to functions can define any number of sub-blocks of content which are accessible to the called function This is the basis for nestable custom tags.</li>
    </ul>
    </li>
    <li>Inheritance
        <ul>
        <li>supports "multi-zoned" inheritance - define any number of areas in
        the base template to be overridden using <%text><code><%block></code></%text> or
        <%text><code><%def></code></%text>.</li>
        <li>supports "chaining" style inheritance - call <span class="code">next.body()</span> to call the "inner" content.</li>
        <li>the full inheritance hierarchy is navigable in both directions (i.e. parent and child) from anywhere in the chain.</li>
        <li>inheritance is dynamic!  Specify a function instead of a filename to calculate inheritance on the fly for every request.</li>
        </ul>
    </li>
    <li>Full-Featured
            <ul>
                <li>filters, such as URL escaping, HTML escaping.  Markupsafe is used for performant and secure HTML escaping, and new
                    filters can be constructed as a plain Python callable.</li>
                <li>complete caching system, allowing caching to be applied at the page level or individual block/def level.  The
                    caching system includes an open API that communicates with <a href="http://beaker.groovie.org">Beaker</a> and
                    soon <a href="https://bitbucket.org/zzzeek/dogpile.cache/">dogpile.cache</a>
                    by default, and new cache backends can be added with ease via setuptools entrypoints.</li>
                <li>Supports Python 2.4 through modern 3 versions.</li>
                <li>Supports Google App Engine.</li>
            </ul>
    </li>

</ul>
<div class="pylogo"><a href="http://www.python.org"><img src="/images/python-logo.gif"/></a></div>

<p>To get started, visit the <a href="/docs/">documentation</a>  and the <a href="/download.html">download page</a>.</p>

<p>Mako is covered by the <a href="http://www.opensource.org/licenses/mit-license.php">MIT License</a>.</p>
<div style="clear:both"/>
