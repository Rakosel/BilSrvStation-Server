#!/bin/bash
# https://framagit.org/fiat-tux/hat-softwares/preseed-creator/-/blob/master/preseed_creator.sh
function usage {
    cat <<EOF
Preseed Creator (c) Luc Didry 2017, WTFPL
./preseed_creator.sh [options]
    Options:
        -i <image.iso>              ISO image to preseed. If not provided, the script will download and use the latest Debian amd64 netinst ISO image
        -o <preseeded_image.iso>    output preseeded ISO image. Default to preseed_creator/debian-netinst-latest-preseed.ISO
        -p <preseed_file.cfg>       preseed file. If not provided, the script will put "d-i debian-installer/locale string fr_FR" in the preseed.cfg file
        -x                          Use xorriso instead of genisoimage, to create an iso-hybrid
        -d                          download the latest Debian amd64 netinst ISO image in the current folder
        -g                          download the latest Debian stable example preseed file into preseed_example.cfg and exit
        -h                          print this help and exit
EOF
    exit
}

function download_latest_iso {
    ONLY_DOWNLOAD=$1
	LOCK="1";
	INPUT1="debian-netinst-latest.iso"
    INPUT1="${MYPWD}/preseed_creator/${INPUT1}"
	
		
	if [[ $ONLY_DOWNLOAD == 1 && -f "$INPUT1" ]]; then
		echo "file exists."
#		ONLY_DOWNLOAD = 1;
#		exit 0;
	else
#		rm -Rf ${MYPWD}/preseed_creator
		LOCK="";
		echo "file not exists."
	fi	
#	echo -e "\n dli $ONLY_DOWNLOAD $LOCK"
if [[ $ONLY_DOWNLOAD == 1 && -n "$LOCK" ]]; then
 echo -ne "Getting Debian GPG keys                     [>                             ](0%)\r"
fi
	
    if [[ $ONLY_DOWNLOAD == 1 && -n "$LOCK" ]];
    then
        echo -ne 'Getting Debian GPG keys                     [========>                     ](25%)\r'
    else
        echo -ne 'Getting Debian GPG keys                     [>                             ](0%)\r'
	fi
	
    for i in F41D30342F3546695F65C66942468F4009EA8AC3 DF9B9C49EAA9298432589D76DA87E80D6294BE9B 10460DAD76165AD81FBC0CE9988021A964E6EA7D
    do
        gpg --list-keys $i > /dev/null 2>&1
        if [ $? != 0 ]
        then
            gpg --keyserver keyring.debian.org --recv-keys 0x$i > /dev/null 2>&1
        fi
    done

    if [[ $ONLY_DOWNLOAD == 1 && -n "$LOCK" ]];
    then
        echo -ne 'Downloading latest Debian amd64 netinst ISO [==============>               ](50%)\r'
    else
        echo -ne 'Downloading latest Debian amd64 netinst ISO [===>                          ](10%)\r'
    
    export LATEST=$(wget -q -O - https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/ | grep "netinst.iso" | grep -v "debian-mac" | grep -v "debian-edu" | sed -e 's@.*a href="\([^"]*\)".*@\1@')
    wget -q https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$LATEST -O debian-netinst-latest.iso

    wget -q https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS -O SHA512SUMS
    wget -q https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS.sign -O SHA512SUMS.sign
	fi
	
    if [[ $ONLY_DOWNLOAD == 1 && -n "$LOCK" ]];
    then
        echo -ne 'Verifying GPG signature                     [======================>       ](75%)\r'
    else
        echo -ne 'Verifying GPG signature                     [======>                       ](20%)\r'
    gpg --verify SHA512SUMS.sign SHA512SUMS > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        echo "Bad SHA512SUMS GPG signature. Aborting\r\n"
        exit 1
		fi
    fi

if [[ $ONLY_DOWNLOAD == 1 && -n "$LOCK" ]];
    then
        echo -ne 'Veryfying sha512sum                         [=============================>](100%)\r'
    else
        echo -ne 'Veryfying sha512sum                         [=========>                    ](30%)\r'
	sed -e "s@${LATEST}@debian-netinst-latest.iso@" -i SHA512SUMS
    sha512sum --ignore-missing -c SHA512SUMS > /dev/null 2>&1
   
    if [ $? -ne 0 ]
    then
        echo "Bad ISO checksum. Aborting\r\n"
        exit 1
    fi
fi
    #if [ $ONLY_DOWNLOAD == 1 ]
    #then
   #     exit 0
    #fi
}

INPUT=""
PRESEED=""
POSTINSTALL=""
MYPWD=$(pwd)
OUTPUT=""
XORRISO=""
while getopts ":i:o:p:s:xdgh" opt; do
    case $opt in
        i)
            INPUT=$OPTARG
            ;;
        o)
            OUTPUT=$OPTARG
            ;;
        p)
            PRESEED=$OPTARG
            ;;
        s)
            POSTINSTALL=$OPTARG
            ;;
        x)
            XORRISO='yes'
            ;;
        d)
            echo "Downloading latest Debian amd64 netinst ISO image\r\n"
            download_latest_iso 1
            ;;
        g)
            echo "Downloading latest Debian stable example preseed file into preseed_example.cfg\r\n"
            wget -q http://www.debian.org/releases/stable/example-preseed.txt -O preseed_example.cfg
            echo "Done\r\n"
            exit
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG\r\n" >&2
            usage
            ;;
    esac
done

rm -Rf "${MYPWD}/preseed_creator/irmod" 
rm -Rf "${MYPWD}/preseed_creator/cd" 

#exit 1;

mkdir preseed_creator -p
cd preseed_creator

if [[ ! -z $POSTINSTALL ]]
then
    if [ ${POSTINSTALL:0:1} != / ]
    then
        POSTINSTALL="${MYPWD}/${POSTINSTALL}"
    fi
    if [[ ! -e $POSTINSTALL ]]
    then
        echo "$POSTINSTALL does not exists. Aborting\r\n"
        exit 1
    fi
    if [[ ! -r $POSTINSTALL ]]
    then
        echo "$POSTINSTALL is not readable. Aborting\r\n"
        exit 1
    fi
fi

if [[ ! -z $PRESEED ]]
then
    if [ ${PRESEED:0:1} != / ]
    then
        PRESEED="${MYPWD}/${PRESEED}"
    fi
    if [[ ! -e $PRESEED ]]
    then
        echo "$PRESEED does not exists. Aborting\r\n"
        exit 1
    fi
    if [[ ! -r $PRESEED ]]
    then
        echo "$PRESEED is not readable. Aborting\r\n"
        exit 1
    fi
fi

if [[ ! -z $OUTPUT ]]
then
    if [ ${OUTPUT:0:1} != / ]
    then
        OUTPUT="${MYPWD}/${OUTPUT}"
    fi
else
    OUTPUT="debian-netinst-latest-preseed.iso"
fi

if [[ -z $INPUT ]]
then
    echo "No ISO image provided, will download the latest Debian amd64 netinst ISO image\r\n"
    download_latest_iso 1

    INPUT="debian-netinst-latest.iso"
else
    if [ ${INPUT:0:1} != / ]
    then
        INPUT="${MYPWD}/${INPUT}"
    fi
    if [[ ! -e $INPUT ]]
    then
        echo "$INPUT does not exists. Aborting\r\n"
        exit 1
    fi
    if [[ ! -r $INPUT ]]
    then
        echo "$INPUT is not readable. Aborting\r\n"
        exit 1
    fi
fi

echo -ne 'Mounting ISO image                          [===========>                  ](40%)\r'
mkdir loopdir -p
mount -o loop $INPUT loopdir > /dev/null 2>&1
if [ $? -ne 0 ]
then
    echo -e "Error while mounting the ISO image. Aborting $?\r\n"
    exit 1
fi

mkdir cd
echo -ne 'Extracting ISO image                        [==============>               ](50%)\r'
rsync -a -H --exclude=TRANS.TBL loopdir/ cd
echo -ne 'Umounting ISO image                         [=================>            ](60%)\r\n'
umount loopdir
rmdir loopdir

echo -ne 'Hacking initrd     [====================>         ](70%)\r\n'
#echo -e "ws $INPUT ${INPUT} ${MYPWD}  /  ${INPUT}\r\n"
#mkdir "$MYPWD/preseed_creator/irmod/install/"

mkdir irmod -p
cd irmod
gzip -d < ../cd/install.amd/initrd.gz | cpio --extract --make-directories --no-absolute-filenames 2>/dev/null
if [ $? -ne 0 ]
then
    echo "Error while getting ../cd/install.amd/initrd.gz content. Aborting"
    exit 1
fi

cp -Rf "$MYPWD/install_ext/install/" "$MYPWD/preseed_creator/irmod/install/"
if [ $? -ne 0 ]; then
   echo "Copy ext files Aborting"
   exit 1
fi
mv -f "$MYPWD/preseed_creator/irmod/install/lib" "$MYPWD/preseed_creator/irmod/lib/"
if [ $? -ne 0 ]; then
   echo "rm ext files lib Aborting"
   exit 1
fi

echo -ne 'Disable menu graphic installer              [=======================>      ](80%)\r\n'
sed -i 's/include gtk.cfg//g' ../cd/isolinux/menu.cfg 2>/dev/null
if [ $? -ne 0 ]
then
    echo "Error while disabling graphic menu installer in ../cd/isolinux/isolinux.cfg. Aborting"
    exit 1
fi

#mkdir install -p
#cp $POSTINSTALL install/postinstall.sh
#echo -e "\n now {$MYPWD} cp "
#ls -la

#exit 1;

if [[ -z $PRESEED ]]
then
#   echo "d-i debian-installer/locale string en_US" > preseed.cfg
	cp "$MYPWD/preseed.cfg" "$MYPWD/preseed_creator/irmod/preseed.cfg"
	PRESEED="preseed.cfg"
#echo -e "\n d-i debian-installer/locale"
else
    cp $PRESEED preseed.cfg
fi


if [[ ! -f "$PRESEED" ]]; then
	echo "file pressed.cfg not exists!";
	exit 1;
fi
#exit 1

echo -ne 'Packing files in initrd.gz \r\n'
find . | cpio -H newc --create 2>/dev/null | gzip -9 > ../cd/install.amd/initrd.gz 2>/dev/null
#gzip -c -9 find. > ../cd/install.amd/initrd.gz 2>/dev/null
if [ $? -ne 0 ]
then
    echo "Error while putting new content into ../cd/install.amd/initrd.gz. Aborting"
    exit 1
fi
#exit 1;
cd ../
rm -rf irmod/

echo -ne 'Fixing md5sums                              [========================>     ](85%)\r'
cd cd


md5sum `find -follow -type f 2>/dev/null` > md5sum.txt 2>/dev/null
if [ $? -ne 0 ]
then
    echo "Error while fixing md5sums. Aborting"
#exit 1
fi
#exit 1
cd ..

cp -Rf "$MYPWD/install_ext/home/" "$MYPWD/preseed_creator/cd/install/"
if [ $? -ne 0 ]; then
   echo "Copy ext files in cd Aborting"
   exit 1
fi

cp -Rf "$MYPWD/dep11/" "$MYPWD/preseed_creator/cd/firmware/"
if [ $? -ne 0 ]; then
   echo "Copy ext files dep11 in cd Aborting"
   exit 1
fi

echo -ne 'Creating preseeded ISO image                [==========================>   ](90%)\r'
#exit 1;
if [[ -z $XORRISO ]]
then
echo -ne 'Create iso by genisoimage tool\r'
#genisoimage -quiet -o $OUTPUT -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat ./cd > /dev/null 2>&1 -f 

genisoimage -o $OUTPUT -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat ./cd > /dev/null 2>&1

else
echo -ne 'Create iso by xorriso -as mkisofs tool\r'
	xorriso -as mkisofs \
		-quiet \
		-o $OUTPUT \
		-isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
		-c isolinux/boot.cat \
		-b isolinux/isolinux.bin \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		-eltorito-alt-boot \
		-e boot/grub/efi.img \
		-no-emul-boot \
		-isohybrid-gpt-basdat \
		./cd /dev/null 2>$1
fi

if [ $? -ne 0 ]
then
    echo "Error while creating the preseeded ISO image. Aborting"
    exit 1
fi

rm -rf cd

echo -ne 'Preseeded ISO image created                 [==============================](100%)\r'
echo -e "\nYour preseeded ISO image is located at $OUTPUT"

