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

@interface SIPluginController : NSObject {
@private
    NSSet *deliveryPlugins;
    NSSet *packagingPlugins;
}

+ (SIPluginController *) sharedInstance;
+ (NSSet *)availableDeliveryPlugins;
+ (NSSet *)availablePackagingPlugins;
- (NSSet *)selectedDeliveryPlugins;
- (NSSet *)selectedPackagingPlugins;
- (void)forDeliveryPluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument;
- (void)forPackagingPluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument;
@end

@interface SIPluginController (PrivateMethods){
@private

}

- (id)init;
+ (void)initialize;
- (NSSet *)loadDeliveryPluginsFromPreferences;
- (NSSet *)loadPackagingPluginsFromPreferences;
+ (NSSet *)availablePluginsInDirectory:(NSString *)aDirectory forProtocol:(Protocol *)aProtocol;

@end

