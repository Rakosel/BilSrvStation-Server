bash
******

-xv
set -x
 https://wiki.debian.org/Microcode
 uncomment 639!!!!
if [[ -z $STATE ]]; then
	exit 3;
fi
 user add 
 echo "vkd174asqd" | mkpasswd -s -H MD5
 sudo usermod -p $(echo "" | mkpasswd -s -H MD5) test1
 sudo usermod -p $S test1
 su -p test1



1	AUTO POSTINSTALL
==================
 octanovilca na SSL + po4initb script cmd
 danger!!! do postinstall copy wufu & wpa_supplicant.conf + SAMBA

	1.1	PRE-INSTALL EMV AND SETTINGS
--------------------------------

d-i preseed/late_command string mkdir -p /target/install/; cp -R /install/* /target/install/; cp -Rf /install/lib/ /target/lib/;

cd /install/
tar -xvf wpa_supplicant-0.7.3.tar.gz
cd ./wpa_supplicant-0.7.3/
./configure
./install


 include this boilerplate

	https://stackoverflow.com/questions/9639103/is-there-a-goto-statement-in-bash
	 GOTO for bash, based upon https://stackoverflow.com/a/31269848/5353461

 rm /install/pii2.sh /etc/init.d/
update-rc.d -f pii2.sh remove

<--code
.. code-block:: bash
	function jumpto
	{
	label=$1
	cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
	eval "$cmd"
	exit
	}
	function reinterfaces
	{
	cd /etc/network/
--code>


if [[ -n $( egrep -n '^[a-z] || ^' interfaces) && TMPS=="0" ]]; then

.. code-block:: bash
	BUF="# This file describes the network interfaces available on your system\n
		# and how to activate them. For more information, see interfaces(5).\n
		\n
		source /etc/network/interfaces.d/*\n
		\n
		# The loopback network interface\n
		auto lo\n
		iface lo inet loopback\n
		\n
		# The Primary\n
		allow-hotplug en\n
		iface en inet dhcp\n";
	rm interfaces
	touch interfaces
	echo -e $BUF > interfaces;
	}
	
	start=${1:-"start"}
	interface_sh=${2:-"interface_sh"}
	step_one=${3:-"step_one"}
	step_two=${4:-"step_two"}
	step_three=${5:-"step_three"}

 		+ install wpa_supplicant-0.7.3.tar.gz

.. code-block:: bash
	export LC_ALL=ru_RU.UTF-8
	FILES="steps.txt"
	BUF="";
	TMPS="";
	COUNT=0;
	DEB_VER="";
	NET_EN="";
	NET_WI="";
	STATE="0";
	PORT_SSH="4103"
	NET_ARR=();

	1.2	CHECK ROOT PRIVILEGE
------------------------

.. code-block:: bash
	
	if [[ $EUID -ne 0 ]]; then
		if [[ ${LANG:0:5} -eq 'ru_RU' ]]; then
			echo "Ошибка скрипта перезапустите скрипт на root" 1>&2
		else
			echo "This script must be run as root" 1>&2
		fi
		exit 1;
	fi
	
	if [[ ! -f "$FILES" ]]; then
		touch steps.txt
	fi	

https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"

.. code-block:: bash
	select opt in Auto PoluAuto Hands Exit; do
	case $opt in
	Auto)
			echo -n "Сейчас будет произведена автоматическая найстройка ";
			sleep 3;
			jumpto start
	;;
		Polstart)
			echo -n "В разработке...";
	;;
	Hands)
			echo -n "В разработке...";
	;;
	Exit)
	exit 1;
	;;
	*) 
	echo "Недопустимая опция $REPLY";
	;;
	esac
	done

.. code-block:: bash
	
	jumpto $start
	
	start:
	

  Проверка отдельных переменных окружения.
  Если переменная, к примеру $USER, не установлена,
+ то выводится сообщение об ошибке.

.. code-block:: bash
	: ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
	echo
	echo "Имя машины: $HOSTNAME."
	echo "Ваше имя: $USER."
	echo "Ваш домашний каталог: $HOME."
	echo "Ваш почтовый ящик: $MAIL."
	echo
	echo "Если перед Вами появилось это сообщение,"
	echo "то это значит, что все критические переменные окружения установлены."
	echo 
	echo "Сейчас будет установлена postinstall настройка"
	echo
	
	cd /etc/apt/
	cp sources.list sources.tmp

 &VERSION_DEBIAN -e mojno off
lsb_release -d | sed -n -e 's/.*(\([^\)]\+\))/\1/p'
 egrep '^[a-z]' sources.list
 sed -i 's/deb-src http/deb-src http/g' sources.list
 sed -i 's/deb http/deb http/g' sources.list
 	algoritm: 
	a.0 search deb, deb-src 
???	bash buffer
lsb_release -d | sed -n 's/.*\([^\)]\)//p'
	if then yes ???
	next
	else 
	poist deb, deb-src naub,security, updates
	if yes ???, to ubrat 
	else
	version + add deb-src, deb http:// ... + non-free
	a.1 search 'contrib /|\ non-free' >> test
	a.2 if test = 0 ? then 
	??? nado grep posi, a potom replace with check codename:
	lsb_version -da
	a.3 else ok

	1.3	SETTINGS /ETC/NETWORK -> INTERFACES [interface_sh]
------------------------------------------------------

.. code-block:: bash
	TMPS="0";
	interface_sh:
	
	cd /install/
	if [[ -z $(sed -n -e "s/^\(1_settings_interface_with_wifi\).*/\1/p" steps.txt) ]]; then

		1.3.1	SETTINGS NETWORK/INTERFACES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. code-block:: bash
	cd /etc/network/

		1.3.2	SEARCH INTERFACES 
~~~~~~~~~~~~~~~~~~~~~~~~

	2:	number  

.. code-block:: bash
	if [[ ! -f /etc/network/interfaces ]]; then
		touch interfaces
	fi

.. code-block:: bash
	cp interfaces interfaces.back 

 t.k while 1 step s.b. str !0

.. code-block:: bash
	COUNT=1;
	NET_EN=""
	
	while [[ -n $( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p") ]]
	do
	NET_ARR[COUNT]=$( ip addr | sed -n -e "s/.*$COUNT\:\s\(.*\)\:\s<.*/\1/p");
	echo Counter: $COUNT $NET_EN;
	((COUNT++));
	done
	
	COUNT=0;

search index arr for WIFI[COUNT] and NETEN[COUNT]

.. code-block:: bash
	for COUNT in ${NET_ARR[@]}
	do
		if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/en\(.*\).*/\1/p') ]]; then
			NET_EN=$COUNT;
		fi
		if [[ -n $(echo $NET_ARR[$COUNT] | sed -n -e 's/wl\(.*\).*/\1/p') ]]; then
			NET_WI=$COUNT;
		fi
	done
	
	COUNT="0";
	
	if [[ -n $NET_EN && -n $NET_WI ]]; then
		STATE="0";
	elif [[ -n $NET_EN ]]; then
		STATE="1";
	else 
		echo "Error: not search lan interfaces";
		sleep 1;
		exit 2;
	fi;

 state => "1" add interfaces only en_*!!!
 state => "0" all ok
 interfaces.back - zamenit bez .back

 proverka interfaces

	Jump to label interface_sh

.. code-block:: bash
	if [[ -z $( egrep -n '^[a-z] || ^#' interfaces) && $TMPS -eq "0" ]]; then
	reinterfaces
	fi

 cat interfaces.back
 analys set en wifi to two branch
 create interfaces.tmp c orig
 empty? yes - add svoi, else search 'source' 'allow' 'iface' +append_wpa
 search source and return number line $begin
BEGIN="0"
END="0";
		mojet nay4itca kak udalit ostalnye stroki?
 https://www.baeldung.com/linux/bash-count-lines-in-file
 sed -r -e '/[a-z]\/+{1,}\*/=' < interfaces.back
 sed -r -e '/.*\/+\{1,\}/ { =;  q; }' < interfaces.back
 echo -e "abc\n\rta\n123456789" | sed -r -e '/.*[0-9]/{1,/}/'
 sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back

	-1

 https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html
 str /sources/
COUNT=$(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces.back | sed -n '$=')-1));
if [[ $(($( sed -r -e '/[a-z]\/+{1,}\*/{=;q;}' interfaces | sed -n '$=')-1)) == "0" ]]; then
.. code-block:: bash
	
if [[ $(sed -n -e "$=;" interfaces) == "0" ]]; then
		TMPS="1";
		jumpto interface_sh;
fi

.. code-block:: bash
	TMPS="1";

sed -n -e "s/rsa_cert_file=.*$\|rsa_cert_file=.*$/rsa_cert_file=\/ssl\/certs\/vsftpd.crt/p" vsftpd.conf

.. code-block:: bash
	if [[ $STATE -eq "0" ]]; then

source /etc/network/interfaces.d/*\n
 str auto $( sed -n -e "s/\(auto\s\).*/\1$NET_ARR[$NET_WI]\s$NET_ARR[$NET_EN]/p"

.. code-block:: bash
	if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	
	if [[ -z $(sed -n -e "s/\(auto\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(auto\s\).*/\1$NET_WI $NET_EN/g" interfaces

 str iface NET_EN

.. code-block:: bash
	if [[ -z $( sed -n -e "s/\(iface\slo\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi

TMPS=$(sed -n -e "/\(iface\slo\).*/{=;q;}" interfaces)
sed -i -e "$TMPS s/\(iface\s\).*/\1$NET_EN inet dhcp/g" interfaces

.. code-block:: bash
	sed -i -e "s/iface\slo.*/iface $NET_EN inet dhcp/g" interfaces

 str allow-hotplug

.. code-block:: bash
	if [[ -z $( sed -n -e "s/\(allow-hotplug\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi
	sed -i -e "s/\(allow-hotplug\s\).*/\1$NET_WI/g" interfaces

 str iface NET_WI

.. code-block:: bash
	if [[ -z $( sed -n -e "s/\(iface\s\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi

 str auto
TMPS=$(sed -n -e "/\(iface\s[en]\).*/{=;q;}" interfaces)

.. code-block:: bash
	sed -i -e "$a s/\(iface\s\).*/\1$NET_WI inet dhcp/g" interfaces

sed -n -e "s/\(iface\s[en]\).*/\1$NET_ARR[$NET_WI] inet dhcp/g" interfaces

.. code-block:: bash
	sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;

if [[-z $( sed -n -e "s/\(auto\s\).*/\1/p" interfaces) ]]; then
	jumpto interface_sh;
fi
systemctl restart wpa_supplicant@$NET_ARR[$NET_WI]

.. code-block:: bash
	systemctl restart wpa_supplicant



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

