<%!
    import pygments
    from pygments.formatters import HtmlFormatter
    from pygments.lexers import PythonLexer, HtmlLexer
    from mako.ext.pygmentplugin import MakoLexer
%>

<%def name="code(text)" filter="trim">
	<span class="code">${text}</span>
</%def>

<%def name="highlight_mako(text)" filter="trim">
    <%
        return pygments.highlight(text.strip(), MakoLexer(), HtmlFormatter(nowrap=True))
    %>

</%def>

<%def name="highlight_python(text)" filter="trim">
    <%
        return pygments.highlight(text.strip(), PythonLexer(), HtmlFormatter(nowrap=True))
    %>

</%def>



