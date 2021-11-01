using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class IOSAPMSDK : MonoBehaviour
{
    [DllImport("__Internal")]
    internal extern static float GetProcessUsedCPU();         //返回当前进程占用的cpu, %
    [DllImport("__Internal")]
    internal extern static float GetMemoryFootprint();      //返回当前进程使用的内存, 单位M
    [DllImport("__Internal")]
    internal extern static float GetDeviceTotalMemory();      //返回设备总的内存, 单位M
    [DllImport("__Internal")]
    internal extern static float GetDeviceFreeMemory();       //返回设备剩余的内存, 单位M
    [DllImport("__Internal")]
    internal extern static float GetDeviceUsedMemory();       //返回设备已经使用的内存, 单位M
    [DllImport("__Internal")]
    internal extern static double GetBatteryLevel();          //返回当前电池电量，%
    [DllImport("__Internal")]
    internal extern static float GetDeviceAvailableMemory();  //该接口返回的数值等于设备总内存减去脏内存的大小,仅适用于ios 13.0以上的版本， M

    // Start is called before the first frame update
    void Start()
    {
        #if UNITY_IPHONE 
        float app_cpu_used = GetProcessUsedCPU();
        float app_memory_used = GetProcessUsedMemory();
        float sys_memory_all = GetDeviceTotalMemory();
        float sys_memory_free = GetDeviceFreeMemory();
        float sys_memory_used = GetDeviceUsedMemory();
        double battery_level = GetBatteryLevel();
        float ava_memory = GetDeviceAvailableMemory();
        #endif
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
