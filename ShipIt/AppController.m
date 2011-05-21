#import "AppController.h"
#import "Finder.h"
#import "SIPackage.h"
#import "SIDeliveryController.h"
#import <Carbon/Carbon.h>

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation AppController (Private)

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

@implementation AppController

- (AppController *)init {
    self = [super init];
    if(self) {
        compressor = [[SIDeliveryController alloc] init];
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
    [compressor release];
	[statusItem release];
    [statusItemView release];
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
    [self packageAndShare: nil];
} 

- (IBAction)packageAndShare: (id)sender {
    NSLog(@"Preparing to package and share.");
    while ([packageQueue count] > 0) {
        SIPackage *package = [packageQueue dequeue];
        NSLog(@"Package retrieved.  Compressing.");
        if ([compressor compressPackage: package]) {
            NSLog(@"Package successfully compressed.");
        } else {
            NSLog(@"Package failed to be compressed.");
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
    }
    [self packageAndShare: nil];
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    
}

@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
	[(AppController *)userData createAndEnqueuePackageWithFinderSelection];
	return noErr;
}