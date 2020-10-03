# Default A/B configuration.
# By default this target is OTA config, so set the default shipping
# level to 28 (if not set explicitly earlier)
SHIPPING_API_LEVEL ?= 28
# Enable Dynamic partitions only for Q new launch devices
ifeq ($(SHIPPING_API_LEVEL),29)
  BOARD_DYNAMIC_PARTITION_ENABLE := true
  PRODUCT_SHIPPING_API_LEVEL := 29
else ifeq ($(SHIPPING_API_LEVEL),28)
  BOARD_DYNAMIC_PARTITION_ENABLE := false
  $(call inherit-product, build/make/target/product/product_launched_with_p.mk)
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
endif

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    Settings \
    SystemUI

# For QSSI builds, we skip building the system image. Instead we build the
# "non-system" images (that we support).
PRODUCT_BUILD_SYSTEM_IMAGE := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true
PRODUCT_BUILD_PRODUCT_IMAGE := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := true
PRODUCT_BUILD_USERDATA_IMAGE := true

# privapp-permissions whitelisting
PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=log

TARGET_DEFINES_DALVIK_HEAP := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
$(call inherit-product, device/qcom/vendor-common/common64.mk)
#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
  dalvik.vm.heapstartsize=8m \
  dalvik.vm.heapsize=512m \
  dalvik.vm.heaptargetutilization=0.75 \
  dalvik.vm.heapminfree=512k \
  dalvik.vm.heapmaxfree=8m

# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
  ro.opengles.version=196610

PRODUCT_NAME := sdm845
PRODUCT_DEVICE := sdm845
PRODUCT_BRAND := qti
PRODUCT_MODEL := SDM845 for arm64

#Initial bringup flags
TARGET_USES_AOSP := false
TARGET_USES_AOSP_FOR_AUDIO := false
TARGET_USES_QCOM_BSP := false

# RRO configuration
TARGET_USES_RRO := true

TARGET_KERNEL_VERSION := 4.9

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

-include $(QCPATH)/common/config/qtic-config.mk

PRODUCT_BOOT_JARS += tcmiface

#ifneq ($(strip $(QCPATH)),)
#    PRODUCT_BOOT_JARS += WfdCommon
#endif

# TODO(b/123770188): boot JAR should not depend on /product module
#PRODUCT_BOOT_JARS += vendor.qti.voiceprint-V1.0-java

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

# Fingerprint
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-service.xiaomi_sdm845.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service.xiaomi_sdm845.rc


#Audio configuration files
-include $(TOPDIR)hardware/qcom/audio/configs/sdm845/sdm845.mk
USE_CUSTOM_AUDIO_POLICY := 0
USE_LIB_PROCESS_GROUP := true

-include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/sdm845/sdm845.mk

PRODUCT_PACKAGES += fs_config_files


DEVICE_MANIFEST_FILE := device/qcom/sdm845/manifest.xml
ifeq ($(ENABLE_AB), true)
DEVICE_MANIFEST_FILE += device/qcom/sdm845/manifest_ab.xml
endif
DEVICE_MATRIX_FILE   := device/qcom/common/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/qcom/sdm845/framework_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml


#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service \
    android.hardware.broadcastradio@1.0-impl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.xiaomi_sdm845

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service \

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/sdm845-tavil-snd-card_Button_Jack.kl:system/usr/keylayout/sdm845-tavil-snd-card_Button_Jack.kl

# Context hub HAL
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

# FBE support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:system/etc/permissions/android.software.verified_boot.xml

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += device/qcom/sdm845/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Powerhint configuration file
PRODUCT_COPY_FILES += device/qcom/sdm845/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

PRODUCT_PACKAGES += \
		    android.hardware.usb@1.0-service

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# High performance VR feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.high_performance.xml

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

#Enable full treble flag

#Add soft home, back and multitask keys
PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=0

# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
    ro.opengles.version=196610

#system prop for bluetooth SOC type
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=cherokee

# Radio power saving
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.add_power_save=1

PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true

ifneq ($(strip $(TARGET_USES_RRO)),true)
DEVICE_PACKAGE_OVERLAYS += device/qcom/sdm845/overlay
endif

#VR
PRODUCT_PACKAGES += android.hardware.vr@1.0-impl \
                    android.hardware.vr@1.0-service

TARGET_SCVE_DISABLED := true
#TARGET_USES_QTIC := false
#TARGET_USES_QTIC_EXTENSION := false

SDM845_DISABLE_MODULE := true

# Enable vndk-sp Libraries
PRODUCT_PACKAGES += vndk_package

PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE:=true

#Enable WIFI AWARE FEATURE
WIFI_HIDL_FEATURE_AWARE := true

# Enable STA + SAP Concurrency.
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

# Enable SAP + SAP Feature.
QC_WIFI_HIDL_FEATURE_DUAL_AP := true

TARGET_USES_MKE2FS := true

TARGET_MOUNT_POINTS_SYMLINKS := false

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
include device/qcom/wlan/skunk/wlan.mk

#BT
TARGET_USE_QTI_BT_STACK := true

ifeq ($(TARGET_USE_QTI_BT_STACK), true)
BT := com.qualcomm.qti.bluetooth_audio@1.0-impl
BT += com.qualcomm.qti.bluetooth_audio@1.0
endif

#vendor prop to disable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=false

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
# TODO: Relocate the system product.mk files pickup into qssi lunch, once it is up.
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/system/*.mk)
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/vendor/*.mk)
###################################################################################
