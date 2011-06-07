//
//  SIPluginProtocol.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SIPluginProtocol <NSObject>
- (id)initializePluginWithPreferences: (NSDictionary *)prefs;
- (void)terminatePlugin;
+ (NSString *)name;
+ (NSString *)description;
+ (NSView *)view;
@end
