// This file is part of the FidelityFX SDK.
//
// Copyright (C) 2024 Advanced Micro Devices, Inc.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#version 450

#extension GL_GOOGLE_include_directive : require
#extension GL_EXT_samplerless_texture_functions : require

#define FFX_OPTICALFLOW_BIND_UAV_OPTICAL_FLOW_SCD_HISTOGRAM            0
#define FFX_OPTICALFLOW_BIND_UAV_OPTICAL_FLOW_SCD_PREVIOUS_HISTOGRAM   1
#define FFX_OPTICALFLOW_BIND_UAV_OPTICAL_FLOW_SCD_TEMP                 2
#define FFX_OPTICALFLOW_BIND_UAV_OPTICAL_FLOW_SCD_OUTPUT               3

#define FFX_OPTICALFLOW_BIND_CB_COMMON                                 4

#include "opticalflow/ffx_opticalflow_callbacks_glsl.h"
#include "opticalflow/ffx_opticalflow_common.h"
#include "opticalflow/ffx_opticalflow_compute_scd_divergence.h"

#ifndef FFX_OPTICALFLOW_THREAD_GROUP_WIDTH
#define FFX_OPTICALFLOW_THREAD_GROUP_WIDTH 256
#endif // #ifndef FFX_OPTICALFLOW_THREAD_GROUP_WIDTH
#ifndef FFX_OPTICALFLOW_THREAD_GROUP_HEIGHT
#define FFX_OPTICALFLOW_THREAD_GROUP_HEIGHT 1
#endif // #ifndef FFX_OPTICALFLOW_THREAD_GROUP_HEIGHT
#ifndef FFX_OPTICALFLOW_THREAD_GROUP_DEPTH
#define FFX_OPTICALFLOW_THREAD_GROUP_DEPTH 1
#endif // #ifndef FFX_OPTICALFLOW_THREAD_GROUP_DEPTH
#ifndef FFX_OPTICALFLOW_NUM_THREADS
#define FFX_OPTICALFLOW_NUM_THREADS layout (local_size_x = FFX_OPTICALFLOW_THREAD_GROUP_WIDTH, local_size_y = FFX_OPTICALFLOW_THREAD_GROUP_HEIGHT, local_size_z = FFX_OPTICALFLOW_THREAD_GROUP_DEPTH) in;
#endif // #ifndef FFX_OPTICALFLOW_NUM_THREADS

FFX_OPTICALFLOW_NUM_THREADS
void main()
{
    FfxInt32x2 iGroupSize = FfxInt32x2(FFX_OPTICALFLOW_THREAD_GROUP_WIDTH, FFX_OPTICALFLOW_THREAD_GROUP_HEIGHT);
    ComputeSCDHistogramsDivergence(FfxInt32x3(gl_GlobalInvocationID.xyz), FfxInt32x2(gl_LocalInvocationID.xy), FfxInt32(gl_LocalInvocationIndex), FfxInt32x2(gl_WorkGroupID.xy), iGroupSize);
}
