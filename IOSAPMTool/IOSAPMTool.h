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

    float getAppUsedCPU(void);
    
    float getAppUsedMemory(void);
    
    float getSysAllMemory(void);
    
    float getSysFreeMemory(void);
    
    float getSysUsedMemory(void);
    
    double getBatteryLevel(void);

    float availableMemory(void);
    
#ifdef __cplusplus
}
#endif

#endif /* IOSAPMTool_h */
