using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class IOSAPMSDK : MonoBehaviour
{
    [DllImport("__Internal")]
    internal extern static float getAppUsedCPU();
    [DllImport("__Internal")]
    internal extern static float getAppUsedMemory();
    [DllImport("__Internal")]
    internal extern static float getSysAllMemory();
    [DllImport("__Internal")]
    internal extern static float getSysFreeMemory();
    [DllImport("__Internal")]
    internal extern static float getSysUsedMemory();
    [DllImport("__Internal")]
    internal extern static double getBatteryLevel();
    [DllImport("__Internal")]
    internal extern static float availableMemory();  //该接口返回的数值等于设备总内存减去脏内存的大小,仅适用于ios 13.0以上的版本

    // Start is called before the first frame update
    void Start()
    {
        #if UNITY_IPHONE 
        float app_cpu_used = getAppUsedCPU();
        float app_memory_used = getAppUsedMemory();
        float sys_memory_all = getSysAllMemory();
        float sys_memory_free = getSysFreeMemory();
        float sys_memory_used = getSysUsedMemory();
        double battery_level = getBatteryLevel();
        float ava_memory = availableMemory();
        #endif
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
