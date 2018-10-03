

def setup_context(context):
    # add variables if not present, such
    # as if local test of READTHEDOCS variable
    if 'MEDIA_URL' not in context:
        context['MEDIA_URL'] = ""
    if 'slug' not in context:
        context['slug'] = context['project'].lower()
    if 'url' not in context:
        context['url'] = "/some/test/url"
    if 'current_version' not in context:
        context['current_version'] = "latest"
    if 'html_theme' not in context:
        context['html_theme'] = ''

    if 'name' not in context:
        context['name'] = context['project'].lower()

    context['rtd'] = True
    context['toolbar'] = True
    context['base'] = "docs_adapter.mako"

    context['pdf_url'] = None
