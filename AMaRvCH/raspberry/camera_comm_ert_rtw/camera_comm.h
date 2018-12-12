/*
 * File: camera_comm.h
 *
 * Code generated for Simulink model 'camera_comm'.
 *
 * Model version                  : 1.14
 * Simulink Coder version         : 8.14 (R2018a) 06-Feb-2018
 * C/C++ source code generated on : Thu Nov 29 08:50:09 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_camera_comm_h_
#define RTW_HEADER_camera_comm_h_
#include <math.h>
#include <string.h>
#include <float.h>
#include <stddef.h>
#ifndef camera_comm_COMMON_INCLUDES_
# define camera_comm_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "dt_info.h"
#include "ext_work.h"
#include "MW_gpio.h"
#include "MW_SDL_video_display.h"
#include "v4l2_capture.h"
#endif                                 /* camera_comm_COMMON_INCLUDES_ */

#include "camera_comm_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"
#include "rtGetInf.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               (&(rtm)->Timing.taskTime0)
#endif

/* Block signals for system '<Root>/Median Filter1' */
typedef struct {
  real_T MedianFilter1[9600];          /* '<Root>/Median Filter1' */
  real_T vprev;
  real_T p;
  real_T temp;
  real_T u;
  real_T temp_m;
  real_T temp_c;
} B_MedianFilter1_camera_comm_T;

/* Block states (default storage) for system '<Root>/Median Filter1' */
typedef struct {
  dsp_MedianFilter_camera_comm_T obj;  /* '<Root>/Median Filter1' */
  boolean_T objisempty;                /* '<Root>/Median Filter1' */
} DW_MedianFilter1_camera_comm_T;

/* Block signals (default storage) */
typedef struct {
  real_T rtb_DataTypeConversion2_m[9600];
  real_T rtb_DataTypeConversion2_c[9600];
  uint8_T V4L2VideoCapture_o1[19200];  /* '<Root>/V4L2 Video Capture' */
  uint8_T pln1[19200];
  uint8_T V4L2VideoCapture_o2[9600];   /* '<Root>/V4L2 Video Capture' */
  uint8_T V4L2VideoCapture_o3[9600];   /* '<Root>/V4L2 Video Capture' */
  uint8_T DataTypeConversion1[9600];   /* '<Root>/Data Type Conversion1' */
  uint8_T DataTypeConversion[9600];    /* '<Root>/Data Type Conversion' */
  uint8_T pln2[9600];
  uint8_T pln3[9600];
  boolean_T RelationalOperator1[9600]; /* '<Root>/Relational Operator1' */
  boolean_T RelationalOperator[9600];  /* '<Root>/Relational Operator' */
  real_T SumofElements1;               /* '<Root>/Sum of Elements1' */
  B_MedianFilter1_camera_comm_T MedianFilter;/* '<Root>/Median Filter1' */
  B_MedianFilter1_camera_comm_T MedianFilter1;/* '<Root>/Median Filter1' */
} B_camera_comm_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  codertarget_linux_blocks_SDLV_T obj; /* '<S5>/MATLAB System' */
  codertarget_linux_blocks_Digi_T obj_c;/* '<S4>/Digital Write' */
  codertarget_linux_blocks_Digi_T obj_m;/* '<S1>/Digital Write' */
  DW_MedianFilter1_camera_comm_T MedianFilter;/* '<Root>/Median Filter1' */
  DW_MedianFilter1_camera_comm_T MedianFilter1;/* '<Root>/Median Filter1' */
} DW_camera_comm_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Expression: devName
   * Referenced by: '<Root>/V4L2 Video Capture'
   */
  uint8_T V4L2VideoCapture_p1[12];
} ConstP_camera_comm_T;

/* Parameters (default storage) */
struct P_camera_comm_T_ {
  real_T Cb_gain;                      /* Mask Parameter: Cb_gain
                                        * Referenced by: '<S2>/Slider Gain'
                                        */
  real_T Cr_gain;                      /* Mask Parameter: Cr_gain
                                        * Referenced by: '<S3>/Slider Gain'
                                        */
  real_T sum_thresh_gain;              /* Mask Parameter: sum_thresh_gain
                                        * Referenced by: '<S6>/Slider Gain'
                                        */
  real_T sum_thresh1_gain;             /* Mask Parameter: sum_thresh1_gain
                                        * Referenced by: '<S7>/Slider Gain'
                                        */
  real_T Constant_Value;               /* Expression: 1
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T Gain1_Gain;                   /* Expression: 255
                                        * Referenced by: '<Root>/Gain1'
                                        */
  real_T Gain_Gain;                    /* Expression: 255
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T Constant1_Value;              /* Expression: 1
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T Constant2_Value;              /* Expression: 1
                                        * Referenced by: '<Root>/Constant2'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_camera_comm_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_camera_comm_T camera_comm_P;

/* Block signals (default storage) */
extern B_camera_comm_T camera_comm_B;

/* Block states (default storage) */
extern DW_camera_comm_T camera_comm_DW;

/* Constant parameters (default storage) */
extern const ConstP_camera_comm_T camera_comm_ConstP;

/* Model entry point functions */
extern void camera_comm_initialize(void);
extern void camera_comm_step(void);
extern void camera_comm_terminate(void);

/* Real-time Model object */
extern RT_MODEL_camera_comm_T *const camera_comm_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'camera_comm'
 * '<S1>'   : 'camera_comm/Blue LED'
 * '<S2>'   : 'camera_comm/Cb'
 * '<S3>'   : 'camera_comm/Cr'
 * '<S4>'   : 'camera_comm/Red LED'
 * '<S5>'   : 'camera_comm/SDL Video Display'
 * '<S6>'   : 'camera_comm/sum_thresh'
 * '<S7>'   : 'camera_comm/sum_thresh1'
 */
#endif                                 /* RTW_HEADER_camera_comm_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
