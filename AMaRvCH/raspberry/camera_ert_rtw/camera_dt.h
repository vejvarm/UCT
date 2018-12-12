/*
 * camera_dt.h
 *
 * Code generation for model "camera".
 *
 * Model version              : 1.2
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Thu Nov 29 11:04:08 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(codertarget_linux_blocks_Digi_T),
  sizeof(codertarget_linux_blocks_SDLV_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "codertarget_linux_blocks_Digi_T",
  "codertarget_linux_blocks_SDLV_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&camera_B.V4L2VideoCapture_o1[0]), 3, 0, 19200 },

  { (char_T *)(&camera_B.V4L2VideoCapture_o2[0]), 3, 0, 38400 },

  { (char_T *)(&camera_B.RelationalOperator1[0]), 8, 0, 19200 }
  ,

  { (char_T *)(&camera_DW.obj), 15, 0, 1 },

  { (char_T *)(&camera_DW.obj_c), 14, 0, 2 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  5U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&camera_P.SliderGain1_gain), 0, 0, 8 },

  { (char_T *)(&camera_P.Gain_Gain), 3, 0, 2 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  2U,
  rtPTransitions
};

/* [EOF] camera_dt.h */
