//
//  DeviceInfo.m
//  APFeedBack
//
//  Created by Parti Albert on 2016. 04. 05..
//  Copyright © 2016. Albert Parti. All rights reserved.
//

#import "DeviceInfo.h"
#import <sys/sysctl.h>


@implementation DeviceInfo

+ (instancetype) deviceManager {
    static DeviceInfo * deviceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       deviceManager = [[[self class] alloc] init];
    });
    return deviceManager;
}

-(NSString *)systemversion
{
 
    return [UIDevice currentDevice].systemVersion;
    
}

-(NSString *)infoVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
}
-(NSString *)appBuild
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
    
}

- (NSString *)appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]?
    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]:
    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

-(NSData *)LogPathData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *txtFilePath = [documentsDirectory stringByAppendingPathComponent:@"feedbacklog.txt"];
    NSData *noteData = [NSData dataWithContentsOfFile:txtFilePath];
    
    return noteData;
}

-(void)logfilecreate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL developer = [defaults boolForKey:developer_Key];
    if (developer) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"feedbacklog.txt"];
        freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
       // freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stdout);
        NSLog(@"developer");
    }
}


- (NSString *)platformString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);

    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone13,1"])   return @"iPhone 12 Mini";
    if ([platform isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"])   return @"iPhone 13 Mini";
    if ([platform isEqualToString:@"iPhone14,5"])   return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"])   return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"])   return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,6"])   return @"iPhone SE (3rd generation)";
    if ([platform isEqualToString:@"iPhone15,2"])   return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone15,3"])   return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,4"])   return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,5"])   return @"iPhone 14 Pro Max";
    if ([platform isEqualToString:@"iPhone16,1"])   return @"iPhone 15";
    if ([platform isEqualToString:@"iPhone16,2"])   return @"iPhone 15 Plus";
    if ([platform isEqualToString:@"iPhone16,3"])   return @"iPhone 15 Pro";
    if ([platform isEqualToString:@"iPhone16,4"])   return @"iPhone 15 Pro Max";
    if ([platform isEqualToString:@"iPhone17,1"])   return @"iPhone 16";
    if ([platform isEqualToString:@"iPhone17,2"])   return @"iPhone 16 Plus";
    if ([platform isEqualToString:@"iPhone17,3"])   return @"iPhone 16 Pro";
    if ([platform isEqualToString:@"iPhone17,4"])   return @"iPhone 16 Pro Max";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod Touch (7th generation)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch (Cellular)";
    if ([platform isEqualToString:@"iPad8,1"])      return @"iPad Pro 11-inch (WiFi)";
    if ([platform isEqualToString:@"iPad8,2"])      return @"iPad Pro 11-inch (Cellular)";
    if ([platform isEqualToString:@"iPad8,3"])      return @"iPad Pro 11-inch (WiFi)";
    if ([platform isEqualToString:@"iPad8,4"])      return @"iPad Pro 11-inch (Cellular)";
    if ([platform isEqualToString:@"iPad8,9"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad8,10"])     return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad8,11"])     return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad8,12"])     return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad9,1"])      return @"iPad 9 (WiFi)";
    if ([platform isEqualToString:@"iPad9,2"])      return @"iPad 9 (Cellular)";
    if ([platform isEqualToString:@"iPad9,3"])      return @"iPad 9 (WiFi)";
    if ([platform isEqualToString:@"iPad9,4"])      return @"iPad 9 (Cellular)";
    if ([platform isEqualToString:@"iPad10,1"])     return @"iPad 10 (WiFi)";
    if ([platform isEqualToString:@"iPad10,2"])     return @"iPad 10 (Cellular)";
    if ([platform isEqualToString:@"iPad10,3"])     return @"iPad Air (5th generation)";
    if ([platform isEqualToString:@"iPad10,4"])     return @"iPad Air (5th generation)";
    if ([platform isEqualToString:@"iPad10,5"])     return @"iPad Air (5th generation)";
    if ([platform isEqualToString:@"iPad10,6"])     return @"iPad Air (5th generation)";
    if ([platform isEqualToString:@"iPad11,1"])     return @"iPad Mini (6th generation)";
    if ([platform isEqualToString:@"iPad11,2"])     return @"iPad Mini (6th generation)";
    if ([platform isEqualToString:@"iPad13,1"])     return @"iPad Pro 11-inch (6th generation)";
    if ([platform isEqualToString:@"iPad13,2"])     return @"iPad Pro 11-inch (6th generation)";
    if ([platform isEqualToString:@"iPad13,3"])     return @"iPad Pro 12.9-inch (6th generation)";
    if ([platform isEqualToString:@"iPad13,4"])     return @"iPad Pro 12.9-inch (6th generation)";
    if ([platform isEqualToString:@"iPad14,1"])     return @"iPad Pro 12.9-inch (7th generation)";
    if ([platform isEqualToString:@"iPad14,2"])     return @"iPad Pro 12.9-inch (7th generation)";

    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}

@end
