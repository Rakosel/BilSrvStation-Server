#!/usr/bin/python3
# -*- coding: utf-8 -*-
# version v.1.1a
# https://en.wikipedia.org/wiki/Shebang_(Unix) #!/usr/bin/env python3\
import sys,os,re;
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
    
pdir=''.join([os.getcwd(),"/DebianISO/install_ext/install/pii2.sh"]);
#print(pdir);
##
# "r" - Read - Default value. Opens a file for reading, error if the file does not exist
# "a" - Append - Opens a file for appending, creates the file if it does not exist
# "w" - Write - Opens a file for writing, creates the file if it does not exist
# "x" - Create - Creates the specified file, returns an error if the file exists
# In addition you can specify if the file should be handled as binary or text mode
# "t" - Text - Default value. Text mode
if not (os.path.exists(pdir)):
    print("The file does not exist");
    exit;

with open(pdir,"rt") as fpii2:
    linep = fpii2.readlines();
fpii2.close();
j=0;
if(str(''.join(re.findall('^#!\/bin\/(.*)', linep[j])).strip())=="bash"):
        print("bash!")
else:
        print("Error: Unknown shell!")
j=1;
for i in linep:
    linep[j] = re.sub('\n', '', linep[j])
    if ((''.join(re.findall("^#", linep[j])))=="#"):
        s0=''.join(re.findall("#\t\t\t(\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[j]));
        s1='\t'.join(re.findall("#\t\t\t(\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[j]));
        s2='\t\t'.join(re.findall("#\t\t\t(\d.\d.\d+\t+[a-zA-Z/_\-&><=$%\[\]* ]*)", linep[j]));
    if(s0!="" or s1!="" or s2!=""):    
        print("{0}{1}{2}".format(s0,s1,s2))
    linep[j] = re.sub('#<--!|#!-->', '', linep[j]);
    #if (''.join(re.findall("#\t\t\t(\d.\d.\d\.+.*)$", linep[j]))!=""):
    #print(''.join(re.findall("#\t\t\t\d.\d.(\d.\d.+.*)", linep[j])));
    j+=1;
    if(j>=len(linep)):
        break;

j=0;
for i in linep:
    print(linep[j]);
    j+=1;
    if(j>=len(linep)):
        break;

#print(re.sub("\t", " ",linep[j]));
#        print("yes");

print(linep[20])


print(re.findall("#\t\t\t(\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[20]))
print(re.findall("#\t\t\t(\d.\d.\d+\t+[a-zA-Z/_\-& ]*)", linep[193]))


str = re.findall("#\t\t\t(.*)$", linep[22])
str1 = re.sub("\t", " ",linep[22])
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
