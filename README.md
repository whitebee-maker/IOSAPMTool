* 在unity项目的Assets目录下创建C#脚本
![alt](2.png)

* 将IOSAPMTool.h和IOSAPMTool.m拉到Assets文件夹下面，按照如图配置，只需保留ios选项
![alt](3.png)
![alt](1.png)

* C#脚本添加该行
```
using System.Runtime.InteropServices;  //DllImport的库
```

* 添加函数,getAppUsedCPU函数名与OC文件的函数名一致
```
[DllImport("__Internal")]
internal extern static float getAppUsedCPU();
```

* 调用，在Start当中调用, 指定平台一定要用#if UNITY_IPHONE和#endif包起来
```
    void Start()
    {
        #if UNITY_IPHONE 
        float app_cpu_used = GetProcessUsedCPU();
        float app_memory_used = GetMemoryFootprint();
        float sys_memory_all = GetDeviceTotalMemory();
        float sys_memory_free = GetDeviceFreeMemory();
        float sys_memory_used = GetDeviceUsedMemory();
        double battery_level = GetBatteryLevel();
        float ava_memory = GetDeviceAvailableMemory();
        #endif
    }
```

* 最后快捷键command + shift + B进行编译构建为xcode项目，运行xcode项目