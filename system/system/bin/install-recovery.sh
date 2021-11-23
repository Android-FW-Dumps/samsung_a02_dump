#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):25165824:d6008fc8b4f73acb67a2df00249cadf2835974be; then
  applypatch \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):25165824:31f16bf2b05c3c9d56d4e1e59bb6ed520d84a94b \
          --target EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):25165824:d6008fc8b4f73acb67a2df00249cadf2835974be && \
      log -t install_recovery "Installing new recovery image: succeeded" || \
      echo 454 > /cache/fota/fota.status
else
  log -t install_recovery "Recovery image already installed"
fi

if [ -e /cache/recovery/command ] ; then
  PACKAGE_PATH=""
  SEARCH_COMMAND="--update_package"
  PATH_POS=16
  if [ -e '/system/bin/grep' ] ; then
    PACKAGE_PATH=`cat /cache/recovery/command | grep 'update_package'`
    PACKAGE_ORG_PATH=`cat /cache/recovery/command | grep 'update_org_package'`
    if [ "$PACKAGE_ORG_PATH" != "" ] ; then
      PACKAGE_PATH=$PACKAGE_ORG_PATH
      SEARCH_COMMAND="--update_org_package"
      PATH_POS=20
    fi
    if [ -e /cache/recovery/saved ] ; then
      rm -rf /cache/recovery/saved
    fi

    if [ -e /data/.recovery/saved ] ; then
      rm -rf /data/.recovery/saved
    fi
  fi
  if [ "$PACKAGE_PATH" != "" ] ; then
    for PACKAGE_LINE in $PACKAGE_PATH
    do
      if [ ${PACKAGE_LINE:0:$PATH_POS} == $SEARCH_COMMAND ] ; then
        break
      fi
    done
    let PATH_POS+=1
    PACKAGE_PATH=${PACKAGE_LINE:$PATH_POS}
    if [ "${PACKAGE_PATH:0:7}" == "@/cache" ] ; then
      if [ -e /cache/recovery/uncrypt_file ] ; then
        UNCRYPT_PACKAGE_PATH=`cat /cache/recovery/uncrypt_file`
        PACKAGE_PATH=$UNCRYPT_PACKAGE_PATH
        echo "The delta path is changed by uncrypt_file" >> /cache/fota/install_recovery.log
      fi
    fi
  fi
  log -t install_recovery "PACKAGE_PATH : ${PACKAGE_PATH}"
  if [ "$PACKAGE_PATH" != "" ] ; then
    rm -rf $PACKAGE_PATH
    log -t install_recovery "tried to remove the delta"
    echo "tried to remove the delta" >> /cache/fota/install_recovery.log
    if [ -e "$PACKAGE_PATH" ]; then
      log -t install_recovery "The delta was not removed in install-recovery.sh"
      echo "The delta was not removed in install-recovery.sh" >> /cache/fota/install_recovery.log
    else
      log -t install_recovery "The delta was removed in install-recovery.sh"
      echo "The delta was removed in install-recovery.sh" >> /cache/fota/install_recovery.log
    fi
  fi
  if [ "${PACKAGE_PATH:0:5}" == "/data" ] ; then
    echo $PACKAGE_PATH > /cache/fota/fota_path_command
    chown system:system /cache/fota/fota_path_command
  fi
  chown system:system /cache/fota/install_recovery.log
  rm -rf /cache/recovery/command
fi

