//
//  SIPreferenceController.m
//  ShipIt
//
//  Created by doomspork on 5/17/11.
//  Copyright 2011 Codez4Mac.com All rights reserved.
//

#import "SIPreferenceController.h"


@implementation SIPreferenceController

@synthesize startUpToggle;
@synthesize general;
@synthesize about;
@synthesize transition;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        [self setCurrentView: general];
    }
    
    return self;
}

- (void)dealloc
{
    [currentView release];
    [about release];
    [general release];
    [startUpToggle release];
    [transition release];
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (void)awakeFromNib {
    NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	if ([self loginItemExistsWithLoginItemReference:loginItems ForPath:appPath]) {
		[startUpToggle setState:NSOnState];
	}
	CFRelease(loginItems); 
    
    
    if(!currentView) {
        currentView = general;   
    }
    
    NSView *contentView = [[self window] contentView];
    [contentView setWantsLayer:YES];
    [contentView addSubview: currentView];
    [contentView setHidden: NO];
    
    transition = [[CATransition animation] retain];
    [transition setType:kCATransitionFade];
    NSDictionary *ani = [NSDictionary dictionaryWithObject:transition 
                                                    forKey:@"subviews"];
    
    [contentView setAnimations:ani];
    [[self window] center];
}

- (void)setCurrentView:(NSView *)newView {
    [newView retain];
    if (!currentView) {
        currentView = newView;
        return;
    }
    
    [self resizeWindowForContentSize: [newView frame].size];
    NSView *contentView = [[self window] contentView];

    NSPoint origin = NSMakePoint(0, 0);
    [newView setFrameOrigin: origin];
    [[contentView animator] replaceSubview:currentView with:newView];
    
    [currentView release];
    currentView = newView;
}

- (NSView *)currentView {
    return currentView;
}

- (IBAction)showGeneralView:(id)sender {
    [transition setSubtype:kCATransitionFromRight];
    [self setCurrentView:general];
}

- (IBAction)showAboutView:(id)sender {
    [transition setSubtype:kCATransitionFromLeft];
    [self setCurrentView:about];
}

- (IBAction)toggleStartUp:(id)sender {
    if ([sender isKindOfClass: [NSButton class]]) {
        NSString * appPath = [[NSBundle mainBundle] bundlePath];
        LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
        if (loginItems) {
            if ([sender state] == NSOnState)
                [self enableLoginItemWithLoginItemsReference:loginItems ForPath:appPath];
            else
                [self disableLoginItemWithLoginItemsReference:loginItems ForPath:appPath];
        }
    }
}

@end

@implementation SIPreferenceController (PrivateMethods)

- (void)resizeWindowForContentSize:(NSSize) size {
    NSWindow *window = [self window];
    
    NSRect windowFrame = [window contentRectForFrameRect:[window frame]];
    NSRect newWindowFrame = [window frameRectForContentRect:
                             NSMakeRect( NSMinX( windowFrame ), NSMaxY( windowFrame ) - size.height, size.width, size.height )];
    [window setFrame:newWindowFrame display:YES animate:[window isVisible]];
}

- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath {
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath];
	LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(theLoginItemsRefs, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);		
	if (item)
		CFRelease(item);
}

- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath {
	UInt32 seedValue;
	CFURLRef thePath;

	NSArray *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);
	for (id item in loginItemsArray) {		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &thePath, NULL) == noErr) {
            NSString *urlPath = [(NSURL *)thePath path];
			if ([urlPath compare:appPath] == NSOrderedSame) {
				LSSharedFileListItemRemove(theLoginItemsRefs, itemRef);
			}
			CFRelease(thePath);
		}		
	}
    [loginItemsArray release];
}

- (BOOL)loginItemExistsWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString *)appPath {
	BOOL found = NO;  
	UInt32 seedValue;
	CFURLRef thePath;
    
	NSArray *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);
    [loginItemsArray retain];
	for (id item in loginItemsArray) {    
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &thePath, NULL) == noErr) {
            NSString *urlPath = [(NSURL *)thePath path];
			if ([urlPath compare:appPath] == NSOrderedSame) {
				found = YES;
				break;
			}
		}
		CFRelease(thePath);
	}
    [loginItemsArray release];
	return found;
}
@end