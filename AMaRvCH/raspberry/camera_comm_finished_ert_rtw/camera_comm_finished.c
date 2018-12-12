/*
 * File: camera_comm_finished.c
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
#include "camera_comm_finished_dt.h"
#define camera_comm_finish_WindowLength (5.0)
#define camera_comm_finishe_PinNumber_d (23.0)
#define camera_comm_finished_PinNumber (24.0)

/* Block signals (default storage) */
B_camera_comm_finished_T camera_comm_finished_B;

/* Block states (default storage) */
DW_camera_comm_finished_T camera_comm_finished_DW;

/* Real-time model */
RT_MODEL_camera_comm_finished_T camera_comm_finished_M_;
RT_MODEL_camera_comm_finished_T *const camera_comm_finished_M =
  &camera_comm_finished_M_;

/* Forward declaration for local functions */
static void camera_MedianFilterCG_resetImpl(dsp_private_MedianFilterCG_ca_T *obj);
static void c_MedianFilterCG_trickleDownMin(dsp_private_MedianFilterCG_ca_T *obj,
  real_T i, int32_T chanIdx, B_MedianFilter1_camera_comm_f_T *localB);
static void c_MedianFilterCG_trickleDownMax(dsp_private_MedianFilterCG_ca_T *obj,
  real_T i, int32_T chanIdx, B_MedianFilter1_camera_comm_f_T *localB);
static void SystemProp_matlabCodegenSetAnyP(dsp_MedianFilter_camera_comm__T *obj,
  boolean_T value);
static void camera_comm__SystemCore_release(dsp_MedianFilter_camera_comm__T *obj);
static void camera_comm_f_SystemCore_delete(dsp_MedianFilter_camera_comm__T *obj);
static void matlabCodegenHandle_matlabCodeg(dsp_MedianFilter_camera_comm__T *obj);

/* Forward declaration for local functions */
static void SystemProp_matlabCodegenSet_das(codertarget_linux_blocks_SDLV_T *obj,
  boolean_T value);
static void camera_c_SystemCore_release_das(const
  codertarget_linux_blocks_SDLV_T *obj);
static void camera_co_SystemCore_delete_das(const
  codertarget_linux_blocks_SDLV_T *obj);
static void matlabCodegenHandle_matlabC_das(codertarget_linux_blocks_SDLV_T *obj);
static void SystemProp_matlabCodegenSetAn_d(codertarget_linux_blocks_Digi_T *obj,
  boolean_T value);
static void camera_co_SystemCore_release_da(const
  codertarget_linux_blocks_Digi_T *obj);
static void camera_com_SystemCore_delete_da(const
  codertarget_linux_blocks_Digi_T *obj);
static void matlabCodegenHandle_matlabCo_da(codertarget_linux_blocks_Digi_T *obj);
static void camera_com_SystemCore_release_d(const
  codertarget_linux_blocks_Digi_T *obj);
static void camera_comm_SystemCore_delete_d(const
  codertarget_linux_blocks_Digi_T *obj);
static void matlabCodegenHandle_matlabCod_d(codertarget_linux_blocks_Digi_T *obj);
static void camera_MedianFilterCG_resetImpl(dsp_private_MedianFilterCG_ca_T *obj)
{
  real_T cnt1;
  real_T cnt2;
  int32_T c_index;
  int32_T i;
  int32_T obj_0;

  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  memset(&obj->pBuf[0], 0, 600U * sizeof(real_T));
  memset(&obj->pPos[0], 0, 600U * sizeof(real_T));
  memset(&obj->pHeap[0], 0, 600U * sizeof(real_T));
  obj->pWinLen = camera_comm_finish_WindowLength;
  for (i = 0; i < 120; i++) {
    obj->pIdx[i] = obj->pWinLen;
  }

  obj->pMidHeap = ceil((obj->pWinLen + 1.0) / 2.0);
  cnt1 = (obj->pWinLen - 1.0) / 2.0;
  if (cnt1 < 0.0) {
    obj->pMinHeapLength = ceil(cnt1);
  } else {
    obj->pMinHeapLength = floor(cnt1);
  }

  cnt1 = obj->pWinLen / 2.0;
  if (cnt1 < 0.0) {
    obj->pMaxHeapLength = ceil(cnt1);
  } else {
    obj->pMaxHeapLength = floor(cnt1);
  }

  cnt1 = 1.0;
  cnt2 = obj->pWinLen;
  for (c_index = 0; c_index < 5; c_index++) {
    if ((int32_T)fmod(camera_comm_finish_WindowLength + -(real_T)c_index, 2.0) ==
        0) {
      i = (int32_T)camera_comm_finish_WindowLength - c_index;
      for (obj_0 = 0; obj_0 < 120; obj_0++) {
        obj->pPos[(i + 5 * obj_0) - 1] = cnt1;
      }

      cnt1++;
    } else {
      i = (int32_T)camera_comm_finish_WindowLength - c_index;
      for (obj_0 = 0; obj_0 < 120; obj_0++) {
        obj->pPos[(i + 5 * obj_0) - 1] = cnt2;
      }

      cnt2--;
    }

    obj_0 = (int32_T)obj->pPos[((int32_T)camera_comm_finish_WindowLength -
      c_index) - 1];
    for (i = 0; i < 120; i++) {
      obj->pHeap[(obj_0 + 5 * i) - 1] = camera_comm_finish_WindowLength +
        -(real_T)c_index;
    }
  }

  /* End of Start for MATLABSystem: '<Root>/Median Filter1' */
}

static void c_MedianFilterCG_trickleDownMin(dsp_private_MedianFilterCG_ca_T *obj,
  real_T i, int32_T chanIdx, B_MedianFilter1_camera_comm_f_T *localB)
{
  real_T u;
  int32_T tmp;
  real_T ind1;
  int32_T tmp_0;
  int32_T tmp_1;
  boolean_T exitg1;
  exitg1 = false;
  while ((!exitg1) && (i <= obj->pMinHeapLength)) {
    if ((i > 1.0) && (i < obj->pMinHeapLength)) {
      tmp = (chanIdx - 1) * 5;
      if (obj->pBuf[((int32_T)obj->pHeap[((int32_T)((i + 1.0) + obj->pMidHeap) +
            tmp) - 1] + tmp) - 1] < obj->pBuf[((int32_T)obj->pHeap[(tmp +
            (int32_T)(i + obj->pMidHeap)) - 1] + tmp) - 1]) {
        i++;
      }
    }

    u = i / 2.0;
    if (u < 0.0) {
      u = ceil(u);
    } else {
      u = floor(u);
    }

    ind1 = i + obj->pMidHeap;
    if (!(obj->pBuf[((int32_T)obj->pHeap[((chanIdx - 1) * 5 + (int32_T)ind1) - 1]
                     + (chanIdx - 1) * 5) - 1] < obj->pBuf[((int32_T)obj->pHeap
          [((chanIdx - 1) * 5 + (int32_T)(u + obj->pMidHeap)) - 1] + (chanIdx -
           1) * 5) - 1])) {
      exitg1 = true;
    } else {
      u = i / 2.0;
      if (u < 0.0) {
        u = ceil(u);
      } else {
        u = floor(u);
      }

      u += obj->pMidHeap;
      localB->temp_m = obj->pHeap[((chanIdx - 1) * 5 + (int32_T)ind1) - 1];
      tmp = 5 * (chanIdx - 1);
      tmp_0 = ((int32_T)ind1 + tmp) - 1;
      obj->pHeap[tmp_0] = obj->pHeap[((chanIdx - 1) * 5 + (int32_T)u) - 1];
      tmp_1 = ((int32_T)u + tmp) - 1;
      obj->pHeap[tmp_1] = localB->temp_m;
      obj->pPos[((int32_T)obj->pHeap[tmp_0] + tmp) - 1] = ind1;
      obj->pPos[((int32_T)obj->pHeap[tmp_1] + tmp) - 1] = u;
      i *= 2.0;
    }
  }
}

static void c_MedianFilterCG_trickleDownMax(dsp_private_MedianFilterCG_ca_T *obj,
  real_T i, int32_T chanIdx, B_MedianFilter1_camera_comm_f_T *localB)
{
  real_T u;
  int32_T tmp;
  real_T ind2;
  int32_T tmp_0;
  int32_T tmp_1;
  boolean_T exitg1;
  exitg1 = false;
  while ((!exitg1) && (i >= -obj->pMaxHeapLength)) {
    if ((i < -1.0) && (i > -obj->pMaxHeapLength)) {
      tmp = (chanIdx - 1) * 5;
      if (obj->pBuf[((int32_T)obj->pHeap[(tmp + (int32_T)(i + obj->pMidHeap)) -
                     1] + tmp) - 1] < obj->pBuf[((int32_T)obj->pHeap[((int32_T)
            ((i - 1.0) + obj->pMidHeap) + tmp) - 1] + tmp) - 1]) {
        i--;
      }
    }

    u = i / 2.0;
    if (u < 0.0) {
      u = ceil(u);
    } else {
      u = floor(u);
    }

    ind2 = i + obj->pMidHeap;
    if (!(obj->pBuf[((int32_T)obj->pHeap[((chanIdx - 1) * 5 + (int32_T)(u +
            obj->pMidHeap)) - 1] + (chanIdx - 1) * 5) - 1] < obj->pBuf[((int32_T)
          obj->pHeap[((chanIdx - 1) * 5 + (int32_T)ind2) - 1] + (chanIdx - 1) *
          5) - 1])) {
      exitg1 = true;
    } else {
      u = i / 2.0;
      if (u < 0.0) {
        u = ceil(u);
      } else {
        u = floor(u);
      }

      u += obj->pMidHeap;
      localB->temp_c = obj->pHeap[((chanIdx - 1) * 5 + (int32_T)u) - 1];
      tmp = 5 * (chanIdx - 1);
      tmp_0 = ((int32_T)u + tmp) - 1;
      obj->pHeap[tmp_0] = obj->pHeap[((chanIdx - 1) * 5 + (int32_T)ind2) - 1];
      tmp_1 = ((int32_T)ind2 + tmp) - 1;
      obj->pHeap[tmp_1] = localB->temp_c;
      obj->pPos[((int32_T)obj->pHeap[tmp_0] + tmp) - 1] = u;
      obj->pPos[((int32_T)obj->pHeap[tmp_1] + tmp) - 1] = ind2;
      i *= 2.0;
    }
  }
}

static void SystemProp_matlabCodegenSetAnyP(dsp_MedianFilter_camera_comm__T *obj,
  boolean_T value)
{
  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  obj->matlabCodegenIsDeleted = value;
}

static void camera_comm__SystemCore_release(dsp_MedianFilter_camera_comm__T *obj)
{
  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    obj->NumChannels = -1;
    if (obj->pMID.isInitialized == 1) {
      obj->pMID.isInitialized = 2;
    }
  }

  /* End of Start for MATLABSystem: '<Root>/Median Filter1' */
}

static void camera_comm_f_SystemCore_delete(dsp_MedianFilter_camera_comm__T *obj)
{
  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  camera_comm__SystemCore_release(obj);
}

static void matlabCodegenHandle_matlabCodeg(dsp_MedianFilter_camera_comm__T *obj)
{
  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetAnyP(obj, true);
    camera_comm_f_SystemCore_delete(obj);
  }

  /* End of Start for MATLABSystem: '<Root>/Median Filter1' */
}

/*
 * System initialize for atomic system:
 *    synthesized block
 *    synthesized block
 */
void camera_comm__MedianFilter1_Init(DW_MedianFilter1_camera_comm__T *localDW)
{
  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  if (localDW->obj.pMID.isInitialized == 1) {
    camera_MedianFilterCG_resetImpl(&localDW->obj.pMID);
  }

  /* End of Start for MATLABSystem: '<Root>/Median Filter1' */
}

/*
 * Start for atomic system:
 *    synthesized block
 *    synthesized block
 */
void camera_comm_MedianFilter1_Start(DW_MedianFilter1_camera_comm__T *localDW)
{
  dsp_MedianFilter_camera_comm__T *obj;

  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  localDW->obj.matlabCodegenIsDeleted = true;
  localDW->obj.isInitialized = 0;
  localDW->obj.NumChannels = -1;
  localDW->obj.matlabCodegenIsDeleted = false;
  localDW->objisempty = true;
  obj = &localDW->obj;
  localDW->obj.isSetupComplete = false;
  localDW->obj.isInitialized = 1;
  localDW->obj.NumChannels = 120;
  obj->pMID.isInitialized = 0;
  localDW->obj.isSetupComplete = true;
}

/*
 * Output and update for atomic system:
 *    synthesized block
 *    synthesized block
 */
void camera_comm_finis_MedianFilter1(const real_T rtu_0[9600],
  B_MedianFilter1_camera_comm_f_T *localB, DW_MedianFilter1_camera_comm__T
  *localDW)
{
  dsp_MedianFilter_camera_comm__T *obj;
  dsp_private_MedianFilterCG_ca_T *obj_0;
  int32_T chanIndex;
  int32_T c_index;
  boolean_T flag;
  int32_T vprev_tmp;
  boolean_T exitg1;

  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  obj = &localDW->obj;
  obj_0 = &localDW->obj.pMID;
  if (obj->pMID.isInitialized != 1) {
    obj->pMID.isSetupComplete = false;
    obj->pMID.isInitialized = 1;
    obj->pMID.isSetupComplete = true;
    camera_MedianFilterCG_resetImpl(&obj->pMID);
  }

  for (chanIndex = 0; chanIndex < 120; chanIndex++) {
    for (c_index = 0; c_index < 80; c_index++) {
      vprev_tmp = (5 * chanIndex + (int32_T)obj_0->pIdx[chanIndex]) - 1;
      localB->vprev = obj_0->pBuf[vprev_tmp];
      obj_0->pBuf[((int32_T)obj_0->pIdx[chanIndex] + 5 * chanIndex) - 1] =
        rtu_0[80 * chanIndex + c_index];
      vprev_tmp = (5 * chanIndex + (int32_T)obj_0->pIdx[chanIndex]) - 1;
      localB->p = obj_0->pPos[vprev_tmp];
      obj_0->pIdx[chanIndex]++;
      if (obj_0->pWinLen + 1.0 == obj_0->pIdx[chanIndex]) {
        obj_0->pIdx[chanIndex] = 1.0;
      }

      if (localB->p > obj_0->pMidHeap) {
        if (localB->vprev < rtu_0[80 * chanIndex + c_index]) {
          c_MedianFilterCG_trickleDownMin(obj_0, (localB->p - obj_0->pMidHeap) *
            2.0, chanIndex + 1, localB);
        } else {
          localB->u = localB->p - obj_0->pMidHeap;
          exitg1 = false;
          while ((!exitg1) && (localB->u > 0.0)) {
            localB->p = localB->u + obj_0->pMidHeap;
            localB->vprev = floor(localB->u / 2.0);
            localB->temp = localB->vprev + obj_0->pMidHeap;
            flag = (obj_0->pBuf[((int32_T)obj_0->pHeap[((int32_T)localB->p + 5 *
                      chanIndex) - 1] + 5 * chanIndex) - 1] < obj_0->pBuf
                    [((int32_T)obj_0->pHeap[((int32_T)localB->temp + 5 *
                      chanIndex) - 1] + 5 * chanIndex) - 1]);
            if (!flag) {
              exitg1 = true;
            } else {
              localB->p = localB->u + obj_0->pMidHeap;
              localB->u = floor(localB->u / 2.0) + obj_0->pMidHeap;
              localB->temp = obj_0->pHeap[(5 * chanIndex + (int32_T)localB->p) -
                1];
              obj_0->pHeap[((int32_T)localB->p + 5 * chanIndex) - 1] =
                obj_0->pHeap[(5 * chanIndex + (int32_T)localB->u) - 1];
              obj_0->pHeap[((int32_T)localB->u + 5 * chanIndex) - 1] =
                localB->temp;
              obj_0->pPos[((int32_T)obj_0->pHeap[((int32_T)localB->p + 5 *
                chanIndex) - 1] + 5 * chanIndex) - 1] = localB->p;
              obj_0->pPos[((int32_T)obj_0->pHeap[((int32_T)localB->u + 5 *
                chanIndex) - 1] + 5 * chanIndex) - 1] = localB->u;
              localB->u = localB->vprev;
            }
          }

          if (localB->u == 0.0) {
            c_MedianFilterCG_trickleDownMax(obj_0, -1.0, chanIndex + 1, localB);
          }
        }
      } else if (localB->p < obj_0->pMidHeap) {
        if (rtu_0[80 * chanIndex + c_index] < localB->vprev) {
          c_MedianFilterCG_trickleDownMax(obj_0, (localB->p - obj_0->pMidHeap) *
            2.0, chanIndex + 1, localB);
        } else {
          localB->vprev = localB->p - obj_0->pMidHeap;
          exitg1 = false;
          while ((!exitg1) && (localB->vprev < 0.0)) {
            localB->u = localB->vprev / 2.0;
            if (localB->u < 0.0) {
              localB->u = ceil(localB->u);
            } else {
              localB->u = -0.0;
            }

            localB->p = localB->vprev + obj_0->pMidHeap;
            flag = (obj_0->pBuf[((int32_T)obj_0->pHeap[((int32_T)(localB->u +
                       obj_0->pMidHeap) + 5 * chanIndex) - 1] + 5 * chanIndex) -
                    1] < obj_0->pBuf[((int32_T)obj_0->pHeap[((int32_T)localB->p
                      + 5 * chanIndex) - 1] + 5 * chanIndex) - 1]);
            if (!flag) {
              exitg1 = true;
            } else {
              localB->u = localB->vprev / 2.0;
              if (localB->u < 0.0) {
                localB->u = ceil(localB->u);
              } else {
                localB->u = -0.0;
              }

              localB->p = localB->u + obj_0->pMidHeap;
              localB->u = localB->vprev + obj_0->pMidHeap;
              localB->temp = obj_0->pHeap[(5 * chanIndex + (int32_T)localB->p) -
                1];
              vprev_tmp = ((int32_T)localB->p + 5 * chanIndex) - 1;
              obj_0->pHeap[vprev_tmp] = obj_0->pHeap[(5 * chanIndex + (int32_T)
                localB->u) - 1];
              obj_0->pHeap[((int32_T)localB->u + 5 * chanIndex) - 1] =
                localB->temp;
              obj_0->pPos[((int32_T)obj_0->pHeap[vprev_tmp] + 5 * chanIndex) - 1]
                = localB->p;
              obj_0->pPos[((int32_T)obj_0->pHeap[((int32_T)localB->u + 5 *
                chanIndex) - 1] + 5 * chanIndex) - 1] = localB->u;
              localB->u = localB->vprev / 2.0;
              if (localB->u < 0.0) {
                localB->vprev = ceil(localB->u);
              } else {
                localB->vprev = -0.0;
              }
            }
          }

          if (localB->vprev == 0.0) {
            c_MedianFilterCG_trickleDownMin(obj_0, 1.0, chanIndex + 1, localB);
          }
        }
      } else {
        if (obj_0->pMaxHeapLength != 0.0) {
          c_MedianFilterCG_trickleDownMax(obj_0, -1.0, chanIndex + 1, localB);
        }

        if (obj_0->pMinHeapLength > 0.0) {
          c_MedianFilterCG_trickleDownMin(obj_0, 1.0, chanIndex + 1, localB);
        }
      }

      localB->MedianFilter1[c_index + 80 * chanIndex] = obj_0->pBuf[((int32_T)
        obj_0->pHeap[(5 * chanIndex + (int32_T)obj_0->pMidHeap) - 1] + 5 *
        chanIndex) - 1];
    }
  }

  /* End of Start for MATLABSystem: '<Root>/Median Filter1' */
}

/*
 * Termination for atomic system:
 *    synthesized block
 *    synthesized block
 */
void camera_comm__MedianFilter1_Term(DW_MedianFilter1_camera_comm__T *localDW)
{
  /* Terminate for MATLABSystem: '<Root>/Median Filter1' */
  matlabCodegenHandle_matlabCodeg(&localDW->obj);
}

static void SystemProp_matlabCodegenSet_das(codertarget_linux_blocks_SDLV_T *obj,
  boolean_T value)
{
  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  obj->matlabCodegenIsDeleted = value;
}

static void camera_c_SystemCore_release_das(const
  codertarget_linux_blocks_SDLV_T *obj)
{
  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_SDL_videoDisplayTerminate(0, 0);
  }

  /* End of Start for MATLABSystem: '<S5>/MATLAB System' */
}

static void camera_co_SystemCore_delete_das(const
  codertarget_linux_blocks_SDLV_T *obj)
{
  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  camera_c_SystemCore_release_das(obj);
}

static void matlabCodegenHandle_matlabC_das(codertarget_linux_blocks_SDLV_T *obj)
{
  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSet_das(obj, true);
    camera_co_SystemCore_delete_das(obj);
  }

  /* End of Start for MATLABSystem: '<S5>/MATLAB System' */
}

static void SystemProp_matlabCodegenSetAn_d(codertarget_linux_blocks_Digi_T *obj,
  boolean_T value)
{
  /* Start for MATLABSystem: '<S1>/Digital Write' incorporates:
   *  MATLABSystem: '<S4>/Digital Write'
   */
  obj->matlabCodegenIsDeleted = value;
}

static void camera_co_SystemCore_release_da(const
  codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S4>/Digital Write' */
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_gpioTerminate((uint32_T)camera_comm_finishe_PinNumber_d);
  }

  /* End of Start for MATLABSystem: '<S4>/Digital Write' */
}

static void camera_com_SystemCore_delete_da(const
  codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S4>/Digital Write' */
  camera_co_SystemCore_release_da(obj);
}

static void matlabCodegenHandle_matlabCo_da(codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S4>/Digital Write' */
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetAn_d(obj, true);
    camera_com_SystemCore_delete_da(obj);
  }

  /* End of Start for MATLABSystem: '<S4>/Digital Write' */
}

static void camera_com_SystemCore_release_d(const
  codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S1>/Digital Write' */
  if ((obj->isInitialized == 1) && obj->isSetupComplete) {
    MW_gpioTerminate((uint32_T)camera_comm_finished_PinNumber);
  }

  /* End of Start for MATLABSystem: '<S1>/Digital Write' */
}

static void camera_comm_SystemCore_delete_d(const
  codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S1>/Digital Write' */
  camera_com_SystemCore_release_d(obj);
}

static void matlabCodegenHandle_matlabCod_d(codertarget_linux_blocks_Digi_T *obj)
{
  /* Start for MATLABSystem: '<S1>/Digital Write' */
  if (!obj->matlabCodegenIsDeleted) {
    SystemProp_matlabCodegenSetAn_d(obj, true);
    camera_comm_SystemCore_delete_d(obj);
  }

  /* End of Start for MATLABSystem: '<S1>/Digital Write' */
}

/* Model step function */
void camera_comm_finished_step(void)
{
  int32_T i;

  /* S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureOutput(camera_comm_finished_ConstP.V4L2VideoCapture_p1,
                        camera_comm_finished_B.V4L2VideoCapture_o1,
                        camera_comm_finished_B.V4L2VideoCapture_o2,
                        camera_comm_finished_B.V4L2VideoCapture_o3);

  /* Gain: '<S2>/Slider Gain' incorporates:
   *  Constant: '<Root>/Constant'
   */
  camera_comm_finished_B.SumofElements1 = camera_comm_finished_P.Cb_gain *
    camera_comm_finished_P.Constant_Value;

  /* RelationalOperator: '<Root>/Relational Operator1' */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.RelationalOperator1[i] =
      (camera_comm_finished_B.V4L2VideoCapture_o2[i] >
       camera_comm_finished_B.SumofElements1);
  }

  /* End of RelationalOperator: '<Root>/Relational Operator1' */

  /* DataTypeConversion: '<Root>/Data Type Conversion2' */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.rtb_DataTypeConversion2_m[i] =
      camera_comm_finished_B.RelationalOperator1[i];
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion2' */
  camera_comm_finis_MedianFilter1
    (camera_comm_finished_B.rtb_DataTypeConversion2_m,
     &camera_comm_finished_B.MedianFilter, &camera_comm_finished_DW.MedianFilter);

  /* DataTypeConversion: '<Root>/Data Type Conversion1' incorporates:
   *  Gain: '<Root>/Gain1'
   */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.SumofElements1 = floor
      (camera_comm_finished_P.Gain1_Gain *
       camera_comm_finished_B.MedianFilter.MedianFilter1[i]);
    if (rtIsNaN(camera_comm_finished_B.SumofElements1) || rtIsInf
        (camera_comm_finished_B.SumofElements1)) {
      camera_comm_finished_B.SumofElements1 = 0.0;
    } else {
      camera_comm_finished_B.SumofElements1 = fmod
        (camera_comm_finished_B.SumofElements1, 256.0);
    }

    camera_comm_finished_B.DataTypeConversion1[i] = (uint8_T)
      (camera_comm_finished_B.SumofElements1 < 0.0 ? (int32_T)(uint8_T)-(int8_T)
       (uint8_T)-camera_comm_finished_B.SumofElements1 : (int32_T)(uint8_T)
       camera_comm_finished_B.SumofElements1);
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion1' */

  /* Gain: '<S3>/Slider Gain' incorporates:
   *  Constant: '<Root>/Constant'
   */
  camera_comm_finished_B.SumofElements1 = camera_comm_finished_P.Cr_gain *
    camera_comm_finished_P.Constant_Value;

  /* RelationalOperator: '<Root>/Relational Operator' */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.RelationalOperator[i] =
      (camera_comm_finished_B.V4L2VideoCapture_o3[i] >
       camera_comm_finished_B.SumofElements1);
  }

  /* End of RelationalOperator: '<Root>/Relational Operator' */

  /* DataTypeConversion: '<Root>/Data Type Conversion3' */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.rtb_DataTypeConversion2_m[i] =
      camera_comm_finished_B.RelationalOperator[i];
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion3' */

  /* MATLABSystem: '<Root>/Median Filter1' */
  camera_comm_finis_MedianFilter1
    (camera_comm_finished_B.rtb_DataTypeConversion2_m,
     &camera_comm_finished_B.MedianFilter1,
     &camera_comm_finished_DW.MedianFilter1);

  /* DataTypeConversion: '<Root>/Data Type Conversion' incorporates:
   *  Gain: '<Root>/Gain'
   */
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.SumofElements1 = floor
      (camera_comm_finished_P.Gain_Gain *
       camera_comm_finished_B.MedianFilter1.MedianFilter1[i]);
    if (rtIsNaN(camera_comm_finished_B.SumofElements1) || rtIsInf
        (camera_comm_finished_B.SumofElements1)) {
      camera_comm_finished_B.SumofElements1 = 0.0;
    } else {
      camera_comm_finished_B.SumofElements1 = fmod
        (camera_comm_finished_B.SumofElements1, 256.0);
    }

    camera_comm_finished_B.DataTypeConversion[i] = (uint8_T)
      (camera_comm_finished_B.SumofElements1 < 0.0 ? (int32_T)(uint8_T)-(int8_T)
       (uint8_T)-camera_comm_finished_B.SumofElements1 : (int32_T)(uint8_T)
       camera_comm_finished_B.SumofElements1);
  }

  /* End of DataTypeConversion: '<Root>/Data Type Conversion' */
  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  memcpy(&camera_comm_finished_B.pln1[0],
         &camera_comm_finished_B.V4L2VideoCapture_o1[0], 19200U * sizeof(uint8_T));
  memcpy(&camera_comm_finished_B.pln2[0],
         &camera_comm_finished_B.DataTypeConversion1[0], 9600U * sizeof(uint8_T));
  memcpy(&camera_comm_finished_B.pln3[0],
         &camera_comm_finished_B.DataTypeConversion[0], 9600U * sizeof(uint8_T));
  MW_SDL_videoDisplayOutput(camera_comm_finished_B.pln1,
    camera_comm_finished_B.pln2, camera_comm_finished_B.pln3);

  /* Sum: '<Root>/Sum of Elements' */
  camera_comm_finished_B.SumofElements1 = -0.0;
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.SumofElements1 +=
      camera_comm_finished_B.MedianFilter1.MedianFilter1[i];
  }

  /* Start for MATLABSystem: '<S4>/Digital Write' incorporates:
   *  Constant: '<Root>/Constant1'
   *  Gain: '<S6>/Slider Gain'
   *  RelationalOperator: '<Root>/Relational Operator2'
   *  Sum: '<Root>/Sum of Elements'
   */
  MW_gpioWrite((uint32_T)camera_comm_finishe_PinNumber_d, (uint8_T)
               (camera_comm_finished_B.SumofElements1 >
                camera_comm_finished_P.sum_thresh_gain *
                camera_comm_finished_P.Constant1_Value));

  /* Sum: '<Root>/Sum of Elements1' */
  camera_comm_finished_B.SumofElements1 = -0.0;
  for (i = 0; i < 9600; i++) {
    camera_comm_finished_B.SumofElements1 +=
      camera_comm_finished_B.MedianFilter.MedianFilter1[i];
  }

  /* Start for MATLABSystem: '<S1>/Digital Write' incorporates:
   *  Constant: '<Root>/Constant2'
   *  Gain: '<S7>/Slider Gain'
   *  RelationalOperator: '<Root>/Relational Operator3'
   *  Sum: '<Root>/Sum of Elements1'
   */
  MW_gpioWrite((uint32_T)camera_comm_finished_PinNumber, (uint8_T)
               (camera_comm_finished_B.SumofElements1 >
                camera_comm_finished_P.sum_thresh1_gain *
                camera_comm_finished_P.Constant2_Value));

  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.1s, 0.0s] */
    rtExtModeUpload(0, camera_comm_finished_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.1s, 0.0s] */
    if ((rtmGetTFinal(camera_comm_finished_M)!=-1) &&
        !((rtmGetTFinal(camera_comm_finished_M)-
           camera_comm_finished_M->Timing.taskTime0) >
          camera_comm_finished_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(camera_comm_finished_M, "Simulation finished");
    }

    if (rtmGetStopRequested(camera_comm_finished_M)) {
      rtmSetErrorStatus(camera_comm_finished_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  camera_comm_finished_M->Timing.taskTime0 =
    (++camera_comm_finished_M->Timing.clockTick0) *
    camera_comm_finished_M->Timing.stepSize0;
}

/* Model initialize function */
void camera_comm_finished_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)camera_comm_finished_M, 0,
                sizeof(RT_MODEL_camera_comm_finished_T));
  rtmSetTFinal(camera_comm_finished_M, -1);
  camera_comm_finished_M->Timing.stepSize0 = 0.1;

  /* External mode info */
  camera_comm_finished_M->Sizes.checksums[0] = (2268878401U);
  camera_comm_finished_M->Sizes.checksums[1] = (174347758U);
  camera_comm_finished_M->Sizes.checksums[2] = (3968969316U);
  camera_comm_finished_M->Sizes.checksums[3] = (1439976994U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[7];
    camera_comm_finished_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    systemRan[4] = &rtAlwaysEnabled;
    systemRan[5] = &rtAlwaysEnabled;
    systemRan[6] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(camera_comm_finished_M->extModeInfo,
      &camera_comm_finished_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(camera_comm_finished_M->extModeInfo,
                        camera_comm_finished_M->Sizes.checksums);
    rteiSetTPtr(camera_comm_finished_M->extModeInfo, rtmGetTPtr
                (camera_comm_finished_M));
  }

  /* block I/O */
  (void) memset(((void *) &camera_comm_finished_B), 0,
                sizeof(B_camera_comm_finished_T));

  /* states (dwork) */
  (void) memset((void *)&camera_comm_finished_DW, 0,
                sizeof(DW_camera_comm_finished_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    camera_comm_finished_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 17;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Start for S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureInit(camera_comm_finished_ConstP.V4L2VideoCapture_p1, 0, 0, 0,
                      0, 160U, 120U, 1U, 2U, 1U, 0.1);
  camera_comm_MedianFilter1_Start(&camera_comm_finished_DW.MedianFilter);

  /* Start for MATLABSystem: '<Root>/Median Filter1' */
  camera_comm_MedianFilter1_Start(&camera_comm_finished_DW.MedianFilter1);

  /* Start for MATLABSystem: '<S5>/MATLAB System' */
  camera_comm_finished_DW.obj.matlabCodegenIsDeleted = true;
  camera_comm_finished_DW.obj.isInitialized = 0;
  camera_comm_finished_DW.obj.matlabCodegenIsDeleted = false;
  camera_comm_finished_DW.obj.isSetupComplete = false;
  camera_comm_finished_DW.obj.isInitialized = 1;
  camera_comm_finished_DW.obj.PixelFormatEnum = 2;
  MW_SDL_videoDisplayInit(camera_comm_finished_DW.obj.PixelFormatEnum, 1, 1,
    160.0, 120.0);
  camera_comm_finished_DW.obj.isSetupComplete = true;

  /* End of Start for SubSystem: '<Root>/SDL Video Display' */

  /* Start for MATLABSystem: '<S4>/Digital Write' */
  camera_comm_finished_DW.obj_c.matlabCodegenIsDeleted = true;
  camera_comm_finished_DW.obj_c.isInitialized = 0;
  camera_comm_finished_DW.obj_c.matlabCodegenIsDeleted = false;
  camera_comm_finished_DW.obj_c.isSetupComplete = false;
  camera_comm_finished_DW.obj_c.isInitialized = 1;
  MW_gpioInit((uint32_T)camera_comm_finishe_PinNumber_d, true);
  camera_comm_finished_DW.obj_c.isSetupComplete = true;

  /* Start for MATLABSystem: '<S1>/Digital Write' */
  camera_comm_finished_DW.obj_m.matlabCodegenIsDeleted = true;
  camera_comm_finished_DW.obj_m.isInitialized = 0;
  camera_comm_finished_DW.obj_m.matlabCodegenIsDeleted = false;
  camera_comm_finished_DW.obj_m.isSetupComplete = false;
  camera_comm_finished_DW.obj_m.isInitialized = 1;
  MW_gpioInit((uint32_T)camera_comm_finished_PinNumber, true);
  camera_comm_finished_DW.obj_m.isSetupComplete = true;
  camera_comm__MedianFilter1_Init(&camera_comm_finished_DW.MedianFilter);
  camera_comm__MedianFilter1_Init(&camera_comm_finished_DW.MedianFilter1);
}

/* Model terminate function */
void camera_comm_finished_terminate(void)
{
  /* Terminate for S-Function (v4l2_video_capture_sfcn): '<Root>/V4L2 Video Capture' */
  MW_videoCaptureTerminate(camera_comm_finished_ConstP.V4L2VideoCapture_p1);
  camera_comm__MedianFilter1_Term(&camera_comm_finished_DW.MedianFilter);

  /* Terminate for MATLABSystem: '<Root>/Median Filter1' */
  camera_comm__MedianFilter1_Term(&camera_comm_finished_DW.MedianFilter1);

  /* Terminate for MATLABSystem: '<S5>/MATLAB System' */
  matlabCodegenHandle_matlabC_das(&camera_comm_finished_DW.obj);

  /* End of Terminate for SubSystem: '<Root>/SDL Video Display' */

  /* Terminate for MATLABSystem: '<S4>/Digital Write' */
  matlabCodegenHandle_matlabCo_da(&camera_comm_finished_DW.obj_c);

  /* Terminate for MATLABSystem: '<S1>/Digital Write' */
  matlabCodegenHandle_matlabCod_d(&camera_comm_finished_DW.obj_m);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
