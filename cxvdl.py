#!/usr/bin/python3
# -*- coding: utf-8 -*-
# version v.0.6a
# https://en.wikipedia.org/wiki/Shebang_(Unix) #!/usr/bin/env python3\
import sys,os,re,math;
from array import *
#os.pathos.getcwd()
#os.path.normpath(path)
i=0;

#def linecount_1(  ):
#    return len(open('nuc').readlines(  ))

def join_strs_better(strs):
    return ' '.join(strs)
    

def mapcount(filename):
    f = open(filename, "r+")
    buf = mmap.mmap(f.fileno(), 0)
    lines = 0
    readline = buf.readline
    while readline():
        lines += 1
    return lines

def simplecount(filename):
    lines = 0
    for line in open(filename):
        lines += 1
    return lines

def bufcount(filename):
    f = open(filename)                  
    lines = 0
    buf_size = 1024 * 1024
    read_f = f.read # loop optimization

    buf = read_f(buf_size)
    while buf:
        lines += buf.count('\n')
        buf = read_f(buf_size)

    return lines

def opcount(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1
    
# Returns True if End-Of-File is reached
def EOF1(f):
    current_pos = f.tell()
    file_size = os.fstat(f.fileno()).st_size
    return current_pos >= file_size
    
def strToList(st):
    return list(st.split("  "))
    
    
#pdir=''.join([os.getcwd(),"/DebianISO/install_ext/install/pii2.sh"]);
pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/install_ext/install/pii2.sh";

#print(pdir);
##
# "x" - Create - will create a file, returns an error if the file exist
# "r" - Read - Default value. Opens a file for reading, error if the file does not exist
# "a" - Append - Opens a file for appending, creates the file if it does not exist
# "w" - Write - Opens a file for writing, creates the file if it does not exist
# "x" - Create - Creates the specified file, returns an error if the file exists
# In addition you can specify if the file should be handled as binary or text mode
# "t" - Text - Default value. Text mode
if not (os.path.exists(pdir)):
    print("The file does not exist");
    sys.exit();

#h1
#==================

#h2
#------------------

#h3
#~~~~~~~~~~~~~~~~~~

#h4
""""""""""""""""""

#===============
#Section Title
#===============

#---------------
#Section Title
#---------------

#Section Title
#=============

#Section Title
#-------------

#Section Title
#`````````````

#Section Title
#'''''''''''''

#Section Title
#.............

#Section Title
#~~~~~~~~~~~~~

#Section Title
#*************

#Section Title
#+++++++++++++

#Section Title
#^^^^^^^^^^^^^

print("_______________")
print("_______________")

#print(re.findall("#\t\t\t(\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[20]))
#print(re.findall("#\t\t\t(\d.\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[193]))
#str = re.findall("#\t\t\t(.*)$", linep[22])
#str1 = re.sub("\t", " ",linep[22])
#print(content)

j=0;
with open(pdir,"rt") as fpii2:
        #s0=''.join(content[j]);
        linep=fpii2.readlines();
        #print(content[j])
fpii2.close();


print("_____________________________________________")

#print(linep)

j=0;
if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[j])).strip())=="bash"):
        print("bash!")
else:
        print("Error: Unknown shell!")
j=0;k=0;
POS_0=0;
POS_END=0;
POS_1=0;
POS_END1=0;

POS_LIST=[""]*int(len(linep)+0.3*len(linep));
#POS_LIST[i]="# pos_c_0 pos_c_end"
#POS_LIST[i]="$ pos_d_0 pos_d_end"
#
#str.find(sub[, start[, end]])
#Возвращает наименьший индекс, по которому обнаруживается начало указанной подстроки в исходной.
#sub : Подстрока, начальный индекс размещения которой требуется определить.
#start=0 : Индекс начала среза в исходной строке, в котором требуется отыскать подстроку.
#end=None : Индекс конца среза в исходной строке, в котором требуется отыскать подстроку.
#Если подстрока не найдена, возвращает −1.

    #trig_search_code=0;
    #linep[j] = re.sub('\n', '', linep[j])
trig_search_code=0x0;
trig_search_comm=0x0;
j=0
for i in linep:
#   search comment #
        #print(POS_LIST[k]);[a-zA-Z0-9\t\n$\[\]/_\ ] [a-zA-Z0-9\t\n$\[\]/_\ ]
    if ((''.join(re.findall("^[^\#]*", linep[j])))!=""):
        if((trig_search_code & 0x04) == 0x04):
            trig_search_code&=~0x04;
        trig_search_code|=0x01;
        
        if(trig_search_code == 0x01):
            POS_0=j;
            trig_search_code|=0x02;
        POS_END=j;
    else:
        trig_search_code|=0x04;
        #print("{0} {1} {2}".format(linep[j],POS_0,trig_search_code));
    if((trig_search_code & 0x07) == 0x07):
        POS_LIST[k]=strToList("$ {0} {1}".format(POS_0,POS_END));
        POS_0 = 0;POS_END = 0;
        trig_search_code=0;
        k+=1;
        
    if((''.join(re.findall("^#", linep[j]))).strip()!=""):
        if((trig_search_comm & 0x08) == 0x08):
            trig_search_comm&=~0x08;
        trig_search_comm|=0x10;
        if(trig_search_comm == 0x10):
            POS_1=j;
            trig_search_comm|=0x20;
        POS_END1=j;
    else:
       trig_search_comm|=0x08;
    if((trig_search_comm & 0x38) == 0x38):
        POS_LIST[k]=strToList("# {0} {1}".format(POS_1,POS_END1));
        POS_1 = 0;POS_END1 = 0;
        trig_search_comm=0;
        k+=1;
    j+=1;
    #len(linep)
    if(j>=len(linep)):
        break;
POS_LIST[k]=strToList("S 0 0");
POS_LIST[k+1]=strToList("S 0 0");
print(POS_LIST[k+1])
print(j)
#print(''.join(POS_LIST[0])[0])
#print(re.split(r' +', ''.join(POS_LIST[0])))

print;("_____________________________________________")

j=0; k=0;
str_search="";
str_comm_0="";
str_comm_end="";

linep_out=[""]*int(len(linep)+0.3*len(linep));
print("_________________             _________________");

#print(linep);

if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[0])).strip())=="bash"):
    linep[0] = "bash\n******\n\n"
else:
    sys.exit();

#print(''.join(POS_LIST[j]))
#print(''.join(POS_LIST[j]).split(' ')[2])
print(''.join(POS_LIST[0]))

print(int((''.join(POS_LIST[0]).split(' ')[1]),10))
print(int((''.join(POS_LIST[0]).split(' ')[2]),10))

print(''.join(POS_LIST[1]))

print(int((''.join(POS_LIST[1]).split(' ')[1]),10))
print(int((''.join(POS_LIST[1]).split(' ')[2]),10))

#print(POS_LIST)

j=0;
#pdir=''.join([os.getcwd(),"/out_list.sh"]);
#with open(pdir,"wt") as fpii2:
#    for i in linep_out:
        #s0=''.join(content[j]);
#        fpii2.write(''.join(POS_LIST[j]));
#        #print(content[j])
#        j=j+1;
#fpii2.close();
j=0;
#print(POS_LIST[362])
#print(POS_LIST[363])
print("+_++++++++++++++++++++++++++")

print(linep[802])
print(''.join(re.findall("(\d.\d\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[802])))

print(linep[885])
print(''.join(re.findall("(\d.\d\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[885])))

#https://pyneng.readthedocs.io/ru/latest/book/15_module_re/
for i in linep_out:
    #print(j)
    if(''.join(POS_LIST[j])[0]=="#"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        while(POS_0<=POS_END):
            s0=''.join(re.findall("#\t\t\t(\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s1=''.join(re.findall("#\t\t\t(\d\d.\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s2=''.join(re.findall("#\t\t\t(\d\d.\d\d.\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            if(s0!=""):
                h1=''.join(['=']*len(s0));
                linep_out[k] = strToList("{0}\n{1}\n".format(s0,h1));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["="]*len(h1)));
            #content[k+1] = strToList("{0}\n".format(''.join(h1)));
            if(s1!=""):
                h2=''.join(['-']*len(s1));
                linep_out[k] = strToList("{0}\n{1}\n".format(s1,h2));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["-"]*len(h2)));
            #content[k+1] = strToList("{0}\n".format(''.join(h2)));
            if(s2!=""):
                h3=''.join(["~"]*len(s2));
                linep_out[k] = strToList("{0}\n{1}\n".format(s2,h3));
                k+=3;
                POS_0=POS_0+1;
                #print("{0} {1}".format(POS_0,POS_END))
            if(s0=="" and s1=="" and s2==""):
                linep[POS_0] = re.sub('#<--!|#!-->', '|\t', linep[POS_0])
                linep[POS_0] = re.sub('#', '|\t', linep[POS_0])
                #linep[POS_0] = re.sub('|    danger!!!', '.. danger::', linep[POS_0])
                linep_out[k] = re.sub('^ ', '', linep[POS_0])
            #if(''.join(re.findall("^|    (danger!!! [.*]*)", linep[POS_0]))!= ""):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
            #    print(linep[POS_0]);
            #    s0=''.join(linep[POS_0]).replace("|     danger!!!",".. danger::");
            #    linep[POS_0] = strToList("{0}\n".format(s0));
                
                #linep_out[k] = re.sub('#<--!|#!-->', '', linep[POS_0]);
                #linep_out[k] = linep[POS_0];
                POS_0=POS_0+1;
            k+=1;
    if (''.join(POS_LIST[j])[0]=="$"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        s0=".. code-block:: bash\n"
        linep_out[k]=strToList("{0}\n".format(s0));
        k+=1;
        while(POS_0<=POS_END):
            #s1=''.join(re.findall("#\t\t\t(\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            #s2=''.join(re.findall("#\t\t\t(\d.\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            #s0='\t'.join(linep[POS_0]);
            #linep_out[k] = strToList("{0}".format(''.join(s0)));
                #linep_out[k] = re.sub('#<--!|#!-->', '', linep[POS_0]);
            #linep_out[k] = strToList("{0}\n".format(s0));
            linep_out[k] = strToList("\t{0}".format(''.join(linep[POS_0])));
            k+=1;
            POS_0=POS_0+1;
    j+=1;
    if((''.join(POS_LIST[j])[0])== "S"):
        break;

#print(linep_out)
j=0;
#pdir=''.join([os.getcwd(),"/docs/cut_discr.rst"]);
#pdir=''.join([os.getcwd(),"/docs/cut_discr.rst"]);
pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";
with open(pdir,"wt") as fpii2:
    for i in linep_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_out[j]));
        #print(content[j])
        j=j+1;
fpii2.close();

#print(linep[42])
#print(linep[48])
#print(linep[50])
#print(linep[52])
#print(linep[61])
#.. code-block:: bash
#   :caption: pii2 bash

#   /**
#    * Add default TypoScript (constants and setup)
#    */
#   \TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addStaticFile(
#       'site_package',
#       'Configuration/TypoScript',
#       'Site Package'
#   );




#linep[16]=re.sub('\n', ' ',str)

#print(re.findall("#\t\t\t(.*)$", linep[16]))
#print(re.findall("#\t\t\t(.*)$", linep[17]))

#print(''.join(re.findall("#\t\t\t(.*)$", linep[16])));

#print(re.findall("^#<--!\(.*\)$", linep[4]));    

#rint(linep[2])
print(" ");
print(" ");
#p = re.search('\bclass\b')
#______SEARCH Commentary pii2.sh______
#
# 1) poisk #<--!

re.purge();
#sys.exit();

#for filename in os.listdir(directory):
#    if filename.endswith(".txt"):
#        f = open(filename)
#        lines = f.read()
#        print (lines[10])
#        continue
#    else:
#    continue

#fpii2 = open(pdir,"rwt")
#linep = ['']*os.fstat(fpii2.fileno()).st_size
#print(fpii2.readlines());
#fpii2.seek(0);
#with open("sample.txt", "r") as a_file:
