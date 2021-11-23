#!/bin/bash

cat product/app/Gmail2/oat/arm/Gmail2.odex.* 2>/dev/null >> product/app/Gmail2/oat/arm/Gmail2.odex
rm -f product/app/Gmail2/oat/arm/Gmail2.odex.* 2>/dev/null
cat product/app/Maps/oat/arm/Maps.odex.* 2>/dev/null >> product/app/Maps/oat/arm/Maps.odex
rm -f product/app/Maps/oat/arm/Maps.odex.* 2>/dev/null
cat product/app/Maps/Maps.apk.* 2>/dev/null >> product/app/Maps/Maps.apk
rm -f product/app/Maps/Maps.apk.* 2>/dev/null
cat product/priv-app/Velvet/Velvet.apk.* 2>/dev/null >> product/priv-app/Velvet/Velvet.apk
rm -f product/priv-app/Velvet/Velvet.apk.* 2>/dev/null
cat product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null >> product/priv-app/GmsCore/GmsCore.apk
rm -f product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null
cat system/system/priv-app/OneDrive_Samsung_v3/OneDrive_Samsung_v3.apk.* 2>/dev/null >> system/system/priv-app/OneDrive_Samsung_v3/OneDrive_Samsung_v3.apk
rm -f system/system/priv-app/OneDrive_Samsung_v3/OneDrive_Samsung_v3.apk.* 2>/dev/null
cat system/system/priv-app/SecSettings/SecSettings.apk.* 2>/dev/null >> system/system/priv-app/SecSettings/SecSettings.apk
rm -f system/system/priv-app/SecSettings/SecSettings.apk.* 2>/dev/null
