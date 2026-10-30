/*
 * SPDX-FileCopyrightText: 2026 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <iterator>

#include <LvacfsProfileConfig.h>

#include "LvacfsProfiles.h"

namespace lvacfs {

inline int selectProfile(const Capture& capture) {
    namespace p = ::lvacfs::profiles::config_2mic;

    const bool builtin = capture.device == AUDIO_DEVICE_IN_BUILTIN_MIC ||
                         capture.device == AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET;
    const bool wired = capture.device == AUDIO_DEVICE_IN_WIRED_HEADSET;
    const bool usb = capture.device == AUDIO_DEVICE_IN_USB_ACCESSORY ||
                     capture.device == AUDIO_DEVICE_IN_USB_DEVICE ||
                     capture.device == AUDIO_DEVICE_IN_USB_HEADSET;

    if (!builtin && !wired && !usb) {
        return -1;
    }

    if (capture.source == AUDIO_SOURCE_CAMCORDER &&
        (capture.channels == 3 || capture.channels == 4)) {
        // Three-mic capture selects its profile from the vendor effect type.
        static constexpr int kThreeMicProfiles[] = {
                p::MIC_NORMAL_ID0, p::MIC_NORMAL, p::MIC_APP1, p::MIC_APP2,
                -1,                p::MIC_NORMAL_ID0, p::MIC_NORMAL,
        };
        if (capture.effect_type < 0 ||
            capture.effect_type >= static_cast<int>(std::size(kThreeMicProfiles))) {
            return -1;
        }
        return kThreeMicProfiles[capture.effect_type];
    }

    switch (capture.scene) {
        case Scene::INTERVIEW:
            return builtin ? p::MIC_INTERVIEW : p::HE_INTERVIEW;
        case Scene::CONFERENCE:
            return builtin ? p::MIC_CONFERENCE : p::HE_CONFERENCE;
        case Scene::APP1:
            if (capture.source == AUDIO_SOURCE_MIC && capture.sample_rate == 16000) {
                return builtin ? p::MIC_APP1 : usb ? p::USB_APP1 : p::HE_APP1;
            }
            break;
        default:
            break;
    }

    switch (capture.source) {
        case AUDIO_SOURCE_CAMCORDER:
            return builtin ? p::MIC_CAM : p::HE_CAM;
        case AUDIO_SOURCE_VOICE_RECOGNITION:
            return builtin ? p::MIC_VR : p::HE_VR;
        default:
            return builtin ? p::MIC_NORMAL : usb ? p::USB_NORMAL : p::HE;
    }
}

}  // namespace lvacfs
