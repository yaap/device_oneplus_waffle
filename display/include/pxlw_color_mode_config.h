/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#define PXLW_COLOR_MODE_CONFIG_AVAILABLE 1

#include <cstdint>

struct PxlwRenderIntentPair {
  int32_t surface_flinger;
  int32_t iris;
};

inline constexpr PxlwRenderIntentPair kPxlwP3RenderIntentPairs[] = {
    {301, 302},
    {303, 304},
    {307, 308},
};
