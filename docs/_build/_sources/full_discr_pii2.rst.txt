|		Полное описание Сервера.
|	by |author|. Основаня идея заключается в том, что бы обеспечить документирвоание 
|	и программами. В начале описывается структура файлов для формирования загрузочного диска, далее следует полное
important
=========
	 important!!! Перед установкой обязательно ознакомится с данной страницей!!!

|	        Основные возможности
|	        - Сервер предварительно настроен предустановочным файлом '*preseed.cfg*'
|	        - Сервер защищён пакетом SELinux с настроенными политиками
|	        - Установленные все полезные утилиты, необходимые для удобного администрирования
|			Описание структуры сервера
|			Разбор основного файла `*pii2.sh*'
|	'*<name>=${<number>:-"<name>"}*'. Где `*<name>*` - название метки GOTO, <number> - номер метки. Т.е. переменной <name> присваивается структура из наименования
|	Данная функция `*jumpto*` принимает два аргумента '*$0*' и '*$1*', которые соответствуют имени файла и названия метки.
|		'*cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')*'. 
|	В документации в разделе '*6.4 Branching and Flow Control*' `SEDERE <https://www.gnu.org/software/sed/manual/sed.html>`_ указана адресация::
[addr]X
=======
/regexp/X
=========
|	``Addresses and regular expressions can be used as an if/then conditional: If [addr] matches the current pattern space, execute 
|	the d command: delete the line without printing it, and restart the program cycle immediately.``
|	Эта запись говорит о том, что в фигурных скобках каждая команда (оператор) выполняется последовательно, при условии, если выполняется предыдущая.
|	- `*:a*` метка
|	означает, что некандиционная ветвь, которая переходит на метку, пропуская или повторяя другую команду без возможности перезапуска и переходит на метку `X`
|	Эта команда пропускает строку
|	- `*grep -v*`	``Invert the sense of matching, to select non-matching lines.``. Инвертирует чувствительность совпадений
|	- `*eval*`

.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install python
	echo -e "y\n" | apt-get install python3
	echo -e "y\n" | apt-get install tmux;
	echo -e "y\n" | apt-get install net-tools
	echo -e "y\n" | apt-get install manpages-dev;
	echo -e "y\n" | apt-get install wpa_supplicant;
	echo -e "y\n" | apt-get install mc;
	echo -e "y\n" | apt-get install ncdu;


.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install netdata;
	echo -e "y\n" | apt-get install systat;
	echo -e "y\n" | apt-get install iftop;
	echo -e "y\n" | apt-get install htop;
	echo -e "y\n" | apt-get install sudo;
	echo -e "y\n" | apt-get install iptraf;
	echo -e "y\n" | apt-get install ntp
	systemctl enable ntp;
	systemctl enable start;
	sudo systemctl unmask samba;
	cp /install/etc/sudoers /etc/sudoers
	echo -e "y\n" | apt-get install nmon;
	echo -e "y\n" | apt-get install nmap;
	echo -e "y\n" | apt-get install safe-rm
	echo -e "y\n" | apt-get install aptitude


.. code-block:: bash
	:linenos:

	iptables –F
	echo -e "y\n" | apt-get install cifs-utils
	echo -e "y\n" | apt-get install samba
	echo -e "y\n" | apt-get install smbfs
	echo -e "y\n" | apt-get install whois
	echo -e "y\n" | apt-get install lsof
	echo -e "y\n" | apt-get install mkpasswd
	echo -e "y\n" | apt-get install wget
	echo -e "y\n" | apt-get install tree
	echo -e "y\n" | apt-get install autofs
	echo -e "y\n" | apt-get install gpg
	echo -e "y\n" | apt-get install rsync
	echo -e "y\n" | apt-get install ca-certificates
	echo -e "y\n" | apt-get install shared-mime-info
	echo -e "y\n" | apt-get install wget genisoimage xorriso isolinux
	echo -e "y\n" | apt-get install hddtemp lm-sensors
	echo -e "y\n" | apt-get install at
	echo -e "y\n" | apt-get install pip
	echo -e "y\n" | apt-get install xz-utils
	echo -e "y\n" | apt-get install curl
	echo -e "y\n" | apt-get install python3-sphinx
	echo -e "y\n" | sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
	echo -e "y\n" | sudo apt install -y python3-venv
	python3 -m venv env
	echo -e "y\n" | apt-get install python3-sphinx


.. code-block:: bash
	:linenos:

	pip install --upgrade myst-parser
	pip install sphinx-autodocgen
	pip install Pygments
	pip install sphinx-intl
	pip install lumache
	pip install django
	pip install django-docs
	pip install sphinxnotes-strike

Python String Comparison operators
----------------------------------
|	In python language, we can compare two strings such as identify whether the two strings are equivalent to each other 
|	used for this purpose below:

.. code-block:: bash
	:linenos:

	step_three:
	

|	==: This operator checks whether two strings are equal.
|	<: This operator checks whether the string on the left side is smaller than the string on the right side.
|	>: This operator checks whether the string on the left side is greater than the string on the right side.

.. code-block:: bash
	:linenos:

	shd=$(echo $line | sed 's/\//\\\//g')
	S1=$(blkid | sed -n -e "s/$shd:\s\(.*\).*/\1/p" | sed -n -e "s/.*UUID=\(.*\)\sB.*/\1/p" | sed 's/\"/\\"/g')
	TMPS=$(echo $line | sed -n -e "s/^\/dev\/\([a-z]*[0-9]\).*/\1/p")
	chown admin_share:technics -Rf "/mnt/$TMPS"
	semanage fcontext -a -t public_content_rw_t "/mnt/$TMPS(/.*)?"; 
	chcon -Rv -t public_content_rw_t "/mnt/$TMPS";
	setfacl -m u:admin:rwx,u:admin_share:rwx, pub_share:rwx -R "/mnt/$TMPS";
	setfacl -m g:admins:rw -R "/mnt/$TMPS";
	chmod go-rwx -R "/mnt/$TMPS";
	if [[ -n $S1 ]]; then
		sed -i -e "$ a UUID\=$S1	\/mnt\/$TMPS	ext4	defaults	0	2" /etc/fstab
	fi
	done < $filename
	sudo mount -a

