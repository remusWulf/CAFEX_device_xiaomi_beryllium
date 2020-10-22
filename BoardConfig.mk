# config.mk
#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := sdm845
TARGET_BOOTLOADER_BOARD_NAME := sdm845

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true
TARGET_NO_KERNEL := false

-include vendor/qcom/prebuilt/sdm845/BoardConfigVendor.mk
-include $(QCPATH)/common/sdm845/BoardConfigVendor.mk

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
BOARD_USES_WIPOWER := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

# Metadata partition (applicable only for new launches)
ifeq ($(SHIPPING_API_LEVEL),29)
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_USES_METADATA_PARTITION := true
endif

#Enable compilation of oem-extensions to recovery
#These need to be explicitly
ifneq ($(AB_OTA_UPDATER),true)
    TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_msm
endif

ifeq ($(SHIPPING_API_LEVEL),29)
  BOARD_SYSTEMSDK_VERSIONS:=29
else
  BOARD_SYSTEMSDK_VERSIONS:=28
endif

#Enable Charging Icon
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

#Enable split vendor image
ENABLE_VENDOR_IMAGE := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := false

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

BOARD_USES_GENERIC_AUDIO := true
TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

TARGET_COMPILE_WITH_MSM_KERNEL := true

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

TARGET_USES_GRALLOC1 := true

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

#Enable QTI specific Camera2Client layer
TARGET_USES_QTI_CAMERA2CLIENT := true

#Add non-hlos files to ota packages
ADD_RADIO_FILES := true

#To use libhealthd.msm instead of libhealthd.default
BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm

#Enable INTERACTION_BOOST
#TARGET_USES_INTERACTION_BOOST := true

ifeq ($(ENABLE_VENDOR_IMAGE), false)
$(error "Vendor Image is mandatory !!")
endif

#Enable DRM plugins 64 bit compilation
TARGET_ENABLE_MEDIADRM_64 := true

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include device/qcom/wlan/skunk/BoardConfigWlan.mk
endif

BOARD_VNDK_VERSION:= current
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PHONY_TARGETS := true


#################################################################################
# This is the End of BoardConfig.mk file.
# Now, Pickup other split Board.mk files:
#################################################################################
# TODO: Relocate the system Board.mk files pickup into qssi lunch, once it is up.
-include vendor/qcom/defs/board-defs/system/*.mk
-include vendor/qcom/defs/board-defs/vendor/*.mk
#################################################################################
