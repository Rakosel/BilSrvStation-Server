Полное описание сервера
=======================
|	    Данная статья рассматривает полное описание автономного сервера *BilSrvStation* на *Linux
|	Debian10* by |author|. Основаня идея заключается в том, что бы обеспечить документирование реального сервера/рабочего места, после "чистой", автоматической установки со всеми необходимыми настройками и программами. В начале описывается структура файлов для формирования загрузочного диска, далее следует полное
|	описание скриптового **pii2.sh** без 
.. important:: Перед установкой обязательно ознакомится с данной страницей!!!

.. attention:: Здесь и далее, дополнительный софт будет дополняться в файле pii2.sh, в разделе `01.12	Optional soft`, при этом описание будет дополняться в данной странице в разделе 'Опциональный софт`

|	        Основные возможности
|	        - Сервер предварительно настроен предустановочным файлом '*preseed.cfg*'
|	        - Не требуется вручную настраивать и конфигурировать пакеты
|	        - Сервер защищён пакетом SELinux с настроенными политиками
|	        - Локаничное описание, позволяющее сэкономить время на освоение
|	        - Установленные все полезные утилиты, необходимые для удобного администрирования
|	        - Данная установка универсальная для широкого спектра задач
Описание структуры сервера
--------------------------
|	Структура сервера состоит из следующих папок и файлов.
Разбор основного файла pii2.sh
------------------------------
|	    Код начинается с функции `*jumpto*`, которая обеспечивает переход по меткам '*GOTO*'. В роли метки служит её объявление
|	'*<name>=${<number>:-"<name>"}*'. Где `*<name>*` - название метки GOTO, <number> - номер метки. Т.е. переменной <name> присваивается структура из наименования
|	метки с соответствующему номеру. После объявление метки в коде она используется '*<number>:*', а её вызов осуществляется через '*jumpto $<name>*'.
|	Данная функция `*jumpto*` принимает два аргумента `*$0*` и `*$1*`, которые соответствуют имени файла и названия метки.
|	Рассмотрим строчку функции::
|		`*cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')*`. 
|	В документации в разделе '*6.4 Branching and Flow Control*' `SEDERE <https://www.gnu.org/software/sed/manual/sed.html>`_ указана адресация::
|		`[addr]X`
|		`[addr]{ X ; X ; X }`
|		`/regexp/X`
|		`/regexp/{ X ; X ; X }`
|	``Addresses and regular expressions can be used as an if/then conditional: If [addr] matches the current pattern space, execute 
|	the command(s). For example: The command /^#/d means: if the current pattern matches the regular expression ^# (a line starting with a hash), then execute 
|	the d command: delete the line without printing it, and restart the program cycle immediately.``
|	Эта запись говорит о том, что в фигурных скобках каждая команда (оператор) выполняется последовательно, при условии, если выполняется предыдущая.
|	Краткое описание опреторов:
|	- `*:a*` метка
|	- `*-bX*`  ``branch unconditionally (that is: always jump to a label, skipping or repeating other commands, without restarting a new cycle).``. Это
|	означает, что некандиционная ветвь, которая переходит на метку, пропуская или повторяя другую команду без возможности перезапуска и переходит на метку `X`
|	- `*-n*`   ``commands first prints the content of the pattern space, empties the pattern space then reads the next input line. This command is useful to skip lines (e.g. process every Nth line).``
|	Эта команда пропускает строку
|	- `*-Xp*`   команда вывода строки Xp. Где X - омер строки. 
|	- `*grep -v*`	``Invert the sense of matching, to select non-matching lines.``. Инвертирует чувствительность совпадений
|	- `*:$*`	метка ``label`` в конце
|	- `*eval*`

.. code-block:: bash
	:linenos:

	if [[ -z $(sed -n -e "s/^\(5_install_util_wd\).*/\1/p" steps.txt) ]]; then

.. code-block:: bash
	:linenos:

	echo "y\n" | apt-get install build-essential
	if [ $? -ne 0 ]; then
	 echo "Error: error install gcc-utils!!!"
	 exit 1
	fi
	
	add-apt-repository-get ppa:ubuntu-toolchain-r/test && apt update

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
	echo -e "y\n" | apt-get install btrfs-progs

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
	echo -e "y\n" | apt-get install wget genisoimage xorriso isolinux hwinfo
	echo -e "y\n" | apt-get install hddtemp lm-sensors
	echo -e "y\n" | apt-get install at
	echo -e "y\n" | apt-get install pip
	echo -e "y\n" | apt-get install xz-utils
	echo -e "y\n" | apt-get install curl
	echo -e "y\n" | apt-get install sphinx
	echo -e "y\n" | apt-get install smartmontools
	echo -e "y\n" | apt-get install python3-sphinx
	echo -e "y\n" | apt-get install nfs-common
	echo -e "y\n" | apt-get install build-essential libssl-dev libffi-dev python3-dev
	echo -e "y\n" | apt-get install python3-venv
	echo -e "y\n" | apt-get install mdadm 
	echo -e "y\n" | apt-get install hdparm
	systemctl enable mdadm
	update-initramfs -u
	
	python3 -m venv env
Python String Comparison operators
----------------------------------
|	In python language, we can compare two strings such as identify whether the two strings are equivalent to each other 
|	or not, or even which string is greater or smaller than each other. Let us check some of the string comparison operator 
|	used for this purpose below:

.. code-block:: bash
	:linenos:

	
	fi
|	==: This operator checks whether two strings are equal.
|	!=: This operator checks whether two strings are not equal.
|	<: This operator checks whether the string on the left side is smaller than the string on the right side.
|	<=: This operator checks whether the string on the left side is smaller or equal to the string on the right side.
|	>: This operator checks whether the string on the left side is greater than the string on the right side.
|	>=: This operator checks whether the string on the left side is greater than the string on the right side.

.. code-block:: bash
	:linenos:

	cd /install/
	touch fdisk.txt
	fdisk -l | sed -n -e "s/.*\(\/dev\/s[a-z]*[0-9]\).*/\1/p" > fdisk.txt
	
	filename='fdisk.txt'
	n=1
	while read line; do
