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

#define CAS_BIND_SRV_INPUT_COLOR               0
#define CAS_BIND_UAV_OUTPUT_COLOR           2000
#define CAS_BIND_CB_CAS                     3000

#include "cas/ffx_cas_callbacks_glsl.h"
#include "cas/ffx_cas_sharpen.h"

#ifndef FFX_CAS_THREAD_GROUP_WIDTH
#define FFX_CAS_THREAD_GROUP_WIDTH 64
#endif // #ifndef FFX_CAS_THREAD_GROUP_WIDTH
#ifndef FFX_CAS_THREAD_GROUP_HEIGHT
#define FFX_CAS_THREAD_GROUP_HEIGHT 1
#endif // FFX_CAS_THREAD_GROUP_HEIGHT
#ifndef FFX_CAS_THREAD_GROUP_DEPTH
#define FFX_CAS_THREAD_GROUP_DEPTH 1
#endif // #ifndef FFX_CAS_THREAD_GROUP_DEPTH
#ifndef FFX_CAS_NUM_THREADS
#define FFX_CAS_NUM_THREADS layout (local_size_x = FFX_CAS_THREAD_GROUP_WIDTH, local_size_y = FFX_CAS_THREAD_GROUP_HEIGHT, local_size_z = FFX_CAS_THREAD_GROUP_DEPTH) in;
#endif // #ifndef FFX_CAS_NUM_THREADS

FFX_CAS_NUM_THREADS
void main()
{
    Sharpen(gl_LocalInvocationID.xyz, gl_WorkGroupID.xyz, gl_GlobalInvocationID.xyz);
}
