//
//  SIServicesManager.h
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIDeliveryPluginProtocol.h"
#import "SIPackagePluginProtocol.h"
#import "SIPluginProtocol.h"

@interface SISharedPluginManager : NSObject {
@private
    NSSet *deliveryPlugins;
    NSSet *packagePlugins;
}

+ (SISharedPluginManager *) sharedInstance;
+ (NSSet *)availableDeliveryPlugins;
+ (NSSet *)availablePackagePlugins;
- (NSSet *)selectedDeliveryPlugins;
- (NSSet *)selectedPackagePlugins;
- (void)forDeliveryPluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument;
- (void)forPackagePluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument;
@end

@interface SISharedPluginManager (PrivateMethods){
@private

}

- (id)init;
+ (void)initialize;
- (NSSet *)loadDeliveryPluginsFromPreferences;
- (NSSet *)loadPackagePluginsFromPreferences;
+ (NSSet *)availablePluginsInDirectory:(NSString *)aDirectory forProtocol:(Protocol *)aProtocol;

@end

