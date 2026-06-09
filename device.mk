#
# Copyright (C) 2021-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Alert slider
PRODUCT_PACKAGES += \
    KeyHandler \
    tri-state-key-calibrate

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

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

# Display
$(call soong_config_set,qtidisplay,bitclk_rate_permissive,true)
$(call soong_config_set,surfaceflinger,frame_rate_category_high,120)
$(call soong_config_set,surfaceflinger,frame_rate_category_min,10)
$(call soong_config_set,surfaceflinger,arr_use_oplus_ltpo_rates,true)
$(call soong_config_set,qtidisplay,sm8650_pxlw_vendor_namespace,vendor/oneplus/waffle)
$(call soong_config_set,qtidisplay,sm8650_pxlw_hw_iris7,true)

# DisplayConfig
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display_id_4630946450791512195.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946450791512195.xml

# Fingerprint
$(call soong_config_set_bool,qtidisplay,oplus_udfps,true)

# OpenDelta
ifeq ($(TARGET_BUILD_GAPPS),true)
    PRODUCT_PACKAGES += op8650OpenDeltaOverlay
else
    PRODUCT_PACKAGES += op8650OpenDeltaOverlayVanilla
endif

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage \
    $(LOCAL_PATH)/overlay-yaap

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

# Regional properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/22825/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/22825/build.default.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/22877/build.EU.prop:$(TARGET_COPY_OUT_ODM)/etc/22877/build.EU.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/22877/build.IN.prop:$(TARGET_COPY_OUT_ODM)/etc/22877/build.IN.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/22877/build.NA.prop:$(TARGET_COPY_OUT_ODM)/etc/22877/build.NA.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/22877/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/22877/build.default.prop

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Telephony
PRODUCT_PACKAGES += \
    OplusEuicc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf


# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

$(call soong_config_set,qti_vibrator,use_effect_stream,true)
$(call soong_config_set,qti_vibrator,use_effect_stream_strength,true)
$(call soong_config_set,qti_vibrator,use_primitive_effect_stream,true)
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.oplus_sm8650-richtap)

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm8650-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/waffle/waffle-vendor.mk)
