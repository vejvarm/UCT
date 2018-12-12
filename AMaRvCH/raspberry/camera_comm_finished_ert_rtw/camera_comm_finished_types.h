/*
 * File: camera_comm_finished_types.h
 *
 * Code generated for Simulink model 'camera_comm_finished'.
 *
 * Model version                  : 1.15
 * Simulink Coder version         : 8.14 (R2018a) 06-Feb-2018
 * C/C++ source code generated on : Thu Nov 29 11:12:51 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_camera_comm_finished_types_h_
#define RTW_HEADER_camera_comm_finished_types_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef typedef_cell_wrap_camera_comm_finishe_T
#define typedef_cell_wrap_camera_comm_finishe_T

typedef struct {
  uint32_T f1[8];
} cell_wrap_camera_comm_finishe_T;

#endif                                 /*typedef_cell_wrap_camera_comm_finishe_T*/

#ifndef typedef_dsp_private_MedianFilterCG_ca_T
#define typedef_dsp_private_MedianFilterCG_ca_T

typedef struct {
  int32_T isInitialized;
  boolean_T isSetupComplete;
  real_T pWinLen;
  real_T pBuf[600];
  real_T pHeap[600];
  real_T pMidHeap;
  real_T pIdx[120];
  real_T pPos[600];
  real_T pMinHeapLength;
  real_T pMaxHeapLength;
} dsp_private_MedianFilterCG_ca_T;

#endif                                 /*typedef_dsp_private_MedianFilterCG_ca_T*/

#ifndef typedef_dsp_MedianFilter_camera_comm__T
#define typedef_dsp_MedianFilter_camera_comm__T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  cell_wrap_camera_comm_finishe_T inputVarSize;
  int32_T NumChannels;
  dsp_private_MedianFilterCG_ca_T pMID;
} dsp_MedianFilter_camera_comm__T;

#endif                                 /*typedef_dsp_MedianFilter_camera_comm__T*/

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
typedef struct P_camera_comm_finished_T_ P_camera_comm_finished_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_camera_comm_finished_T RT_MODEL_camera_comm_finished_T;

#endif                                 /* RTW_HEADER_camera_comm_finished_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
