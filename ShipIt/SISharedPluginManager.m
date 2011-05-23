//
//  SISharedPluginManager.m
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import "SISharedPluginManager.h"

@implementation SISharedPluginManager 

+ (SISharedPluginManager *) sharedInstance 
{                                                                    
    static SISharedPluginManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[SISharedPluginManager alloc] init];
        
        return sharedSingleton;
    }                                                                     
}

- (void)dealloc
{
    [super dealloc];
}


+ (NSSet *)availableDeliveryPlugins
{
    return [self availablePluginsInDirectory: @"~/Library/Application Support/ShipIt/Plugins/Delivery" 
                                  forProtocol: @protocol(SIDeliveryPluginProtocol)];
}

+ (NSSet *)availablePackagingPlugins
{
    return [self availablePluginsInDirectory: @"~/Library/Application Support/ShipIt/Plugins/Packaging" 
                                  forProtocol: @protocol(SIPackagePluginProtocol)];
}

- (NSSet *)selectedDeliveryPlugins
{
    return [deliveryPlugins copy];
}

- (NSSet *)selectedPackagingPlugins
{
    return [packagingPlugins copy];
}

- (void)forDeliveryPluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument 
{
    [deliveryPlugins makeObjectsPerformSelector: aSelector withObject:anArgument];
}

- (void)forPackagingPluginsPerformSelector:(SEL)aSelector withObject:(id)anArgument
{
    [packagingPlugins makeObjectsPerformSelector: aSelector withObject:anArgument];
}

@end

@implementation SISharedPluginManager (PrivateMethods)

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void) initialize 
{
    [super initialize];
}

- (NSSet *)loadDeliveryPluginsFromPreferences
{
    return nil;
}

- (NSSet *)loadPackagingPluginsFromPreferences 
{
    return nil;
}

+ (NSSet *)availablePluginsInDirectory:(NSString *)aDirectory forProtocol:(Protocol *)aProtocol 
{
    NSArray * plugins = [NSBundle pathsForResourcesOfType:@"plugin" 
                                              inDirectory:[aDirectory stringByExpandingTildeInPath]];
    
    NSMutableSet *set = [NSMutableSet setWithCapacity: [plugins count]];
    for(id path in plugins) {
        NSBundle *pluginBundle = [NSBundle bundleWithPath: path];
        NSDictionary* pluginDict = [pluginBundle infoDictionary];
        NSString* pluginName = [pluginDict objectForKey:@"NSPrincipalClass"];
        Class pluginClass = NSClassFromString(pluginName);
        if (!pluginClass) {
            pluginClass = [pluginBundle principalClass];
        }
        if ([pluginClass conformsToProtocol: aProtocol] && 
            [pluginClass isKindOfClass: [NSObject class]]) {
            [set addObject: pluginClass];
        }
    }
    return [NSSet setWithSet: set];
}
@end
