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

pdir="extract_full_discr_pii2.txt";

with open(pdir,"rt") as dfpii2:
        #s0=''.join(content[j]);
        linep_dfpii2=dfpii2.readlines();
        #print(content[j])
dfpii2.close();

linep_dfpii2_out=[""]*int(len(linep_dfpii2)*5)
linep_dfpii2code_out=[""]*int(len(linep)*5)


j=0;
if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[j])).strip())!="bash"):
        print("Error: Unknown shell!")
        exit;
j=0;k=0;
POS_0=0;
POS_END=0;


POS_LIST=[""]*int(0.5*len(linep));

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
        length_ch_pii2+=1;
        POS_0 = 0;POS_END = 0;
        trig_search_code=0;
        k+=1;
    if((''.join(re.findall("^#", linep[j]))).strip()!=""):
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
#        POS_LIST[k]=strToList("# {0} {1}".format(POS_1,POS_END1));
        POS_1 = 0;POS_END1 = 0;
        trig_search_comm=0;
        #k+=1;
    j+=1;
    #len(linep)
    if(j>=len(linep)):
        break;
#j=0
j=k
POS_LIST[k]=strToList("Z 0 0");
while(k<=(j+1)):
	POS_LIST[k]=strToList("Z 0 0");
	k+=1
POS_LIST[k]=strToList("S 0 0");


#print(POS_LIST)
#print;("_____________________________________________")

j=0; k=1;
str_search="";
str_comm_0="";
str_comm_end="";

linep_out=[""]*int(len(linep)*5);

if(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[0])).strip())=="bash"):
    linep_out[k] = "|	Type script: *{0}*\n".format(str(''.join(re.findall('^#!\/bin\/(.*).*', linep[0])).strip()));
else:
    exit;
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
#print(POS_LIST)
#https://pyneng.readthedocs.io/ru/latest/book/15_module_re/
for i in linep_out:
    if(''.join(POS_LIST[j])[0]=="#"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        trig_search_comm=0;
        while(POS_0<=POS_END):
            #print(linep[POS_0])
            s0=''.join(re.findall("#\t([a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s1=''.join(re.findall("#\t\t([a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s2=''.join(re.findall("#\t\t\t([a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
            s3=''.join(re.findall("#\t\t\t\t([a-zA-Z/_\-&><=$%\[\]* ]*)", linep[POS_0]));
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
            if(s3!=""):
                h4=''.join(["\""]*len(s3));
                linep_out[k] = strToList("{0}\n{1}\n".format(s3,h4));
                k+=3;
                POS_0=POS_0+1;
                #print("{0} {1}".format(POS_0,POS_END))
            if(s0=="" and s1=="" and s2=="" and s3==""):
                linep[POS_0] = re.sub('#<--!|#!-->', '|\t', linep[POS_0])
                linep[POS_0] = re.sub('#', '|\t', linep[POS_0])
                #linep[POS_0] = re.sub('|    danger!!!', '.. danger::', linep[POS_0])
                linep_out[k] = re.sub('^ ', '', linep[POS_0])
                #print("error for index {0}".format(k))
                POS_0=POS_0+1;
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
            k+=1;
    if (''.join(POS_LIST[j])[0]=="$"):
        POS_0=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        s0=".. code-block:: bash\n\t:linenos:\n"
        linep_out[k]=strToList("{0}\n".format(s0));
        k+=1;
        while(POS_0<=POS_END):
            linep_out[k] = strToList("\t{0}".format(''.join(linep[POS_0])));
            k+=1;
            POS_0=POS_0+1;
    j+=1;
    #print(POS_LIST[j])
    if((''.join(POS_LIST[j])[0])== "S"):
        break;
j=0;


POS_LISTdfp=[""]*int(10*len(linep_dfpii2));

trig_search_code=0x0;
trig_search_comm=0x0;
j=0;k=0;
for i in linep_dfpii2:
#   search comment #
        #print(POS_LIST[k]);[a-zA-Z0-9\t\n$\[\]/_\ ] [a-zA-Z0-9\t\n$\[\]/_\ ]
    if((''.join(re.findall("^[^..ch]*", linep_dfpii2[j]))).strip()!=""):
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
#print;("_____________________________________________")

#print(POS_LISTdfp)

j=0;k=0;z=0;
# otvyazatb index drug ot druga

#https://pyneng.readthedocs.io/ru/latest/book/15_module_re/
for i in linep_dfpii2_out:
    #print(POS_LISTdfp[j])
    #print(j)
    if(''.join(POS_LISTdfp[j])[0]=="#"):
        POS_0=int((''.join(POS_LISTdfp[j]).split(' ')[1]),10);
        POS_END=int((''.join(POS_LISTdfp[j]).split(' ')[2]),10);
        trig_search_comm=0;
        while(POS_0<=POS_END):
            #print(linep[POS_0])
            s0=''.join(re.findall("^(\t[a-zA-Z/_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s1=''.join(re.findall("^(\t\t[a-zA-Z/_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s2=''.join(re.findall("^(\t\t\t[a-zA-Z/_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            s3=''.join(re.findall("^(\t\t\t\t[a-zA-Z/_\-&><=$%\[\]* ]*)", linep_dfpii2[POS_0])).strip();
            if(s0!=""):
                h1=''.join(['=']*len(s0));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s0,h1));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["="]*len(h1)));
            #content[k+1] = strToList("{0}\n".format(''.join(h1)));
            if(s1!=""):
                h2=''.join(['-']*len(s1));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s1,h2));
                k+=3;
                POS_0=POS_0+1;
            #print(str(["-"]*len(h2)));
            #content[k+1] = strToList("{0}\n".format(''.join(h2)));
            if(s2!=""):
                h3=''.join(["~"]*len(s2));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s2,h3));
                k+=3;
                POS_0=POS_0+1;
            if(s3!=""):
                h4=''.join(["\""]*len(s3));
                linep_dfpii2_out[k] = strToList("{0}\n{1}\n".format(s3,h4));
                k+=3;
                POS_0=POS_0+1;
                #print("{0} {1}".format(POS_0,POS_END))
            if(s0=="" and s1=="" and s2=="" and s3==""):
                #linep_dfpii2_out[POS_0] = re.sub('#<--!|#!-->', '|\t', linep_dfpii2[POS_0])
                #linep[POS_0] = re.sub('|    danger!!!', '.. danger::', linep[POS_0])
                linep_dfpii2_out[k] = re.sub('^ ', '', linep_dfpii2[POS_0])
                linep_dfpii2_out[k] = re.sub('^', '|\t', linep_dfpii2[POS_0])
                #print("error for index {0}".format(k))
                POS_0=POS_0+1;
            stmp=''.join(re.findall("^\t ([a-zA-Z!]*)", linep_dfpii2[POS_0]))
            if (stmp == "attention!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 attention!!!",".. attention::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "caution!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 caution!!!",".. caution::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "error!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 error!!!",".. error::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "hint!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 hint!!!",".. hint::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "important!!!"):
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 important!!!",".. important::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "warning!!!"):
                #print("warning!!!")
            #    print(''.join(re.findall("^|    danger([.*]*)", linep[POS_0])));
                s0=''.join(linep_dfpii2[k]).replace("|	 warning!!!",".. warning::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "tip!!!"):
                s0=''.join(linep_dfpii2[k]).replace("|	 tip!!!",".. tip::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "note!!!"):
                s0=''.join(linep_dfpii2[k]).replace("|	 note!!!",".. note::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "rubric!!!"):
                s0=''.join(linep_dfpii2[k]).replace("|	 rubric!!!",".. rubric::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            elif(stmp == "danger!!!"):
                s0=''.join(linep_dfpii2[k]).replace("|	 danger!!!",".. danger::");
                linep_dfpii2_out[k] = strToList("{0}\n".format(s0));
            POS_0=POS_0+1;
            k+=1;
#    print(''.join(POS_LISTdfp[j]).split(' ')[0])
    if(''.join(POS_LISTdfp[j]).split(' ')[0]=="..ch"):
#        print("yes")
        z=int(''.join(POS_LISTdfp[j]).split(' ')[1],10);
            #POS_0=int((''.join(POS_LISTdfp[j]).split(' ')[1]),10);
            #POS_END=int((''.join(POS_LISTdfp[j]).split(' ')[2]),10);
            #while(POS_0<=POS_END):
        POS_1=int((''.join(POS_LIST[z]).split(' ')[1]),10);
        POS_END1=int((''.join(POS_LIST[z]).split(' ')[2]),10);
        s0="\n.. code-block:: bash\n\t:linenos:\n"
        linep_dfpii2_out[k]=strToList("{0}\n".format(s0));
        k+=1;
#        print(linep_dfpii2_out[k])
        while(POS_1<=POS_END1):
#            print(linep[POS_1])
            linep_dfpii2_out[k] = strToList("\t{0}".format(''.join(linep[POS_1])));
            k+=1;
            POS_1+=1;
        k+=1;
        linep_dfpii2_out[k] = strToList("\n");
        k+=1;
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
    #print(POS_LIST[j])
    if((''.join(POS_LISTdfp[j])[0])== "Z"):
        break;

j=0;k=0;l=0;
stmp = "    Appendix Code chunck\n"
h2=''.join(["="]*len(stmp));
linep_dfpii2code_out[k] = strToList("{0}{1}\n".format(stmp,h2));
k+=1;
#print(linep)

for i in linep_dfpii2code_out:
    k+=1
    if(''.join(POS_LIST[j])[0]=="$"):
#        print("yes")
        #z=int(''.join(POS_LIST[j]).split(' ')[1],10);
            #POS_0=int((''.join(POS_LISTdfp[j]).split(' ')[1]),10);
            #POS_END=int((''.join(POS_LISTdfp[j]).split(' ')[2]),10);
            #while(POS_0<=POS_END):
        l+=1;
        POS_1=int((''.join(POS_LIST[j]).split(' ')[1]),10);
        POS_END1=int((''.join(POS_LIST[j]).split(' ')[2]),10);
        #linep_dfpii2code_out[k]=strToList("   *Chunck #{0}*\n".format(l));
        k+=1;
        stmp = "    Chunck {0}".format(l)
        h3=''.join(["-"]*len(stmp));
        linep_dfpii2code_out[k]=strToList("{0}\n{1}\n".format(stmp,h3));
        k+=1;
        s0=".. code-block:: bash\n\t:linenos:\n"
        linep_dfpii2code_out[k]=strToList("{0}\n".format(s0));
        k+=1;
 #       print("{0} {1}".format(POS_1,POS_END1));
#       print(linep_dfpii2_out[k])
        while(POS_1<=POS_END1):
            linep_dfpii2code_out[k] = strToList("\t{0}".format(''.join(linep[POS_1])));
            k+=1;
            POS_1+=1;
    j+=1;
    #print(POS_LIST[j])
    if((''.join(POS_LIST[j])[0])== "S"):
        break;
        
#print(linep_dfpii2code_out)
j=0
pdir=''.join([os.path.abspath('../'),"/docs/full_discr_pii2.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_dfpii2_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_dfpii2_out[j]));
        #print(content[j])
        j=j+1;
fpii2.close();

j=0;
pdir=''.join([os.path.abspath('../'),"/docs/full_discr_pii2.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_dfpii2_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_dfpii2_out[j]));
        #print(content[j])
        j=j+1;
fpii2.close();

j=0;
pdir=''.join([os.path.abspath('../'),"/docs/only_code_pii2.rst"]);
#pdir="/opt/SAMBA_SHARE/git/BilSrvStation_Server_PC/docs/cut_discr.rst";,encoding='utf-8'
with open(pdir,"wt") as fpii2:
    for i in linep_dfpii2code_out:
        #s0=''.join(content[j]);
        fpii2.write(''.join(linep_dfpii2code_out[j]));
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
