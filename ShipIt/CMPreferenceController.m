//
//  CMPreferenceController.m
//  ShipIt
//
//  Created by Sean Callan on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CMPreferenceController.h"


@implementation CMPreferenceController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (IBAction)toggleStartUp:(id)sender {
    if ([sender isKindOfClass: [NSButton class]]) {
        if ([sender state] == NSOnState) {
            NSLog(@"Start automatically.");
        } else {
            NSLog(@"Do not start automatically.");            
        }
    }
}

@end
