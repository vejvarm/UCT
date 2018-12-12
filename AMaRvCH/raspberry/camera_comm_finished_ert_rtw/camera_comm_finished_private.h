/*
 * File: camera_comm_finished_private.h
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

#ifndef RTW_HEADER_camera_comm_finished_private_h_
#define RTW_HEADER_camera_comm_finished_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "camera_comm_finished.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTFinal
# define rtmSetTFinal(rtm, val)        ((rtm)->Timing.tFinal = (val))
#endif

extern void camera_comm__MedianFilter1_Init(DW_MedianFilter1_camera_comm__T
  *localDW);
extern void camera_comm_MedianFilter1_Start(DW_MedianFilter1_camera_comm__T
  *localDW);
extern void camera_comm_finis_MedianFilter1(const real_T rtu_0[9600],
  B_MedianFilter1_camera_comm_f_T *localB, DW_MedianFilter1_camera_comm__T
  *localDW);
extern void camera_comm__MedianFilter1_Term(DW_MedianFilter1_camera_comm__T
  *localDW);

#endif                                 /* RTW_HEADER_camera_comm_finished_private_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
