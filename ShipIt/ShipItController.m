#import "ShipItController.h"
#import "Finder.h"
#import "SIPackage.h"
#import "SIDeliveryController.h"
#import <Carbon/Carbon.h>

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation ShipItController (Private)

- (void)registerGlobalHotKey {
	EventHotKeyRef myHotKeyRef;     
	EventHotKeyID myHotKeyID;     
	EventTypeSpec eventType;
	eventType.eventClass = kEventClassKeyboard;     
	eventType.eventKind = kEventHotKeyPressed;
	InstallApplicationEventHandler(&myHotKeyHandler, 1, &eventType, self, NULL);
	myHotKeyID.signature = 'htk1';
	myHotKeyID.id = 1;
	RegisterEventHotKey(1, cmdKey + optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef);
}
@end

@implementation ShipItController

- (ShipItController *)init {
    self = [super init];
    if (self) {
        serviceManager = [SIPluginController sharedInstance];
    }
    return self;
}

- (void)awakeFromNib {
	[self registerGlobalHotKey];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];

	statusItemView = [[SIStatusItemView alloc] init];
	[statusItemView retain];
    [statusItemView setDelegate: self];
    [statusItemView setStatusItem: statusItem];
	[statusItemView setMenu: statusMenu];
	[statusItemView setTitle: @"ShipIt!"];
	
	[statusItem setView: statusItemView];	
	[statusItem	setHighlightMode: YES];
	[statusItem setEnabled: YES];
}

- (void)dealloc {
    [statusItemView release];
	[statusItem release];
	[super dealloc];
}

- (void)createAndEnqueuePackageWithFinderSelection {
	FinderApplication *finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
	SBElementArray *selection = [[finder selection] get];
	
    SIPackage *package = [[SIPackage alloc] init];
	NSArray *items = [selection arrayByApplyingSelector:@selector(URL)];
	for (NSString *item in items) {
		NSURL *url = [NSURL URLWithString: item];
        [package addURLToPackage: url];
	}
    [packageQueue addObject: package];
    [self packageAndShare: self];
    [package release];
} 

- (IBAction)packageAndShare: (id)sender {
    NSLog(@"Preparing to package and share.");
    for (id package in packageQueue) {
        if ([package isKindOfClass: [SIPackage class]]) {
            //compress
        }
    }
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSLog(@"Drag Entered");
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    NSLog(@"Drag Exited");
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *paste = [sender draggingPasteboard];
    NSArray *types = [NSArray arrayWithObjects:NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSLog(@"Performing drag operation.");
    if([desiredType isEqualToString:NSFilenamesPboardType]) {
        NSLog(@"Acceptable type.");
        SIPackage *package = [[SIPackage alloc] init];
        NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
        for (id item in fileArray) {
            NSString *path = (NSString *) item;
            NSLog(@"Adding URL to package: %@", path);
            [package addURLToPackage: [NSURL URLWithString: path]];
        }
        [packageQueue addObject: package];
        [package release];
    }
    [self packageAndShare: nil];
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    
}

@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
	[(ShipItController *)userData createAndEnqueuePackageWithFinderSelection];
	return noErr;
}