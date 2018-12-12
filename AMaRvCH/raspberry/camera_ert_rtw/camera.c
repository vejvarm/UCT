/*
 * File: camera.c
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
#include "camera_dt.h"
#define camera_PinNumber               (24.0)
#define camera_PinNumber_n             (23.0)

/* Block signals (default storage) */
B_camera_T camera_B;

/* Block states (default storage) */
DW_camera_T camera_DW;

/* Real-time model */
RT_MODEL_camera_T camera_M_;
RT_MODEL_camera_T *const camera_M = &camera_M_;

/* Forward declaration for local functions */
static void SystemProp_matlabCodegenSetA_nn(codertarget_linux_blocks_SDLV_T *obj,
  boolean_T value);
static void camera_SystemCore_release_nn(const codertarget_linux_blocks_SDLV_T
  *obj);
static void camera_SystemCore_delete_nn(const codertarget_linux_blocks_SDLV_T
  *obj);
static void matlabCodegenHandle_matlabCo_nn(codertarget_linux_blocks_SDLV_T *obj);
static void SystemProp_matlabCodegenSetAnyP(codertarget_linux_blocks_Digi_T *obj,
  boolean_T value);
static void camera_SystemCore_release_n(const codertarget_linux_blocks_Digi_T
  *obj);
static void camera_SystemCore_delete_n(const codertarget_linux_blocks_Digi_T
  *obj);
static void matlabCodegenHandle_matlabCod_n(codertarget_linux_blocks_Digi_T *obj);
static void camera_SystemCore_release(const codertarget_linux_blocks_Digi_T *obj);
static void camera_SystemCore_delete(const codertarget_linux_blocks_Digi_T *obj);
static void matlabCodegenHandle_matlabCodeg(codertarget_linux_blocks_Digi_T *obj);
static void SystemProp_matlabCodegenSetA_nn(codertarget_linux_blocks_SDLV_T *obj,
  boolean_T value)
{
  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  obj->matlabCodegenIsDeleted = value;
}

static void camera_SystemCore_release_nn(const codertarget_linux_blocks_SDLV_T
  *obj)
{
  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_SDL_videoDisplayTerminate(0, 0);
  }

  /* End of Start for MATLABSystem: '<S3>/MATLAB System' */
}

static void camera_SystemCore_delete_nn(const codertarget_linux_blocks_SDLV_T
  *obj)
{
  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  camera_SystemCore_release_nn(obj);
}

static void matlabCodegenHandle_matlabCo_nn(codertarget_linux_blocks_SDLV_T *obj)
{
  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetA_nn(obj, true);
    camera_SystemCore_delete_nn(obj);
  }

  /* End of Start for MATLABSystem: '<S3>/MATLAB System' */
}

static void SystemProp_matlabCodegenSetAnyP(codertarget_linux_blocks_Digi_T *obj,
  boolean_T value)
{
  obj->matlabCodegenIsDeleted = value;
}

static void camera_SystemCore_release_n(const codertarget_linux_blocks_Digi_T
  *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_gpioTerminate((uint32_T)camera_PinNumber_n);
  }
}

static void camera_SystemCore_delete_n(const codertarget_linux_blocks_Digi_T
  *obj)
{
  camera_SystemCore_release_n(obj);
}

static void matlabCodegenHandle_matlabCod_n(codertarget_linux_blocks_Digi_T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetAnyP(obj, true);
    camera_SystemCore_delete_n(obj);
  }
}

static void camera_SystemCore_release(const codertarget_linux_blocks_Digi_T *obj)
{
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_gpioTerminate((uint32_T)camera_PinNumber);
  }
}

static void camera_SystemCore_delete(const codertarget_linux_blocks_Digi_T *obj)
{
  camera_SystemCore_release(obj);
}

static void matlabCodegenHandle_matlabCodeg(codertarget_linux_blocks_Digi_T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetAnyP(obj, true);
    camera_SystemCore_delete(obj);
  }
}

/* Model step function */
void camera_step(void)
{
  real_T rtb_SliderGain;
  uint32_T tmp;
  int32_T i;

  /* S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureOutput(camera_ConstP.V4L2VideoCapture_p1,
                        camera_B.V4L2VideoCapture_o1,
                        camera_B.V4L2VideoCapture_o2,
                        camera_B.V4L2VideoCapture_o3);

  /* Gain: '<S5>/Slider Gain' incorporates:
   *  Constant: '<Root>/Constant1'
   */
  rtb_SliderGain = camera_P.SliderGain1_gain * camera_P.Constant1_Value;

  /* RelationalOperator: '<Root>/Relational Operator1' */
  for (i = 0; i < 9600; i++) {
    camera_B.RelationalOperator1[i] = (camera_B.V4L2VideoCapture_o2[i] >
      rtb_SliderGain);
  }

  /* End of RelationalOperator: '<Root>/Relational Operator1' */

  /* DataTypeConversion: '<Root>/Data Type Conversion' incorporates:
   *  Gain: '<Root>/Gain'
   */
  for (i = 0; i < 9600; i++) {
    camera_B.DataTypeConversion[i] = (uint8_T)(camera_B.RelationalOperator1[i] ?
      (int32_T)camera_P.Gain_Gain : 0);
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion' */

  /* Gain: '<S4>/Slider Gain' incorporates:
   *  Constant: '<Root>/Constant'
   */
  rtb_SliderGain = camera_P.SliderGain_gain * camera_P.Constant_Value;

  /* RelationalOperator: '<Root>/Relational Operator' */
  for (i = 0; i < 9600; i++) {
    camera_B.RelationalOperator[i] = (camera_B.V4L2VideoCapture_o3[i] >
      rtb_SliderGain);
  }

  /* End of RelationalOperator: '<Root>/Relational Operator' */

  /* DataTypeConversion: '<Root>/Data Type Conversion1' incorporates:
   *  Gain: '<Root>/Gain1'
   */
  for (i = 0; i < 9600; i++) {
    camera_B.DataTypeConversion1[i] = (uint8_T)(camera_B.RelationalOperator[i] ?
      (int32_T)camera_P.Gain1_Gain : 0);
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion1' */
  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  memcpy(&camera_B.pln1[0], &camera_B.V4L2VideoCapture_o1[0], 19200U * sizeof
         (uint8_T));
  memcpy(&camera_B.pln2[0], &camera_B.DataTypeConversion[0], 9600U * sizeof
         (uint8_T));
  memcpy(&camera_B.pln3[0], &camera_B.DataTypeConversion1[0], 9600U * sizeof
         (uint8_T));
  MW_SDL_videoDisplayOutput(camera_B.pln1, camera_B.pln2, camera_B.pln3);

  /* Sum: '<Root>/Sum of Elements1' */
  tmp = 0U;
  for (i = 0; i < 9600; i++) {
    tmp += camera_B.RelationalOperator[i];
  }

  /* MATLABSystem: '<S2>/Digital Write' incorporates:
   *  Constant: '<Root>/Constant3'
   *  Gain: '<S7>/Slider Gain'
   *  RelationalOperator: '<Root>/Relational Operator3'
   *  Sum: '<Root>/Sum of Elements1'
   */
  MW_gpioWrite((uint32_T)camera_PinNumber_n, (uint8_T)((uint8_T)tmp >
    camera_P.SliderGain3_gain * camera_P.Constant3_Value));

  /* Sum: '<Root>/Sum of Elements' */
  tmp = 0U;
  for (i = 0; i < 9600; i++) {
    tmp += camera_B.RelationalOperator1[i];
  }

  /* MATLABSystem: '<S1>/Digital Write' incorporates:
   *  Constant: '<Root>/Constant2'
   *  Gain: '<S6>/Slider Gain'
   *  RelationalOperator: '<Root>/Relational Operator2'
   *  Sum: '<Root>/Sum of Elements'
   */
  MW_gpioWrite((uint32_T)camera_PinNumber, (uint8_T)((uint8_T)tmp >
    camera_P.SliderGain2_gain * camera_P.Constant2_Value));

  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.1s, 0.0s] */
    rtExtModeUpload(0, camera_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.1s, 0.0s] */
    if ((rtmGetTFinal(camera_M)!=-1) &&
        !((rtmGetTFinal(camera_M)-camera_M->Timing.taskTime0) >
          camera_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(camera_M, "Simulation finished");
    }

    if (rtmGetStopRequested(camera_M)) {
      rtmSetErrorStatus(camera_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  camera_M->Timing.taskTime0 =
    (++camera_M->Timing.clockTick0) * camera_M->Timing.stepSize0;
}

/* Model initialize function */
void camera_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)camera_M, 0,
                sizeof(RT_MODEL_camera_T));
  rtmSetTFinal(camera_M, -1);
  camera_M->Timing.stepSize0 = 0.1;

  /* External mode info */
  camera_M->Sizes.checksums[0] = (2349881778U);
  camera_M->Sizes.checksums[1] = (1371216538U);
  camera_M->Sizes.checksums[2] = (3584742704U);
  camera_M->Sizes.checksums[3] = (1024263468U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[5];
    camera_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    systemRan[4] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(camera_M->extModeInfo,
      &camera_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(camera_M->extModeInfo, camera_M->Sizes.checksums);
    rteiSetTPtr(camera_M->extModeInfo, rtmGetTPtr(camera_M));
  }

  /* block I/O */
  (void) memset(((void *) &camera_B), 0,
                sizeof(B_camera_T));

  /* states (dwork) */
  (void) memset((void *)&camera_DW, 0,
                sizeof(DW_camera_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    camera_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 16;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Start for S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureInit(camera_ConstP.V4L2VideoCapture_p1, 0, 0, 0, 0, 160U, 120U,
                      1U, 2U, 1U, 0.1);

  /* Start for MATLABSystem: '<S3>/MATLAB System' */
  camera_DW.obj.matlabCodegenIsDeleted = true;
  camera_DW.obj.isInitialized = 0;
  camera_DW.obj.matlabCodegenIsDeleted = false;
  camera_DW.obj.isSetupComplete = false;
  camera_DW.obj.isInitialized = 1;
  camera_DW.obj.PixelFormatEnum = 2;
  MW_SDL_videoDisplayInit(camera_DW.obj.PixelFormatEnum, 1, 1, 160.0, 120.0);
  camera_DW.obj.isSetupComplete = true;

  /* End of Start for SubSystem: '<Root>/SDL Video Display' */

  /* Start for MATLABSystem: '<S2>/Digital Write' */
  camera_DW.obj_c.matlabCodegenIsDeleted = true;
  camera_DW.obj_c.isInitialized = 0;
  camera_DW.obj_c.matlabCodegenIsDeleted = false;
  camera_DW.obj_c.isSetupComplete = false;
  camera_DW.obj_c.isInitialized = 1;
  MW_gpioInit((uint32_T)camera_PinNumber_n, true);
  camera_DW.obj_c.isSetupComplete = true;

  /* Start for MATLABSystem: '<S1>/Digital Write' */
  camera_DW.obj_p.matlabCodegenIsDeleted = true;
  camera_DW.obj_p.isInitialized = 0;
  camera_DW.obj_p.matlabCodegenIsDeleted = false;
  camera_DW.obj_p.isSetupComplete = false;
  camera_DW.obj_p.isInitialized = 1;
  MW_gpioInit((uint32_T)camera_PinNumber, true);
  camera_DW.obj_p.isSetupComplete = true;
}

/* Model terminate function */
void camera_terminate(void)
{
  /* Terminate for S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureTerminate(camera_ConstP.V4L2VideoCapture_p1);

  /* Terminate for MATLABSystem: '<S3>/MATLAB System' */
  matlabCodegenHandle_matlabCo_nn(&camera_DW.obj);

  /* End of Terminate for SubSystem: '<Root>/SDL Video Display' */

  /* Terminate for MATLABSystem: '<S2>/Digital Write' */
  matlabCodegenHandle_matlabCod_n(&camera_DW.obj_c);

  /* Terminate for MATLABSystem: '<S1>/Digital Write' */
  matlabCodegenHandle_matlabCodeg(&camera_DW.obj_p);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
