#!/bin/bash

#Generate application uninstallers for macOS.

#Parameters
DATE=`date +%Y-%m-%d`
TIME=`date +%H:%M:%S`
LOG_PREFIX="[$DATE $TIME]"

#Functions
log_info() {
    echo "${LOG_PREFIX}[INFO]" $1
}

log_warn() {
    echo "${LOG_PREFIX}[WARN]" $1
}

log_error() {
    echo "${LOG_PREFIX}[ERROR]" $1
}

#Check running user
if (( $EUID != 0 )); then
    echo "Please run as root."
    exit
fi

echo "Welcome to Application Uninstaller"
echo "The following packages will be REMOVED:"
echo "  __PRODUCT__-__VERSION__"
while true; do
    read -p "Do you wish to continue [Y/n]?" answer
    [[ $answer == "y" || $answer == "Y" || $answer == "" ]] && break
    [[ $answer == "n" || $answer == "N" ]] && exit 0
    echo "Please answer with 'y' or 'n'"
done


#Need to replace these with install preparation script
VERSION=__VERSION__
PRODUCT=__PRODUCT__

echo "Application uninstalling process started"
# remove link to shorcut file
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/arm/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/openocd/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/libusb-compat/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/libftdi/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/hidapi/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files
bin_files=$(echo $(ls /Library/${PRODUCT}/${VERSION}/capstone/bin) | sed 's/[^ ]* */\/usr\/local\/bin\/&/g')
rm -f $bin_files

rm -f /usr/local/share/openocd
rm -f /usr/local/opt/libusb
rm -f /usr/local/opt/libusb-compat
rm -f /usr/local/opt/libftdi
rm -f /usr/local/opt/hidapi
rm -f /usr/local/opt/capstone
rm -f /usr/local/include/libusb
rm -f /usr/local/include/libusb-compat
rm -f /usr/local/include/libftdi
rm -f /usr/local/include/hidapi
rm -f /usr/local/include/capstone
echo "[1/3] [DONE] Successfully deleted shortcut links"


#forget from pkgutil
pkgutil --forget "org.$PRODUCT.$VERSION" > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "[2/3] [DONE] Successfully deleted application informations"
else
  echo "[2/3] [ERROR] Could not delete application informations" >&2
fi

#remove application source distribution
[ -e "/Library/${PRODUCT}/${VERSION}" ] && rm -rf "/Library/${PRODUCT}/${VERSION}"
if [ $? -eq 0 ]
then
  echo "[3/3] [DONE] Successfully deleted application"
else
  echo "[3/3] [ERROR] Could not delete application" >&2
fi

echo "Application uninstall process finished"
exit 0
