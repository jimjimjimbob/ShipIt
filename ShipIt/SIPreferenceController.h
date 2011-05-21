//
//  SIPreferenceController.h
//  ShipIt
//
//  Created by Sean Callan on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SIPreferenceController : NSWindowController {
@private
    IBOutlet NSButton *startUpToggle;
}
@property (retain) IBOutlet NSButton *startUpToggle;

- (IBAction)toggleStartUp:(id)sender;

@end

@interface SIPreferenceController (PrivateMethods)
- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (BOOL)loginItemExistsWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString *)appPath;
@end