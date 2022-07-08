#!/usr/bin/python3
# -*- coding: utf-8 -*-
# extract_full_discr_pii2 version v.0.1a
# https://en.wikipedia.org/wiki/Shebang_(Unix) #!/usr/bin/env python3\
import sys,os,re,math;
from array import *
sys.path.insert(0, os.path.abspath('.'))
sys.path.insert(1, os.path.abspath('../'))
#os.pathos.getcwd()
#os.path.normpath(path)

def strToList(st):
    return list(st.split("  "))

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

pdir="build_doc.txt";

with open(pdir,"rt") as dfpii2:
        #s0=''.join(content[j]);
        linep_dfpii2=dfpii2.readlines();
        #print(content[j])
dfpii2.close();

linep_dfpii2_out=[""]*int(len(linep_dfpii2)*5)
j=0;k=0;
POS_0=0;
POS_END=0;
#POS_LIST=[""]*int(0.5*len(linep));
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
length_ch_pii2=0;
j=0

#print(POS_LIST)
#print;("_____________________________________________")

j=0; k=1;
str_search="";
str_comm_0="";
str_comm_end="";
k+=1;

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
j=0;


POS_LISTdfp=[""]*int(10*len(linep_dfpii2));

trig_search_code=0x0;
trig_search_comm=0x0;
j=0;k=0;
for i in linep_dfpii2:
    if((''.join(re.findall("^[^..ch]*", linep_dfpii2[j]))).strip()!=""):
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
        POS_LISTdfp[k]=strToList("# {0} {1}".format(POS_1,POS_END1));
        POS_1 = 0;POS_END1 = 0;
        trig_search_comm=0;
        k+=1;
    if ((''.join(re.findall("^..ch", linep_dfpii2[j])))!=""):
        POS_LISTdfp[k]=strToList("..ch {0}".format(j));
        k+=1;
        #if((trig_search_code & 0x04) == 0x04):
        #    trig_search_code&=~0x04;
        #trig_search_code|=0x01;
        #if(trig_search_code == 0x01):
        #    POS_0=j;
        #    trig_search_code|=0x02;
        #POS_END=j;
    else:
        trig_search_code|=0x04;
    #if((trig_search_code & 0x07) == 0x07):
        #stmp=''.join(["..ch","{0}".format(k)])
    #    POS_LISTdfp[k]=strToList("..ch {0} {1}".format(POS_0,POS_END));
    #    POS_0 = 0;POS_END = 0;
    #    trig_search_code=0;
    #    k+=1;
    j+=1;
    #len(linep)
    if(j>=len(linep_dfpii2)):
        break;
#j=0
#j=k
POS_LISTdfp[k]=strToList("Z 0 0");
#while(k<=(j+20)):
#	POS_LISTdfp[k]=strToList("Z 0 0");
k+=1
POS_LISTdfp[k]=strToList("S 0 0");
#print(k)
#print("_____________________________________________")

#print(POS_LISTdfp)

j=0;k=0;z=0;
# otvyazatb index drug ot druga
#https://pyneng.readthedocs.io/ru/latest/book/15_module_re/
#print(len(linep_dfpii2_out))
#print(POS_LISTdfp)

for i in linep_dfpii2_out:
    if(''.join(POS_LISTdfp[j])[0]=="#"):
        POS_0=int((''.join(POS_LISTdfp[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LISTdfp[j]).split(' ')[2]),10);
        trig_search_comm=0;
        #print("{0} {1}\n".format(POS_0,POS_END))
        j+=1;
        while(POS_0<=POS_END):
            s0=''.join(re.findall("^(\t[0-9a-zA-Zа-яА-ЯеЁ\./_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s1=''.join(re.findall("^(\t\t[0-9a-zA-Zа-яА-ЯеЁ\./_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s2=''.join(re.findall("^(\t\t\t[0-9a-zA-Zа-яА-ЯеЁ\./_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s3=''.join(re.findall("^(\t\t\t\t[0-9a-zA-Zа-яА-ЯеЁ\./_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            if(s0!=""):
                h1=''.join(['=']*len(s0));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s0,h1));
                #k+=1;
                #POS_0=POS_0+1;
            if(s1!=""):
                h2=''.join(['-']*len(s1));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s1,h2));
                #k+=1;
                #POS_0=POS_0+1;
            if(s2!=""):
                h3=''.join(["~"]*len(s2));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s2,h3));
                #k+=1;
                #POS_0=POS_0+1;
            if(s3!=""):
                h4=''.join(["\""]*len(s3));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s3,h4));
                #k+=1;
                #POS_0=POS_0+1;
            if(s0=="" and s1=="" and s2=="" and s3==""):
                linep_dfpii2_out[k] = re.sub('^ ', '', linep_dfpii2[POS_0])
                linep_dfpii2_out[k] = re.sub('^', '|\t', linep_dfpii2[POS_0])
                #POS_0=POS_0+1;
                #k+=1; ^\t ([:a-zA-Z!]*)
            stmp=''.join(re.findall("^([:a-zA-Z!]*)", linep_dfpii2[POS_0]))
            #print(linep_dfpii2[POS_0])
            if (stmp == ":attention!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[POS_0]).replace(":attention!!!",".. attention::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":caution!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[POS_0]).replace(":caution!!!",".. caution::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":error!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[POS_0]).replace(":error!!!",".. error::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":hint!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[POS_0]).replace(":hint!!!",".. hint::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":important!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":important!!!",".. important::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":warning!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":warning!!!",".. warning::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":tip!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":tip!!!",".. tip::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":note!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":note!!!",".. note::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":rubric!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":rubric!!!",".. rubric::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == ":danger!!!"):
                s0=''.join(linep_dfpii2[POS_0]).replace(":danger!!!",".. danger::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            POS_0=POS_0+1;
            k+=1;
#        k+=1;
#        linep_dfpii2_out[k] = strToList("\n");
#        k+=1;
#               POS_0+=1
#                        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
#        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
#        s0=".. code-block:: bash\n\t:linenos:\n"
#        linep_out[k]=strToList("{0}\n".format(s0));
#        k+=1;
#        while(POS_0<=POS_END):
#            linep_out[k] = strToList("\t{0}".format(''.join(linep[POS_0])));
#            k+=1;
#            POS_0=POS_0+1;
        j+=1;
        POS_0=POS_0+1;
        k+=1;
    #print(POS_LIST[j])
    if((''.join(POS_LISTdfp[j])[0])== "Z"):
        break;
j=0;k=0;l=0;
j=0;
pdir=''.join([os.path.abspath('../'),"/docs/build_doc.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_dfpii2_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_dfpii2_out[j]));
        #print(content[j])
        j=j+1;
fpii2.close();

#linep[16]=re.sub('\n', ' ',str)

#print(re.findall("#\t\t\t(.*)$", linep[16]))
#print(re.findall("#\t\t\t(.*)$", linep[17]))

#print(''.join(re.findall("#\t\t\t(.*)$", linep[16])));

#print(re.findall("^#<--!\(.*\)$", linep[4]));

#rint(linep[2])
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
