Welcome to the project |project| !!!
===================================

@section{The Section Title}

r"""This is a raw docstring.  Backslashes (\) are not touched."""

- This is the first line of a bullet list
  item's paragraph.  All lines must align
  relative to the first line.

      This indented paragraph is interpreted
      as a block quote.

  Another paragraph belonging to the first list item.

 Because it is not sufficiently indented,
 this paragraph does not belong to the list
 item (it's a block quote following the list)..

Paragraphs contain text and may contain inline markup:
*emphasis*, **strong emphasis**, `interpreted text`, ``inline
literals``, standalone hyperlinks (https://www.python.org),
external hyperlinks (Python_), internal cross-references
(example_), footnote references ([1]_), citation references
([CIT2002]_), substitution references (|example|), and _`inline
internal targets`.

Paragraphs are separated by blank lines and are left-aligned.
[![GitHub Actions status][GitHub Actions SVG]][GitHub Actions]

|build-status| |docs| |coverage|

    """
    Keep data fresher longer.

    Extend `Storer`.  Class attribute `instances` keeps track
    of the number of `Keeper` objects instantiated.
    """

Purpose
-------

:project: will solve your problem of where to start with 
documentation on auto-installation of a ready-made server,
by providing a basic explanation of how to do it easily.

index.lst

full_subscr.lst
.. code-block bash::
   
   export LC_ALL=ru_RU.UTF-8;
   FILES="steps.txt";
   BUF="";
   TMPS="";
   COUNT=0;
   DEB_VER="";
   NET_EN="";
   NET_WI="";
   STATE="0";
   PORT_SSH="4103"
   NET_ARR=();
```
+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | Cells may span columns.          |
+------------------------+------------+---------------------+
| body row 3             | Cells may  | - Table cells       |
+------------------------+ span rows. | - contain           |
| body row 4             |            | - body elements.    |
+------------------------+------------+---------------------+

.. table:: Простая таблица
    =====  =====  =======
      A      B    A and B
    =====  =====  =======
    False  False  False
    True   False  False
    False  True   False
    True   True   True
    =====  =====  =======

`Online Sphinx Editor <https://livesphinx.herokuapp.com/>`_, `NoTex Editor <https://www.notex.ch/>`_, allowed edit and view code sphinx
 


Look how easy it is to use:

|    import project
|    # Get your stuff done

Features
--------

**22.05.2022**
- Add script `copy.py' for copy content from work directory in `git`
- Add script `extract_pii2.py' v.0.1a for autoextract commentary and code in page `cut_discr`
**15.05.2022**
- Add pages `cut_discr`, `full_discr`, `nav_r`, `build_doc`, `structurs`

Target
--------

- **15.05.2022**

- :strike:`Create and generate release v1.02a project`
- :del:`Study getting started and settings the sphinx`
-	Fill in the main part of the sections sections: `cut_discr`, `full_discr`, `nav_r`, `build_doc`, `structurs`
-	Organize auto-generation of code in the documentation in the `cut_discr` section, extracting text from script comments

Installation
------------

Install $project by running:

    install project

Contribute
----------

- Issue Tracker: github.com/$project/$project/issues
- Source Code: github.com/$project/$project

Support
-------

If you are having issues, please let us know.
We have a mailing list located at: asusclinstaller@ya.ru

Other [helping commands]
-------

|	git clone https://github.com/Rakosel/BilSrvStation_Server_PC.git
|	git add .
|	git commit -a
|	git push https://github.com/Rakosel/BilSrvStation_Server_PC.git master
(.venv) $ sphinx-build -b html docs/ docs/_build/

License
-------

$project © is Copyright 2011–2021 [:autor:](https://109.195.28.53),
2021–2022 [F@rid](mailto:asusclinstaller@ya.ru), and is
licensed under GNU GPL (v2+) license, the current version is available in
`LICENSE_GPL` file.
The project is licensed under the BSD license.

