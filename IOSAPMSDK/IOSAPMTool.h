//
//  IOSAPMTool.h
//  APMTool
//
//  Created by xk on 2021/10/25.
//

#ifndef IOSAPMTool_h
#define IOSAPMTool_h

#ifdef __cplusplus
extern "C"{
#endif

    float GetAppUsedCPU(void);
    
    float GetAppUsedMemory(void);
    
    float GetSysAllMemory(void);
    
    float GetSysFreeMemory(void);
    
    float GetSysUsedMemory(void);
    
    double GetBatteryLevel(void);

    float AvailableMemory(void);  //该接口返回的数值等于设备总内存减去脏内存的大小,仅适用于ios 13.0以上的版本
    
#ifdef __cplusplus
}
#endif

#endif /* IOSAPMTool_h */
