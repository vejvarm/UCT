/*
 * File: camera_types.h
 *
 * Code generated for Simulink model 'camera'.
 *
 * Model version                  : 1.2
 * Simulink Coder version         : 8.14 (R2018a) 06-Feb-2018
 * C/C++ source code generated on : Thu Nov 29 11:04:08 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_camera_types_h_
#define RTW_HEADER_camera_types_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef typedef_codertarget_linux_blocks_Digi_T
#define typedef_codertarget_linux_blocks_Digi_T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
} codertarget_linux_blocks_Digi_T;

#endif                                 /*typedef_codertarget_linux_blocks_Digi_T*/

#ifndef typedef_codertarget_linux_blocks_SDLV_T
#define typedef_codertarget_linux_blocks_SDLV_T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  int32_T PixelFormatEnum;
} codertarget_linux_blocks_SDLV_T;

#endif                                 /*typedef_codertarget_linux_blocks_SDLV_T*/

/* Parameters (default storage) */
typedef struct P_camera_T_ P_camera_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_camera_T RT_MODEL_camera_T;

#endif                                 /* RTW_HEADER_camera_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
