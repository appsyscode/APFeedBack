//
//  DeviceInfo.h
//  FeedBack
//
//  Created by Parti Albert on 2016. 04. 05..
//  Copyright © 2016. Albert Parti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APFeedTableViewController.h"

@interface DeviceInfo : NSObject

+ (instancetype) deviceManager;

-(NSString *)systemversion;
-(NSString *)infoVersion;
-(NSString *)appBuild;
-(NSString *)appName;
-(NSString *)platformString;

-(NSData *)LogPathData;
-(void)logfilecreate;

@end
