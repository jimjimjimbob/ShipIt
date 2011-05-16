//
//  CMDroppableView.h
//  ShipIt!
//
//  Created by doomspork on 5/14/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define StatusItemViewPaddingWidth  6
#define StatusItemViewPaddingHeight 3

@interface CMDroppableView : NSView <NSMenuDelegate>{
	NSStatusItem *statusItem;
	NSString *title;
    NSObject *delegate;
	BOOL isMenuVisible;
    BOOL isDragActive;
}
@property (retain, nonatomic) NSObject *delegate;
@property (retain, nonatomic) NSStatusItem *statusItem;
@property (retain, nonatomic) NSString *title;

- (void)setTitle:(NSString *)newTitle;
- (NSString *)title;
/*
 - (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender;
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender;
- (void)draggingExited:(id <NSDraggingInfo>)sender;
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender;
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender;
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender;
 */
@end
