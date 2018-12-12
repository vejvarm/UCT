/*
 * File: camera_data.c
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

#include "camera.h"
#include "camera_private.h"

/* Block parameters (default storage) */
P_camera_T camera_P = {
  /* Mask Parameter: SliderGain1_gain
   * Referenced by: '<S5>/Slider Gain'
   */
  1.0,

  /* Mask Parameter: SliderGain_gain
   * Referenced by: '<S4>/Slider Gain'
   */
  1.0,

  /* Mask Parameter: SliderGain3_gain
   * Referenced by: '<S7>/Slider Gain'
   */
  1.0,

  /* Mask Parameter: SliderGain2_gain
   * Referenced by: '<S6>/Slider Gain'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant1'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant3'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant2'
   */
  1.0,

  /* Computed Parameter: Gain_Gain
   * Referenced by: '<Root>/Gain'
   */
  255U,

  /* Computed Parameter: Gain1_Gain
   * Referenced by: '<Root>/Gain1'
   */
  255U
};

/* Constant parameters (default storage) */
const ConstP_camera_T camera_ConstP = {
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
