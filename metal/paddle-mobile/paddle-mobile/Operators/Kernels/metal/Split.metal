/* Copyright (c) 2018 PaddlePaddle Authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License. */

#include <metal_stdlib>
#include "Common.metal"

using namespace metal;

struct SplitParam {
  int32_t idim[4];
  int32_t axis;
  int32_t offset;
  int32_t trans[4];
  int32_t vdim[4];
};

// only support split_{2, 3, 4}_{2, 3, 4}_y_{float, half}
// only support split_{3, 4}_{2, 3, 4}_x_{float, half}

#define V y
// for R in 2..4
#define R 3

// for N in 2..4
#define N 2

#define P float
#include "Split.inc.metal"
#undef P
#define P half
#include "Split.inc.metal"
#undef P

#undef N
// end for N

#undef R
// end for R
#undef V

#define V x
// for R in 3..4
#define R 3

// for N in 2..4
#define N 2

#define P float
#include "Split.inc.metal"
#undef P
#define P half
#include "Split.inc.metal"
#undef P

#undef N
// end for N

#undef R
// end for R
#undef V
