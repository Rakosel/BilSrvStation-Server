# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html
# https://sphinx-ru.readthedocs.io/ru/latest/sphinx.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))
import sys, os
sys.path.insert(0, os.path.abspath('.'))
import sphinx_rtd_theme

# adding Folder_2 to the system path

#sys.path.insert(0, '/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC')
#import extract_pii2_all

#import django

#django.setup()
#sys.path.insert(0, pathlib.Path(__file__).parents[2].resolve().as_posix())
# General
#sys.path.insert(0, os.path.abspath('../..'))
exclude_patterns = ['zzz']

numfig = True

today = ''
today_fmt = '%B %d, %Y'

# -- Project information -----------------------------------------------------

project = 'BilSrvStation_Server_PC'
copyright = '2022, BiLymo iOT corp'
author = 'BiLymo F@rid'

# The full version, including alpha/beta/rc tags 
release = '1.0.2a'
# -- General configuration ---------------------------------------------------
verison = '1.0.2'
# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.extensions = ['myst_parser',
exclude_patterns = ["_build"]
# https://github.com/readthedocs/readthedocs.org/tree/main/docs

#os.environ.setdefault("DJANGO_SETTINGS_MODULE", "readthedocs.settings.dev")
# sys.path.append(os.path.abspath("_ext"))
extensions = [
#    'multiproject',
    'sphinx.ext.autosectionlabel',
    'sphinx.ext.autodoc',
    'sphinx.ext.intersphinx',
    'sphinx.ext.mathjax',
#    'sphinxnotes.strike',
#    'sphinx.ext.pngmath'
#    'sphinxcontrib.httpdomain',
#    'djangodocs',
#    'doc_extensions',
#    'sphinx_tabs.tabs',
#    'sphinx-prompt',
#    'notfound.extension',
#    'hoverxref.extension',
#    'sphinx_search.extension',
#    'sphinxemoji.sphinxemoji',
#    'myst_parser'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

man_pages = [
    (
        "index",
        "read-the-docs",
        "Read the Docs Documentation",
        ["Eric Holscher, Charlie Leifer, Bobby Grace"],
        1,
    )
]

hoverxref_intersphinx = [
    "sphinx",
    "pip",
    "nbsphinx",
    "myst-nb",
    "ipywidgets",
    "jupytext",
]

hoverxref_auto_ref = True
hoverxref_domains = ["py"]
hoverxref_roles = [
    "option",
    "doc",
]
hoverxref_role_types = {
    "mod": "modal",  # for Python Sphinx Domain
    "doc": "modal",  # for whole docs
    "class": "tooltip",  # for Python Sphinx Domain
    "ref": "tooltip",  # for hoverxref_auto_ref config
    "confval": "tooltip",  # for custom object
}

rst_epilog = """
.. |org_brand| replace:: Read the Docs Community
.. |com_brand| replace:: Read the Docs for Business
"""

# Activate autosectionlabel plugin
autosectionlabel_prefix_document = True

# sphinx-notfound-page
# https://github.com/readthedocs/sphinx-notfound-page
notfound_context = {
    "title": "Page Not Found",
    "body": """
<h1>Страница не найдена!</h1>
<p>Sorry, we couldn't find that page.</p>
<p>Try using the search box or go to the homepage.</p>
""",
}

# The encoding of source files.
#
# source_encoding = 'utf-8-sig'

# The master toctree document.
root_doc = 'index'

show_authors = True

#highlight_options = {
#  'default': {'stripall': True},
#  'php': {'startinline': True},
#}

# Set this option to True if you want all displayed math to be numbered. The default is False.
math_number_all = True

#Example: 'Eq.{number}' gets rendered as, for example, Eq.10.
math_eqref_format = 'eq.{number}'

#math_numfig

#A boolean that decides whether module names are prepended to all object names (for object types where a “module” of some kind is defined), e.g. for py:function directives. Default is True.

add_module_names = True

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = 'ru'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# The reST default role (used for this markup: `text`) to use for all
# documents.
#
# default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
#
# add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
#
# add_module_names = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
#
show_authors = True

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
# A list of ignored prefixes for module index sorting.
# modindex_common_prefix = []

# If true, keep warnings as "system message" paragraphs in the built documents.
# keep_warnings = False

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = True

html_theme = 'sphinx_rtd_theme'
#default
#sphinxdoc
#scrolls
#agogo
#traditional
#nature
#haiku
#pyramid

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}

# Add any paths that contain custom themes here, relative to this directory.
html_theme_path = ['.']

# The name for this set of Sphinx documents.
# "<project> v<release> documentation" by default.
#
#html_title = ''

# A shorter title for the navigation bar.  Default is the same as html_title.
#
# html_short_title = None

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
#
# html_logo = None

# The name of an image file (relative to this directory) to use as a favicon of
# the docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
# https://favicon.io/favicon-generator/
#
html_favicon = '_static/favicon.ico'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Add any extra paths that contain custom files (such as robots.txt or
# .htaccess) here, relative to this directory. These files are copied
# directly to the root of the documentation.
#
# html_extra_path = []

# If not None, a 'Last updated on:' timestamp is inserted at every page
# bottom, using the given strftime format.
# The empty string is equivalent to '%b %d, %Y'.
#
# html_last_updated_fmt = None

# Custom sidebar templates, maps document names to template names.
#
# html_sidebars = {}

# Additional templates that should be rendered to pages, maps page names to
# template names.
#
# html_additional_pages = {}


# If false, no module index is generated.
#
# html_domain_indices = True

# If false, no index is generated.
#
html_use_index = True

# If true, the index is split into individual pages for each letter.
#
# html_split_index = False

# If true, links to the reST sources are added to the pages.
#
# html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
#
html_show_sphinx = False

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
#
html_show_copyright = True

# This is the file name suffix for HTML files (e.g. ".xhtml").
# html_file_suffix = None


# A dictionary with options for the search language support, empty by default.
# 'ja' uses this config value.
# 'zh' user can custom change `jieba` dictionary path.
#
# html_search_options = {'type': 'default'}

# The name of a javascript file (relative to the configuration directory) that
# implements a search results scorer. If empty, the default will be used.
#
# html_search_scorer = 'scorer.js'

# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
#man_pages = [
#    (root_doc, 'test', u'test Documentation',
#     [author], 1)
#]

# If true, show URL addresses after external links.
#
# man_show_urls = False

extensions.append('sphinx.ext.todo')
extensions.append('sphinx.ext.autodoc')
#extensions.append('sphinx.ext.autosummary')
extensions.append('sphinx.ext.intersphinx')
#extensions.append('sphinx.ext.mathjax')
extensions.append('sphinx.ext.viewcode')
extensions.append('sphinx.ext.graphviz')
autosummary_generate = True
