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

# SDClang configuration
SDCLANG := true

TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_NO_KERNEL := false
BOARD_PRESIL_BUILD := true
-include $(QCPATH)/common/sdm845/BoardConfigVendor.mk
MINIMAL_FONT_FOOTPRINT := true

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := false
BOARD_USES_WIPOWER := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

# Defines for enabling A/B builds
AB_OTA_UPDATER := true
# Full A/B partition update set
# AB_OTA_PARTITIONS := xbl rpm tz hyp pmic modem abl boot keymaster cmnlib cmnlib64 system bluetooth

# Minimum partition set for automation to test recovery generation code
# Packages generated by using just the below flag cannot be used for updating a device. You must pass
# in the full set mentioned above as part of your make commandline
AB_OTA_PARTITIONS ?= boot system
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_ROOT := true

#Enable compilation of oem-extensions to recovery
#These need to be explicitly 
ifneq ($(AB_OTA_UPDATER),true)
    TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_msm
endif

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3221225472
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := false
TARGET_USES_DRM_PP := true

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA84000 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.selinux=permissive video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1

BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096

BOARD_USES_GENERIC_AUDIO := true
BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2
TARGET_KERNEL_APPEND_DTB := true
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
TARGET_USES_HWC2 := true
