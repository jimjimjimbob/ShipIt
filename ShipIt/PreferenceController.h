//
//  SIPreferenceController.h
//  ShipIt
//
//  Created by doomspork on 5/17/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>

@interface PreferenceController : NSWindowController {
@private
    IBOutlet NSButton *startUpToggle;
    IBOutlet NSView *general;
    IBOutlet NSView *about;
    IBOutlet NSView *currentView;
    CATransition *transition;

}
@property (retain) IBOutlet NSButton *startUpToggle;
@property (retain) CATransition *transition;
@property (retain) IBOutlet NSView *general;
@property (retain) IBOutlet NSView *about;
@property (retain) IBOutlet NSView *currentView;

- (void)setCurrentView: (NSView *) aNewView;
- (IBAction)showGeneralView: (id) sender;
- (IBAction)showAboutView: (id) sender;
- (IBAction)toggleStartUp:(id)sender;

@end

@interface PreferenceController (PrivateMethods)
- (void)resizeWindowForContentSize: (NSSize)size;
- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (BOOL)loginItemExistsWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString *)appPath;
@end