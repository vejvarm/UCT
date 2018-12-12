/*
 * File: camera_comm_finished_data.c
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

#include "camera_comm_finished.h"
#include "camera_comm_finished_private.h"

/* Block parameters (default storage) */
P_camera_comm_finished_T camera_comm_finished_P = {
  /* Mask Parameter: Cb_gain
   * Referenced by: '<S2>/Slider Gain'
   */
  135.15,

  /* Mask Parameter: Cr_gain
   * Referenced by: '<S3>/Slider Gain'
   */
  142.8,

  /* Mask Parameter: sum_thresh_gain
   * Referenced by: '<S6>/Slider Gain'
   */
  100.0,

  /* Mask Parameter: sum_thresh1_gain
   * Referenced by: '<S7>/Slider Gain'
   */
  100.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant'
   */
  1.0,

  /* Expression: 255
   * Referenced by: '<Root>/Gain1'
   */
  255.0,

  /* Expression: 255
   * Referenced by: '<Root>/Gain'
   */
  255.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant1'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant2'
   */
  1.0
};

/* Constant parameters (default storage) */
const ConstP_camera_comm_finished_T camera_comm_finished_ConstP = {
  /* Expression: devName
   * Referenced by: '<Root>/V4L2 Video Capture'
   */
  { 47U, 100U, 101U, 118U, 47U, 118U, 105U, 100U, 101U, 111U, 48U, 0U }
};

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
