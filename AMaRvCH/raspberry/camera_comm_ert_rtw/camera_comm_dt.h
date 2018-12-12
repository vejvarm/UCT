/*
 * camera_comm_dt.h
 *
 * Code generation for model "camera_comm".
 *
 * Model version              : 1.14
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Thu Nov 29 08:50:09 2018
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
  sizeof(dsp_MedianFilter_camera_comm_T),
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
  "dsp_MedianFilter_camera_comm_T",
  "codertarget_linux_blocks_SDLV_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&camera_comm_B.V4L2VideoCapture_o1[0]), 3, 0, 19200 },

  { (char_T *)(&camera_comm_B.V4L2VideoCapture_o2[0]), 3, 0, 38400 },

  { (char_T *)(&camera_comm_B.RelationalOperator1[0]), 8, 0, 19200 },

  { (char_T *)(&camera_comm_B.MedianFilter.MedianFilter1[0]), 0, 0, 9600 },

  { (char_T *)(&camera_comm_B.MedianFilter1.MedianFilter1[0]), 0, 0, 9600 }
  ,

  { (char_T *)(&camera_comm_DW.obj), 16, 0, 1 },

  { (char_T *)(&camera_comm_DW.obj_c), 14, 0, 2 },

  { (char_T *)(&camera_comm_DW.MedianFilter.obj), 15, 0, 1 },

  { (char_T *)(&camera_comm_DW.MedianFilter.objisempty), 8, 0, 1 },

  { (char_T *)(&camera_comm_DW.MedianFilter1.obj), 15, 0, 1 },

  { (char_T *)(&camera_comm_DW.MedianFilter1.objisempty), 8, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  11U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&camera_comm_P.Cb_gain), 0, 0, 9 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  1U,
  rtPTransitions
};

/* [EOF] camera_comm_dt.h */
