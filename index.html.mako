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


<!-- test hiya ! 3 -->

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

<div class="pylogo"><a href="http://www.python.org"><img src="/images/python-logo.gif"/></a></div>

<p>To get started, visit the <a href="/docs/">documentation</a>  and the <a href="/download.html">download page</a>.</p>

<p>Mako is covered by the <a href="http://www.opensource.org/licenses/mit-license.php">MIT License</a>.</p>
<div style="clear:both"/>
