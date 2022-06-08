Full discr functions pii
========================
|	In this article, we will learn what is strings in a programming language, how to create them, 
|	At last, we will study some Python strings comparison in brief along with its python code example and output. 

.. code-block:: bash
	:linenos:

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

What are Strings
----------------
|	A string is generally a sequence of characters. A character is a simple symbol. 
|	the English Language, we have 26 characters available. 
|	therefore, deal with binary numbers. 
|	stored and manipulated as a combination of 0s and 1s. 
|	and the reverse of this is known as decoding.  
|	language, a string is a sequence of Unicode characters.

.. code-block:: bash
	:linenos:

	sed -i -e "$a s/\(iface\s\).*/\1$NET_WI inet dhcp/g" interfaces


.. code-block:: bash
	:linenos:

	sed '$a	wpa-conf \/home\/rootsu\/wpa_supplicant.conf' interfaces >> interfaces;


.. code-block:: bash
	:linenos:

	systemctl restart wpa_supplicant


.. code-block:: bash
	:linenos:

	else
	
	if [[ -z $(sed -n -e "s/\(source \/etc\/network\/interfaces/\\).*/\1/p" interfaces) ]]; then
			TMPS="1";
			reinterfaces;
	fi

Python String Comparison operators
----------------------------------
|	In python language, we can compare two strings such as identify whether the two strings are equivalent to each other 
|	used for this purpose below:

.. code-block:: bash
	:linenos:

	
	systemctl restart networking 
	 
	cd /install/
	echo -e "1_settings_interface_with_wifi" >> steps.txt
	fi

|	==: This operator checks whether two strings are equal.
|	<: This operator checks whether the string on the left side is smaller than the string on the right side.
|	>: This operator checks whether the string on the left side is greater than the string on the right side.

.. code-block:: bash
	:linenos:

	echo -e "y\n" | apt-get install firmware-linux
	
	if [[ $(lspci | grep Ethernet | sed -n -e "s/.*ller:\s\([a-zA-Z]\+\s\).*/\1/p") == "Realtek" ]]; then 
	echo -e "y\n" | apt-get install firmware-realtek
	fi
	echo -e "y\n" | apt-get install firmware-linux-nonfree
	echo -e "y\n" | apt-get install man 

