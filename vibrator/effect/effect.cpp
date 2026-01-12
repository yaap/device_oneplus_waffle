/*
 * Copyright (c) 2020, The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Changes from Qualcomm Innovation Center are provided under the following license:
 * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause-Clear
 */

#include "effect.h"

#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*(a)))

#include "generated_effect.h"
#include "primitive_effect.h"
#include <android-base/properties.h>
#include <string>

const struct effect_stream* find_effect(const struct effect_stream* arr, size_t size, uint32_t effect_id) {
    for (size_t i = 0; i < size; ++i) {
        if (effect_id == arr[i].effect_id)
            return &arr[i];
    }
    return NULL;
}

const struct effect_stream* get_effect_stream(uint32_t effect_id) {
    using android::base::GetProperty;
    const struct effect_stream *selected_effects = effects;
    size_t effects_size = ARRAY_SIZE(effects);
    std::string profile = GetProperty("persist.vendor.haptic_profile", "richtap");

    if ((effect_id & 0x8000) != 0) {
        effect_id &= 0x7fff;
        if (profile == "gentle" || profile == "op13gentle") {
            return find_effect(primitives_gentle, ARRAY_SIZE(primitives_gentle), effect_id);
        } else {
            return find_effect(primitives, ARRAY_SIZE(primitives), effect_id);
        }
    }

    if (profile == "crisp") {
        selected_effects = effects_crisp;
        effects_size = ARRAY_SIZE(effects_crisp);
    } else if (profile == "gentle") {
        selected_effects = effects_gentle;
        effects_size = ARRAY_SIZE(effects_gentle);
    } else if (profile == "op13crisp") {
        selected_effects = effects_op13crisp;
        effects_size = ARRAY_SIZE(effects_op13crisp);
    } else if (profile == "op13gentle") {
        selected_effects = effects_op13gentle;
        effects_size = ARRAY_SIZE(effects_op13gentle);
    }

    return find_effect(selected_effects, effects_size, effect_id);
}
