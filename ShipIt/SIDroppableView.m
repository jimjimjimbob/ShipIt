//
//  SIDroppableView.m
//  ShipIt!
//
//  Created by doomspork on 5/14/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "SIDroppableView.h"


@implementation SIDroppableView

@synthesize statusItem;
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        statusItem = nil;
        title = @"";
		isMenuVisible = NO;
        isDragActive = NO;
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
    return self;
}

- (void)dealloc {
    [statusItem release];
    [title release];
    [super dealloc];
}
- (void)mouseDown:(NSEvent *)event {
    [[self menu] setDelegate:self];
    [statusItem popUpStatusItemMenu:[self menu]];
    [self setNeedsDisplay:YES];
}

- (void)rightMouseDown:(NSEvent *)event {
    [self mouseDown:event];
}

- (void)menuWillOpen:(NSMenu *)menu {
    isMenuVisible = YES;
    [self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu {
    isMenuVisible = NO;
    [menu setDelegate:nil];    
    [self setNeedsDisplay:YES];
}

- (NSColor *)titleForegroundColor {
    if (isMenuVisible) {
        return [NSColor whiteColor];
    } else if (isDragActive) {
        return [NSColor blueColor];  
    } else {
        return [NSColor blackColor];
    }    
}

- (NSDictionary *)titleAttributes {
    // Use default menu bar font size
    NSFont *font = [NSFont menuBarFontOfSize:0];
	
    NSColor *foregroundColor = [self titleForegroundColor];
	
    return [NSDictionary dictionaryWithObjectsAndKeys:
            font,            NSFontAttributeName,
            foregroundColor, NSForegroundColorAttributeName,
            nil];
}

- (NSRect)titleBoundingRect {
    return [title boundingRectWithSize:NSMakeSize(1e100, 1e100)
                               options:0
                            attributes:[self titleAttributes]];
}

- (void)setTitle:(NSString *)newTitle {
    if (![title isEqual:newTitle]) {
        [newTitle retain];
        [title release];
        title = newTitle;
		
        // Update status item size (which will also update this view's bounds)
        NSRect titleBounds = [self titleBoundingRect];
        int newWidth = titleBounds.size.width + (2 * StatusItemViewPaddingWidth);
        [statusItem setLength:newWidth];
		
        [self setNeedsDisplay:YES];
    }
}

- (void)setTitle:(NSString *)newTitle withColor: (NSColor *)aColor {
    
}

- (NSString *)title {
    return title;
}

- (void)drawRect:(NSRect)rect {
    // Draw status bar background, highlighted if menu is showing
    [statusItem drawStatusBarBackgroundInRect:[self bounds]
                                withHighlight:isMenuVisible];
	
    // Draw title string
    NSPoint origin = NSMakePoint(StatusItemViewPaddingWidth,
                                 StatusItemViewPaddingHeight);
    [title drawAtPoint:origin
        withAttributes:[self titleAttributes]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(draggingEntered:)]) {
        isDragActive = YES;
        [self setNeedsDisplay: YES];
        return [delegate draggingEntered: sender];
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(draggingUpdated:)]) {
        return [delegate draggingUpdated: sender];
    }
    return NSDragOperationNone;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(draggingExited:)]) {
        isDragActive = NO;
        [self setNeedsDisplay: YES];
        [delegate draggingExited: sender];
    }
}
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(prepareForDragOperation:)]) {
        return [delegate prepareForDragOperation: sender];
    }
    return NO;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(performDragOperation:)]) {
        return [delegate performDragOperation: sender];
    }
    return NO;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender {
    if ([delegate respondsToSelector:@selector(concludeDragOperation:)]) {
        [delegate concludeDragOperation: sender];
    }
    isDragActive = NO;
    [self setNeedsDisplay: YES];
}

@end
