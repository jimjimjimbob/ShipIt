//
//  SIPluginController.m
//  ShipIt
//
//  Created by doomspork on 5/21/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import "PluginController.h"

@implementation PluginController 

+ (PluginController *) sharedInstance 
{                                                                    
    static PluginController *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[PluginController alloc] init];
        return sharedSingleton;
    }                                                                     
}

- (void)dealloc
{
    [plugins release];
    [super dealloc];
}

@end

@implementation PluginController (PrivateMethods)

- (id)init
{
    self = [super init];
    if (self) {
        plugins = [PluginController loadPlugins];
    }
    return self;
}

+ (void) initialize 
{
    [super initialize];
}

+ (NSSet *)loadPlugins
{
    NSString *mainBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingString: @"/Plugins"];
    NSArray *packagedPlugins = [NSBundle pathsForResourcesOfType:@"plugin" 
                                             inDirectory:[mainBundle stringByExpandingTildeInPath]];
    NSArray *thirdPartyPlugins = [NSBundle pathsForResourcesOfType:@"plugin" 
                                                       inDirectory:[@"~/Library/Application Support/ShipIt/Plugins" stringByExpandingTildeInPath]];
    NSArray *plugins = [[NSArray arrayWithArray: packagedPlugins] arrayByAddingObjectsFromArray: thirdPartyPlugins];
    NSMutableSet *set = [NSMutableSet setWithCapacity: [plugins count]];
    for(id path in plugins) {
        NSBundle *pluginBundle = [NSBundle bundleWithPath: path];
        NSDictionary* pluginDict = [pluginBundle infoDictionary];
        NSString* pluginName = [pluginDict objectForKey:@"NSPrincipalClass"];
        Class pluginClass = NSClassFromString(pluginName);
        if (!pluginClass) {
            pluginClass = [pluginBundle principalClass];
        }
        if ([pluginClass isKindOfClass: [NSObject class]]) {
            [set addObject: pluginClass];
        }
    }
    return [NSSet setWithSet: set];
}
@end
