#!/bin/bash

maintainer="EAZY BLACK"                                                        # Here we get the name of maintainer
path=.     # Here you will need to specify the path to the crDroid source code folder
echo Enter Device Codename
read device
echo Enter OEM
read oem
echo Enter Device Name
read devicename
time=$(cat $path/out/build_date.txt)                                                        # Here we get the build time
zip=$(basename $path/out/target/product/$device/lineage-16.0-*-UNOFFICIAL-$device.zip)        # Here we get the package name with the extension .zip
nozip=$(basename $path/out/target/product/$device/lineage-16.0-*-UNOFFICIAL-$device.zip .zip) # Here we get the package name without the extension .zip
date=$(echo $zip | cut -f3 -d '-')                                                          # Here we get the build date (in YYYY-MM-DD format)


buildtype="Monthly"                          # choose from Testing/Alpha/Beta/Weekly/Monthly
forum="https://t.me/Redmi3IDO"   # https link (mandatory)
gapps="https://sourceforge.net/projects/flamegapps/files/arm64/android-9/2021-08-01/FlameGApps-9.0-basic-arm64-20210801.zip/download" #https link (leave empty if unused)
firmware=""                                  # https link (leave empty if unused)
modem=""                                     # https link (leave empty if unused)
bootloader=""                                # https link (leave empty if unused)
recovery=""                                  # https link (leave empty if unused)
paypal=""            # https link (leave empty if unused)
telegram="https://t.me/eazy_black" # https link (leave empty if unused)

#don't modify from here
zip_name=$path/out/target/product/$device/$zip
buildprop=$path/out/target/product/$device/system/build.prop

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
md5=`md5sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
version=`echo "$zip_only" | cut -d'-' -f5`
v_max=`echo "$version" | cut -d'.' -f1 | cut -d'v' -f2`
v_min=`echo "$version" | cut -d'.' -f2`
version=`echo $v_max.$v_min`

echo '{
  "response": [
    {
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$devicename'",
        "filename": "'$zip_only'",
        "download": "https://github.com/EAZYBLACK/romOTA/releases/download/'$nozip'/'$zip'",
        "timestamp": '$timestamp',
        "md5": "'$md5'",
        "size": '$size',
        "version": "'$version'",
        "buildtype": "'$buildtype'",
        "forum": "'$forum'",
        "gapps": "'$gapps'",
        "firmware": "'$firmware'",
        "modem": "'$modem'",
        "bootloader": "'$bootloader'",
        "recovery": "'$recovery'",
        "paypal": "'$paypal'",
        "telegram": "'$telegram'"
    }
  ]
}' > $device.json
