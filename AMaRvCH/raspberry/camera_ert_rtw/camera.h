/*
 * File: camera.h
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

#ifndef RTW_HEADER_camera_h_
#define RTW_HEADER_camera_h_
#include <string.h>
#include <float.h>
#include <stddef.h>
#ifndef camera_COMMON_INCLUDES_
# define camera_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "dt_info.h"
#include "ext_work.h"
#include "MW_gpio.h"
#include "MW_SDL_video_display.h"
#include "v4l2_capture.h"
#endif                                 /* camera_COMMON_INCLUDES_ */

#include "camera_types.h"

/* Shared type includes */
#include "multiword_types.h"

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

/* Block signals (default storage) */
typedef struct {
  uint8_T V4L2VideoCapture_o1[19200];  /* '<Root>/V4L2 Video Capture' */
  uint8_T pln1[19200];
  uint8_T V4L2VideoCapture_o2[9600];   /* '<Root>/V4L2 Video Capture' */
  uint8_T V4L2VideoCapture_o3[9600];   /* '<Root>/V4L2 Video Capture' */
  uint8_T DataTypeConversion[9600];    /* '<Root>/Data Type Conversion' */
  uint8_T DataTypeConversion1[9600];   /* '<Root>/Data Type Conversion1' */
  uint8_T pln2[9600];
  uint8_T pln3[9600];
  boolean_T RelationalOperator1[9600]; /* '<Root>/Relational Operator1' */
  boolean_T RelationalOperator[9600];  /* '<Root>/Relational Operator' */
} B_camera_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  codertarget_linux_blocks_SDLV_T obj; /* '<S3>/MATLAB System' */
  codertarget_linux_blocks_Digi_T obj_c;/* '<S2>/Digital Write' */
  codertarget_linux_blocks_Digi_T obj_p;/* '<S1>/Digital Write' */
} DW_camera_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Expression: devName
   * Referenced by: '<Root>/V4L2 Video Capture'
   */
  uint8_T V4L2VideoCapture_p1[12];
} ConstP_camera_T;

/* Parameters (default storage) */
struct P_camera_T_ {
  real_T SliderGain1_gain;             /* Mask Parameter: SliderGain1_gain
                                        * Referenced by: '<S5>/Slider Gain'
                                        */
  real_T SliderGain_gain;              /* Mask Parameter: SliderGain_gain
                                        * Referenced by: '<S4>/Slider Gain'
                                        */
  real_T SliderGain3_gain;             /* Mask Parameter: SliderGain3_gain
                                        * Referenced by: '<S7>/Slider Gain'
                                        */
  real_T SliderGain2_gain;             /* Mask Parameter: SliderGain2_gain
                                        * Referenced by: '<S6>/Slider Gain'
                                        */
  real_T Constant1_Value;              /* Expression: 1
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T Constant_Value;               /* Expression: 1
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T Constant3_Value;              /* Expression: 1
                                        * Referenced by: '<Root>/Constant3'
                                        */
  real_T Constant2_Value;              /* Expression: 1
                                        * Referenced by: '<Root>/Constant2'
                                        */
  uint8_T Gain_Gain;                   /* Computed Parameter: Gain_Gain
                                        * Referenced by: '<Root>/Gain'
                                        */
  uint8_T Gain1_Gain;                  /* Computed Parameter: Gain1_Gain
                                        * Referenced by: '<Root>/Gain1'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_camera_T {
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
extern P_camera_T camera_P;

/* Block signals (default storage) */
extern B_camera_T camera_B;

/* Block states (default storage) */
extern DW_camera_T camera_DW;

/* Constant parameters (default storage) */
extern const ConstP_camera_T camera_ConstP;

/* Model entry point functions */
extern void camera_initialize(void);
extern void camera_step(void);
extern void camera_terminate(void);

/* Real-time Model object */
extern RT_MODEL_camera_T *const camera_M;

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
 * '<Root>' : 'camera'
 * '<S1>'   : 'camera/GPIO Write'
 * '<S2>'   : 'camera/GPIO Write1'
 * '<S3>'   : 'camera/SDL Video Display'
 * '<S4>'   : 'camera/Slider Gain'
 * '<S5>'   : 'camera/Slider Gain1'
 * '<S6>'   : 'camera/Slider Gain2'
 * '<S7>'   : 'camera/Slider Gain3'
 */
#endif                                 /* RTW_HEADER_camera_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
