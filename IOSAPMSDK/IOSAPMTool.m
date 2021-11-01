//
//  IOSAPMTool.m
//  APMTool
//
//  Created by xk on 2021/10/25.
//

#import <Foundation/Foundation.h>
#import <mach/task.h>
#import <mach/vm_map.h>
#import <mach/mach_init.h>
#import <mach/thread_act.h>
#import <mach/thread_info.h>
#import <mach/mach_host.h>
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <os/proc.h>
#import <UIKit/UIKit.h>
#import "IOSAPMTool.h"

#define NBYTE_PER_MB (float)(1024 * 1024)

// 获取当前app的cpu占有率， %
float GetProcessUsedCPU(void)
{
    kern_return_t           kr;
    thread_array_t          thread_list;
    mach_msg_type_number_t  thread_count;
    thread_info_data_t      thinfo;
    mach_msg_type_number_t  thread_info_count;
    thread_basic_info_t     basic_info_th;
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    float cpu_usage = 0;

    for (int i = 0; i < thread_count; i++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO,(thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;

        if (!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            cpu_usage += basic_info_th->cpu_usage;
        }
    }

    cpu_usage = cpu_usage / (float)TH_USAGE_SCALE * 100.0;

    vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));

    return cpu_usage;
}

// 获取当前app使用的内存大小，单位M
float GetProcessUsedMemory(void)
{

    task_vm_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&taskInfo, &infoCount);
 
    if (kernReturn != KERN_SUCCESS) {
        return 0;
    }
    return taskInfo.phys_footprint / NBYTE_PER_MB;
}

// 获取ios剩余可用的内存大小， 单位M
float GetDeviceFreeMemory(void)
{
    vm_statistics64_data_t vmstat;
    natural_t size = HOST_VM_INFO64_COUNT;
    if (host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vmstat, &size) == KERN_SUCCESS) {
        int64_t memory_free = vmstat.free_count * PAGE_SIZE / NBYTE_PER_MB;
        int64_t memory_inactive = vmstat.inactive_count * PAGE_SIZE / NBYTE_PER_MB;
        return memory_free + memory_inactive;
    }
    return 0;
}

// 获取ios全部的内存使用情况，单位M
float GetDeviceUsedMemory(void)
{
    vm_statistics64_data_t vmstat;
    natural_t size = HOST_VM_INFO64_COUNT;
    if (host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vmstat, &size) == KERN_SUCCESS) {
        int64_t memory_used = (vmstat.active_count + vmstat.wire_count) * PAGE_SIZE / NBYTE_PER_MB;
        return memory_used;
    }
    return 0;
}

// 获取ios总内存大小，单位M
float GetDeviceTotalMemory(void)
{
    vm_statistics64_data_t vmstat;
    natural_t size = HOST_VM_INFO64_COUNT;
    if (host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vmstat, &size) == KERN_SUCCESS) {
        int64_t memory_all = (vmstat.active_count + vmstat.wire_count + vmstat.free_count + vmstat.inactive_count) * PAGE_SIZE / NBYTE_PER_MB;
        return memory_all;
    }
    return 0;
}

// 获取当前的电量，百分比
double GetBatteryLevel(void)
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    return device.batteryLevel;
}

/*
* The size returned is not representative of the total memory of the device, it
* is the current dirty memory limit minus the dirty memory footprint used at the
* time of the query.
*/
float GetDeviceAvailableMemory()
{
    if (@available(iOS 13.0, *)) {
        return os_proc_available_memory() / NBYTE_PER_MB;
    }
    return -1.0;
}

//用于测试unity是否成功调用上面的函数
void RecvFromUnity(float app_cpu_used, float app_memory_used, float sys_memory_all, float sys_memory_free, float sys_memory_used, double battery_level, float ava_mem)
{
    NSLog(@"app_cpu_used : %f", app_cpu_used);
    NSLog(@"app_memory_used : %f", app_memory_used);
    NSLog(@"sys_memory_all : %f", sys_memory_all);
    NSLog(@"sys_memory_free : %f", sys_memory_free);
    NSLog(@"sys_memory_used : %f", sys_memory_used);
    NSLog(@"battery_level : %f", battery_level);
    NSLog(@"ava_mem : %f", ava_mem);
    return;
}

