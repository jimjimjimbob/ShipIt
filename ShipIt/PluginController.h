//
//  SIServicesManager.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIDeliveryPluginProtocol.h"
#import "SIPackagingPluginProtocol.h"
#import "SIPluginProtocol.h"

@interface PluginController : NSObject {
@private
    NSSet *plugins;
}

+ (PluginController *) sharedInstance;
@end

@interface PluginController (PrivateMethods) {
@private

}

- (id)init;
+ (void)initialize;
+ (NSSet *)loadPlugins;

@end

