//
//  SIPackagingPluginProtocol.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIPluginProtocol.h"

@protocol SIPackagingPluginProtocol <SIPluginProtocol>
+ (NSData *)packageURLArrayAsData: (NSArray *)urls;
+ (NSString *)extension;
@end
