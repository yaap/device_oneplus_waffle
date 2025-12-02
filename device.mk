#
# Copyright (C) 2021-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/configs/audio/resourcemanager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_pineapple/resourcemanager_pineapple_mtp.xml \
    $(LOCAL_PATH)/configs/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2376
TARGET_SCREEN_WIDTH := 1080

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/self_ois.ocfg:$(TARGET_COPY_OUT_ODM)/etc/camera/self_ois.ocfg \
    $(LOCAL_PATH)/configs/camera/config/imx581:$(TARGET_COPY_OUT_ODM)/etc/camera/config/imx581 \
    $(LOCAL_PATH)/configs/camera/config/lyt808:$(TARGET_COPY_OUT_ODM)/etc/camera/config/lyt808 \
    $(LOCAL_PATH)/configs/camera/config/oplus_camera_algo_switch_config:$(TARGET_COPY_OUT_ODM)/etc/camera/config/oplus_camera_algo_switch_config \
    $(LOCAL_PATH)/configs/camera/config/oplus_camera_aps_config:$(TARGET_COPY_OUT_ODM)/etc/camera/config/oplus_camera_aps_config \
    $(LOCAL_PATH)/configs/camera/config/ov64b40_tele:$(TARGET_COPY_OUT_ODM)/etc/camera/config/ov64b40_tele \
    $(LOCAL_PATH)/configs/camera/CameraHWConfiguration.config:$(TARGET_COPY_OUT_ODM)/etc/camera/CameraHWConfiguration.config

# DisplayConfig
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display_id_4630946450791512195.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946450791512195.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    OPlusFrameworksResTarget \
    OPlusSettingsProviderResTarget \
    OPlusSettingsResTarget \
    OPlusSystemUIResTarget \
    OPlusWifiResTarget

# Sensors
$(call soong_config_set,oplus_sensors,uses_nextgen_fusion_sensor,true)
$(call soong_config_set,oplus_sensors,wrapped_lib_name,sensors.qsh.so)
PRODUCT_PACKAGES += \
    vendor.lineage.oplus_als.service \
    sensors.wrapper

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm8650-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/waffle/waffle-vendor.mk)
