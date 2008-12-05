from buildconf import *

import sys
import os
import shutil
import stat
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-o", "--output", dest="output",
                  help="output directory", default='./output')

(options, args) = parser.parse_args()


# create work, output directories
for dir in [options.output, './work', './work/templates', './work/htdocs']:
    if not os.path.exists(dir):
        os.makedirs(dir)

# semi generic directory copy function
def copydir(name, dest, htmlonly=False):
    for root, dirs, files in os.walk(name):
        relative = root[len(name + "/"):]
        if ".svn" in relative:
            continue

        for dir in dirs + ['.']:
            if ".svn" in dir:
                continue
            if not os.path.exists(os.path.join(dest, relative, dir)):
                os.makedirs(os.path.join(dest, relative, dir))

        for fname in files:
            if 'svn-' in fname:
                continue
            if htmlonly and not fname.endswith('.html'):
                continue
            conditional_copy(os.path.join(root, fname), os.path.join(dest, relative, fname))

def conditional_copy(f1, f2):
    if isnewer(f1, f2):
        print f1, "->", f2
        shutil.copyfile(f1, f2)

def isnewer(f1, f2):
    return not os.path.exists(f2) or os.stat(f1)[stat.ST_MTIME] > os.stat(f2)[stat.ST_MTIME]

# copy local files to work dir
copydir('./templates', 'work/templates')
copydir('./htdocs', 'work/htdocs')

# copy files from individual doc builds to work dir
for docs, prefix in STANDARD_DOCS:
    copydir(os.path.join(docs, 'build/templates'), os.path.join('work/templates/docs', prefix), True)
    copydir(os.path.join(docs, 'build/output'), os.path.join('work/htdocs/docs', prefix))
    for name in ['docs.css', 'docutil.css', 'scripts.js', 'style.css', 'alphaapi.html', 
                'alphaimplementation.html', 'syntaxhighlight.css', 'highlight.css']:
        if os.path.exists(os.path.join(docs, name)):
            conditional_copy(os.path.join(docs, name), os.path.join('work/htdocs/docs', prefix, name))

for docs, prefix in SPHINX_DOCS:
    copydir(docs, os.path.join('work/htdocs/docs', prefix))
    
from mako.lookup import TemplateLookup

lookup = TemplateLookup(directories=['./work/templates', './work/htdocs'], output_encoding='utf-8', cache_dir='./work/cache')

todo = './work/htdocs'
for root, dirs, files in os.walk(todo):
    relative = root[len(todo)+1:]
    if '.svn' in relative:
        continue
    
    for dir in dirs:
        if ".svn" in dir:
            continue
        if not os.path.exists(os.path.join(options.output, relative, dir)):
            os.makedirs(os.path.join(options.output, relative, dir))
            
    html = set([fname for fname in files if fname.endswith('.html')])
    nonhtml = set(files).difference(html)
    
    for fname in nonhtml:
        conditional_copy(os.path.join(root, fname), os.path.join(options.output, relative, fname))
    
    for fname in html:
        if isnewer(os.path.join(root, fname), os.path.join(options.output, relative, fname)):
            print os.path.join(relative, fname), "->", os.path.join(options.output, relative, fname)
            txt = lookup.get_template(os.path.join(relative, fname)).render(req={}, attributes={})
            outfile = file(os.path.join(options.output, relative, fname), 'w')
            outfile.write(txt)
            outfile.close()
