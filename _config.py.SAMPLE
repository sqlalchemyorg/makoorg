# This is a barren blogofile config file.
# See docs at http://www.blogofile.com/documentation
# for config options
# or run 'blogofile help init' to see more complete templates

docs = controllers.docs

docs.enabled = True

dev_root = '/Users/classic/dev'

docs.sphinx_docs = [
    (dev_root + '/mako/doc/build/output/site', ''),
]

site.url = "http://www.makotemplates.org"

filters.syntax_highlight.style= "manni"
filters.syntax_highlight.enabled = True

# blog
blog = controllers.blog
blog.enabled = True
blog.path = "/blog"

blog.name = "Your Blog's Name"

blog.description = "Your Blog's short description"

blog.timezone = "US/Eastern"

blog.post_default_filters = {
    "markdown": "markdown",
    "textile": "syntax_highlight, textile",
    "org": "syntax_highlight, org",
    "rst": "rst, syntax_highlight"
}

