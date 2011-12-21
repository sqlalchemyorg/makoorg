import os
import shutil
import stat
import re
import sys
# legacy docs lib
sys.path.insert(0, './_lib/')

from blogofile.cache import bf

import logging
# the -v -vv flags hardwired to 'blogofile.' - OK
log = logging.getLogger('blogofile.controllers.docs')

htdocs = "_work"
templates = "_templates/_work"

page_re = re.compile(r'<%page cache_type="file" cached="True"/>')
def remove_page_tags(text):
    return page_re.sub("", text)

def run():
    # blogofile isn't using any file_dir, so whack all those
    # unneeded cache tags from doc templates.
    bf.writer.template_lookup.template_args['preprocessor'] = remove_page_tags

    if not os.path.exists(htdocs):
        os.makedirs(htdocs)

    if not os.path.exists(templates):
        os.makedirs(templates)

    # sphinx docs...
    for docs, prefix in bf.config.docs.sphinx_docs:
        copydir(docs, os.path.join(htdocs, 'docs', prefix))

    for root, dirs, files in os.walk(htdocs):

        relative = root.split(os.sep, 1)
        if len(relative) > 1:
            relative = relative[1]
        else:
            relative = ''

        for dir in dirs:
            if not os.path.exists(os.path.join(bf.writer.output_dir, relative, dir)):
                os.makedirs(os.path.join(bf.writer.output_dir, relative, dir))

        html = set([fname for fname in files if fname.endswith('.html')])
        nonhtml = set(files).difference(html)

        # blogofile unconditionally blows away everything in _site.   So for now
        # we have to skip checking timestamps.
        for fname in nonhtml:
            conditional_copy(os.path.join(root, fname), os.path.join(bf.writer.output_dir, relative, fname))

        for fname in html:
            log.info("%s -> %s", os.path.join(root, fname), os.path.join(bf.writer.output_dir, relative, fname))
            bf.writer.materialize_template(os.path.join(root, fname), os.path.join(relative, fname), attrs={'req':{}, 'attributes':{}})

def copydir(name, dest, htmlonly=False):
    for root, dirs, files in os.walk(name):
        relative = root[len(name + "/"):]

        for dir in dirs + ['.']:
            if not os.path.exists(os.path.join(dest, relative, dir)):
                os.makedirs(os.path.join(dest, relative, dir))

        for fname in files:
            if htmlonly and not fname.endswith('.html'):
                continue
            conditional_copy(os.path.join(root, fname), os.path.join(dest, relative, fname))

def conditional_copy(f1, f2):
    if isnewer(f1, f2):
        log.info("%s -> %s", f1, f2)
        shutil.copyfile(f1, f2)

def isnewer(f1, f2):
    return not os.path.exists(f2) or os.stat(f1)[stat.ST_MTIME] > os.stat(f2)[stat.ST_MTIME]

