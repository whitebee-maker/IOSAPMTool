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

    float GetProcessUsedCPU(void);
    
    float GetProcessUsedMemory(void);
    
    float GetDeviceTotalMemory(void);
    
    float GetDeviceFreeMemory(void);
    
    float GetDeviceUsedMemory(void);
    
    double GetBatteryLevel(void);

    float GetDeviceAvailableMemory(void);
    
#ifdef __cplusplus
}
#endif

#endif /* IOSAPMTool_h */
