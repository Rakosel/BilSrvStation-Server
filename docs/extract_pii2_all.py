#!/usr/bin/python3
# -*- coding: utf-8 -*-
# pii2_extract version v.0.8a
# https://en.wikipedia.org/wiki/Shebang_(Unix) #!/usr/bin/env python3\
import sys,os,re,math;
from array import *
sys.path.insert(0, os.path.abspath('.'))
sys.path.insert(1, os.path.abspath('../'))
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
	
#print(os.getcwd())
#print(sys.path)
#print("\n\n\n\n")
pdir=''.join([os.path.abspath('../'),"/DebianISO/install_ext/install/pii2.sh"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/DebianISO/install_ext/install/pii2.sh";
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
    print("The file in path: {0} does not exist".format(pdir));
    exit;

#h1
#==================

#h2
#------------------

#h3
#~~~~~~~~~~~~~~~~~~

#h4
#""""""""""""""""""

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

#print("_______________")
#print("_______________")

#print(re.findall("#\t\t\t(\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[20]))
#print(re.findall("#\t\t\t(\d.\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[193]))
#str = re.findall("#\t\t\t(.*)$", linep[22])
#str1 = re.sub("\t", " ",linep[22])
#print(content)

j=0;
#,encoding='cp1251',errors='replace', newline='',encoding='utf-8'
with open(pdir,"rt") as fpii2:
        #s0=''.join(content[j]);
        linep=fpii2.readlines();
        #print(content[j])
fpii2.close();

#print(linep)

j=0;
if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[j])).strip())!="bash"):
        print("Error: Unknown shell!")
        exit;
j=0;k=0;
POS_0=0;
POS_END=0;
POS_1=0;
POS_END1=0;

POS_LIST=[""]*int(len(linep)+0.5*len(linep));
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
        linep[j] = re.sub("vkd174asqd", '********', linep[j])
        linep[j] = re.sub("vkd174", '********', linep[j])
        #linep[j] = re.sub("vkd174asqd", '********', linep[j])
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
        linep[j] = re.sub("vkd174asqd", '********', linep[j])
        linep[j] = re.sub("vkd174", '********', linep[j])
        #linep[j] = strToList("{0}".format(''.join(linep[j]).replace("vkd174asqd","********")));
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
#j=0
j=k
POS_LIST[k]=strToList("Z 0 0");
while(k<=(j+20)):
	POS_LIST[k]=strToList("Z 0 0");
	k+=1
POS_LIST[k]=strToList("S 0 0");
#print(k)
#print;("_____________________________________________")

j=0; k=1;
str_search="";
str_comm_0="";
str_comm_end="";

linep_out=[""]*int(len(linep)*5);
linep_out_pack=[""]*int(len(linep)*5);
#print(linep); re.sub('^#!\/bin\/(.*).*', '|\t', linep[POS_0])
linep_out[k]="AutoInstall Cut Discr\n*************************\n"
k+=1;
linep_out[k]="| Published by |author|\n"
k+=1;
linep_out[k]="| Date: *|date|* Time *|time|*\n"
k+=1;
if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[0])).strip())=="bash"):
    linep_out[k] = "|	Type script: *{0}*\n".format(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[0])).strip()));
else:
    exit;
k+=1;

#print(POS_LIST)

#pdir=''.join([os.getcwd(),"/out_list.sh"]);
#with open(pdir,"wt") as fpii2:
#    for i in linep_out:
        #s0=''.join(content[j]);
#        fpii2.write(''.join(POS_LIST[j]));
#        #print(content[j])
#        j=j+1;
#fpii2.close();
#print(POS_LIST[362])
#print(POS_LIST[363])
#print("+_++++++++++++++++++++++++++")

#print(linep[18])
#print(''.join(re.findall("(\d.\d\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[802])))

#linep[18] = re.sub('#', '|\t', linep[18])
#linep[POS_0] = re.sub('|    danger!!!', '.. danger::', linep[POS_0])
#linep[18] = re.sub('^ ', '', linep[18])

#.. list-table: Table header
#	:widths: 15 10 30
#	:header-rows: 1
#	*	- Named
#		- Family
#		- Date
#	and etc
#	
#.. table::	Easy Table
#	====	====	====
s0="";
s1="";
s2="";
stmp="";
strapt="";
strpip="";
strsemodule="";
strsepolicy="";
strsepermissive=""
strsebool=""
strseport=""
strsecontext=""
strselogin=""
strselogin_count=0;
strsepermissive_count=0;
strsebool_count=0;
strseport_count=0;
strseuser=""
trig_search_comm=0;
#print(POS_LIST)
#https://pyneng.readthedocs.io/ru/latest/book/15_module_re/
for i in linep_out:
    if(''.join(POS_LIST[j])[0]=="#"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        trig_search_comm=0;
        while(POS_0<=POS_END):
            #print(linep[POS_0])
            s0=''.join(re.findall("#\t\t\t(\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s1=''.join(re.findall("#\t\t\t(\d\d.\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s2=''.join(re.findall("#\t\t\t(\d\d.\d\d.\d\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            if(s0!=""):
                h1=''.join(['=']*(len(s0)+5));
                linep_out[k] = strToList("{0}\n{1}\n".format(s0,h1));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["="]*len(h1)));
            #content[k+1] = strToList("{0}\n".format(''.join(h1)));
            if(s1!=""):
                h2=''.join(['-']*(len(s1)+5));
                linep_out[k] = strToList("{0}\n{1}\n".format(s1,h2));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["-"]*len(h2)));
            #content[k+1] = strToList("{0}\n".format(''.join(h2)));
            if(s2!=""):
                h3=''.join(["~"]*(len(s2)+5));
                linep_out[k] = strToList("{0}\n{1}\n".format(s2,h3));
                k+=3;
                POS_0=POS_0+1;
                #print("{0} {1}".format(POS_0,POS_END))
            if(s0=="" and s1=="" and s2==""):
                linep[POS_0] = re.sub('#<--!|#!-->', '|\t', linep[POS_0])
                #if (trig_search_comm==0):
                linep[POS_0] = re.sub('#', '|\t', linep[POS_0]);
                #    trig_search_comm=1;
                #else:
                #    linep[POS_0] = re.sub('#', '\t', linep[POS_0])
                #linep[POS_0] = re.sub('|    danger!!!', '.. danger::', linep[POS_0])
                linep_out[k] = re.sub('^ ', '', linep[POS_0])
            #if(POS_0==18): print(linep[POS_0]);
            #if(''.join(re.findall("^|\t ([a-zA-Z!]*)", linep_out[k]))=="danger!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
            #    s0=''.join(linep_out[k]).replace("|\t danger!!!",".. danger::");
            #    linep_out[k] = strToList("{0}\n".format(s0));
                #linep_out[k] = re.sub('#<--!|#!-->', '', linep[POS_0]);
                #linep_out[k] = linep[POS_0];
                #print(''.join(re.findall(".*([vkd174]*)", linep_out[k])))
            #print(''.join(re.findall("^|\t ([a-zA-Z!])*", linep_out[k])))
            stmp=''.join(re.findall("^|\t ([a-zA-Z!]*)", linep_out[k]))
            if (stmp == "attention!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 attention!!!",".. attention::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "caution!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 caution!!!",".. caution::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "error!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 error!!!",".. error::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "hint!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 hint!!!",".. hint::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "important!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 important!!!",".. important::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "warning!!!"):
                #print("warning!!!")
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_out[k]).replace("|	 warning!!!",".. warning::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "tip!!!"):
                s0=''.join(linep_out[k]).replace("|	 tip!!!",".. tip::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "note!!!"):
                s0=''.join(linep_out[k]).replace("|	 note!!!",".. note::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "rubric!!!"):
                s0=''.join(linep_out[k]).replace("|	 rubric!!!",".. rubric::");
                linep_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "danger!!!"):
                s0=''.join(linep_out[k]).replace("|	 danger!!!",".. danger::");
                linep_out[k] = strToList("{0}\n".format(s0));
            POS_0=POS_0+1;
            #linep_out[k] = strToList("{0}".format(''.join(linep_out[j]).replace("vkd174asqd","********")));
        #linep[j] = strToList("{0}".format(''.join(linep[j]).replace("vkd174asqd","********")));
            #int((''.join(POS_LIST[j]).split(' ')[2]),10);
            k+=1;
    if (''.join(POS_LIST[j])[0]=="$"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        s0=".. code-block:: bash\n\t:linenos:\n"
        linep_out[k]=strToList("{0}\n".format(s0));
        k+=1;
        while(POS_0<=POS_END):
            linep_out[k] = strToList("\t{0}".format(''.join(linep[POS_0])));
            #print(''.join(re.findall("^|.*apt\-get install( [a-zA-Z/_\-&><=$%\[\] ]*)", linep[k])))
            if(''.join(re.findall("apt", linep[POS_0]))=="apt"):
                strapt+=''.join(re.findall("^.*apt\-get install( [a-zA-Z0-9/_\-&><=$%\[\]* ]*)", linep[POS_0]))
                strapt+=''.join(re.findall("^.*sudo apt install( [a-zA-Z0-9/_\-&><=$%\[\]* ]*)", linep[POS_0]))
                #strapt+=''.join(re.findall("^.*apt install( [a-zA-Z0-9/_\-&><=$%\[\]* ]*)", linep[POS_0]))
            if(''.join(re.findall("semanage login", linep[POS_0]))=="semanage login"):
                #.split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3]+' '+''.join(linep[POS_0]).split(' ')[4]+''.join(linep[POS_0]).split(' ')[5]+' ';
                strselogin+=''.join(linep_out[k]).replace("\"","").strip()+' ';
                strselogin_count+=1;
                #strselogin+=''.join(linep[POS_0]).split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3]+' '+''.join(linep[POS_0]).split(' ')[4]+''.join(linep[POS_0]).split(' ')[5]+' ';
            if(''.join(re.findall("semodule", linep[POS_0]))=="semodule"):
                #''.join(linep[POS_0]).split(' ')[0]+' '+''.join(linep[POS_0]).split(' ')[2];
                strsemodule+=''.join(linep[POS_0]).split(' ')[0]+' '+''.join(linep[POS_0]).split(' ')[2];
            if(''.join(re.findall("setsebool", linep[POS_0]))=="setsebool"):
                #''.join(linep[POS_0]).split(' ')[0]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3];
                strsebool_count+=1;
                strsebool+=''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3]+' ';
            if(''.join(re.findall("semanage permissive", linep[POS_0]))=="semanage permissive"):
                #''.join(linep[POS_0]).split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3]+'\n';
                #print(''.join(linep[POS_0]).split(' ')[1].replace("\n","")+' '+''.join(linep[POS_0]).split(' ')[2].replace("\n","")+' '+''.join(linep[POS_0]).split(' ')[3].replace("\n","")+' ')
                strsepermissive+=''.join(linep[POS_0]).split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3].replace("\n","")+' ';
                strsepermissive_count+=1;
            if(''.join(re.findall("semanage port", linep[POS_0]))=="semanage port"):
                strseport_count+=1;
                #''.join(linep[POS_0]).split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[4]+' '+''.join(linep[POS_0]).split(' ')[6]+' '+''.join(linep[POS_0]).split(' ')[7];
                strseport+=''.join(linep[POS_0]).split(' ')[4]+' '+''.join(linep[POS_0]).split(' ')[2]+' '+''.join(linep[POS_0]).split(' ')[3]+' '+''.join(linep[POS_0]).split(' ')[6]+' '+''.join(linep[POS_0]).split(' ')[7]+' ';
            #if(''.join(re.findall("semanage fcontext", linep[POS_0]))=="semanage fcontext"):
                #''.join(linep[POS_0]).split(' ')[1]+' '+''.join(linep[POS_0]).split(' ')[4]+' '+''.join(linep[POS_0]).split(' ')[5];
                #strsecontext+=''.join(linep[POS_0]).split(' ')
            if(''.join(re.findall("pip", linep[POS_0]))=="pip"):
                strpip+=''.join(re.findall("^.*pip install( [a-zA-Z0-9/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            k+=1;
            POS_0=POS_0+1;
    j+=1;
    #print(POS_LIST[j])
    if((''.join(POS_LIST[j])[0])== "S"):
        break;
j=0;
#print(strapt)
#print("___________")
#print(strpip)
#print("___________")
#print(strselogin)
#print("___________")
#print(strseuser)
#print("___________")
#print(strsemodule)
#print("___________")
#print(strsebool)
#print("___________")
#print(strsepermissive)
#print("___________")
#print(strsecontext)
#print("___________")
#print(strseport)
k=0
linep_out_pack[k]="AutoInstall Package List\n*************************\n"
k+=1;

#   apt-get list
linep_out_pack[k]="\n.. csv-table:: apt-get list\n"
k+=1;
linep_out_pack[k]="\t:header: \"#\", \"apt-get\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
#strToList("\t{0}".format(strapt.split(' ')[z]);len(strapt.split(' '))len(strapt.split(' ')
j=k+len(strapt.split(' '))-1
#linep_out[k]=strToList("{1} {0}\n".format(strapt.split(' ')[z]));
#print("{0}\n".format(strapt.split(' ')[len(strapt.split(' '))-1]))
#print("{0} {1}".format(k,j))
while (j>=k):
    if(strapt.split(' ')[z]!="" and strapt.split(' ')[z]!="-y"):
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}\"\n".format(z,strapt.split(' ')[z]));
    z+=1;k+=1;

#   Module PIP list var:strpip
linep_out_pack[k]="\n.. csv-table:: Python pip package\n"
k+=1;
linep_out_pack[k]="\t:header: \"#\", \"Module PIP\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
#strToList("\t{0}".format(strapt.split(' ')[z]);len(strapt.split(' '))len(strapt.split(' ')
j=k+len(strpip.split(' '))-1
#linep_out[k]=strToList("{1} {0}\n".format(strapt.split(' ')[z]));
#print("{0}\n".format(strapt.split(' ')[len(strapt.split(' '))-1]))
#print("{0} {1}".format(k,j))
while (j>=k):
    if(strpip.split(' ')[z]!="" and strpip.split(' ')[z]!="-U"):
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}\"\n".format(z,strpip.split(' ')[z]));
    z+=1;k+=1;

#   apt-get list var:strapt
linep_out_pack[k]="\n.. csv-table:: SEmanage login\n"
k+=1;
linep_out_pack[k]="\t:header: \"Semanage\", \"Options\", \"Group\", \"Role\", \"User\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
#strToList("\t{0}".format(strapt.split(' ')[z]);len(strapt.split(' '))len(strapt.split(' ')
j=k+strselogin_count-1
#print(len(strselogin.split(' ')))

#linep_out[k]=strToList("{1} {0}\n".format(strapt.split(' ')[z]));
#print("{0}\n".format(strapt.split(' ')[len(strapt.split(' '))-1]))
#print(j)
c=0;

#stmp="strselogin.split(' ')[z+1],strselogin.split(' ')[z+2],strselogin.split(' ')[z+3],strselogin.split(' ')[z+5],strselogin.split(' ')[z+4],strselogin.split(' ')[z+6],strselogin.split(' ')[z+7]"
#print(strselogin.split(' ')[z+5])
#print(strToList("\t\"{0}\", \"{1}, {2}\", \"{3}\", \"{4}\", \"{5}\"\n".format(strselogin.split(' ')[z+1],strselogin.split(' ')[z+2],strselogin.split(' ')[z+3],strselogin.split(' ')[z+4],strselogin.split(' ')[z+5],strselogin.split(' ')[z+7])))

while (j>=k):
    if(strselogin.split(' ')[z+5]=="-r"):
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}, {2}, {3}\", \"{4}\", \"{5}\", \"{6}\"\n".format(strselogin.split(' ')[z+1],strselogin.split(' ')[z+2],strselogin.split(' ')[z+3],strselogin.split(' ')[z+5],strselogin.split(' ')[z+4],strselogin.split(' ')[z+6],strselogin.split(' ')[z+7]));
    else:
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}, {2}\", \"{3}\", \"{4}\", \"{5}\"\n".format(strselogin.split(' ')[z+1],strselogin.split(' ')[z+2],strselogin.split(' ')[z+3],strselogin.split(' ')[z+4],strselogin.split(' ')[z+6],strselogin.split(' ')[z+5]));
    #print(linep_out[k])
    k+=1;z+=8;
    if((z+7)>=len(strselogin.split(' '))):
#        print(z)
        c=len(strselogin.split(' '))-z+2;
    #    formstr="";
        for d in range(0,c):
            strselogin+='-'+' '
#print(strselogin)
    
#   apt-get list var:strselogin
linep_out_pack[k]="\n.. csv-table:: SEmodules\n"
k+=1;
linep_out_pack[k]="\t:header: \"#\", \"SEmodule name\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
j=k+len(strsemodule.split(' '))-1
#linep_out[k]=strToList("{1} {0}\n".format(strapt.split(' ')[z]));
#print("{0}\n".format(strapt.split(' ')[len(strapt.split(' '))-1]))
#print("{0} {1}".format(k,j))
while (j>=k):
    if(strsemodule.split('\n')[z]!=""):
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}\"\n".format(z,strsemodule.split('\n')[z].strip()));
    z+=1;k+=1;

#   apt-get list var:strsepermissive
linep_out_pack[k]="\n.. csv-table:: Policy permissive\n"
k+=1;
linep_out_pack[k]="\t:header: \"Permissive name\", \"Permissive mode\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
j=k+strsepermissive_count-1
#print("\t\"{0}\", \"{1}\"\n".format(k,j))
#print(strsepermissive_count)

while (j>=k):
    linep_out_pack[k]=strToList("\t\"{0}\", \"{1}\"\n".format(strsepermissive.split(' ')[z+2].strip(),strsepermissive.split(' ')[z+1].strip()));
    z+=3;k+=1;
    if(strsepermissive.split(' ')[z].strip()==""):
        break;
        
        
        
#   apt-get list var:strsepermissive
linep_out_pack[k]="\n.. csv-table:: SELinux setsebool\n"
k+=1;
linep_out_pack[k]="\t:header: \"SEbool name\", \"SEbool mode\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
j=k+strsebool_count-1
#print("\t\"{0}\", \"{1}\"\n".format(k,j))
#print(strsepermissive_count)
while (j>=k):
    if(strsebool.split(' ')[z+2]!=""):
        linep_out_pack[k]=strToList("\t\"{0}\", \"{1}\"\n".format(strsebool.split(' ')[z+2].strip(),strsebool.split(' ')[z+1].strip()));
    z+=2;k+=1;

        
        
 #   apt-get list var:strsepermissive
linep_out_pack[k]="\n.. csv-table:: SELinux port\n"
k+=1;
linep_out_pack[k]="\t:header: \"Port name\", \"Parametr\", \"Port type\", \"Number port\"\n"
k+=1;
linep_out_pack[k]="\t:widths: auto\n\n"
k+=1;
#j=k;
z=0;
j=k+strseport_count-1
#print("\t\"{0}\", \"{1}\"\n".format(k,j))
#print(strsepermissive_count)

while (j>=k):
    linep_out_pack[k]=strToList("\t\"{0}\", \"{1}, {2}\", \"{3}\", \"{4}\"\n".format(strseport.split(' ')[z].strip(),strseport.split(' ')[z+1].strip(),strseport.split(' ')[z+2].strip(),strseport.split(' ')[z+3].strip(),strseport.split(' ')[z+4].strip()));
    z+=5;k+=1;
    #if(strsebool.split(' ')[z]==""):
    #    break;

#strToList("\t{0}".format(strapt.split(' ')[z]);len(strapt.split(' '))len(strapt.split(' ')
#linep_out[k]=strToList("{1} {0}\n".format(strapt.split(' ')[z]));
#print("{0}\n".format(strapt.split(' ')[len(strapt.split(' '))-1]))
#print("{0} {1}".format(k,j))
#j=k+len(strsepermissive.split(' '))-1
#print(len(strsepermissive.split(' '))-1)
#while (j>=k):
#    linep_out[k]=strToList("\t\"{0}\", \"{0}\", \"{0}\"\n".format(z,strsepermissive.split(' ')[z+1].strip()));
#    z+=1;k+=1;
#    print(strsepermissive.split(' ')[z+1].strip())

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
j=0;
pdir=''.join([os.path.abspath('../'),"/docs/cut_discr_pii2.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_out[j]));
        #print(content[j])
        j=j+1;
fpii2.close();

j=0;
pdir=''.join([os.path.abspath('../'),"/docs/cut_discr_pii2_pack.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_out_pack:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_out_pack[j]));
        #print(content[j])
        j=j+1;
fpii2.close();



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
exit;

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
