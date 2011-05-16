#import "AppController.h"
#import "Finder.h"
#import "CMPackage.h"
#import "CMCompressor.h"
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

//static BOOL processing;

- (AppController *)init {
    self = [super init];
    if(self) {
        compressor = [[CMCompressor alloc] init];
        //processing = NO;
    }
    return self;
}
/*
+ (void)setProcessing: (BOOL) aBool {
    processing = aBool;
}

+ (BOOL)processing {
    return processing;
}

+ (void)processQueue:(id)param {
    while ([packageQueue count] > 0) {
        NSLog(@"Threaded processing of queue.");
        NSLock *lock;
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        [lock lock];
        CMPackage *package = (CMPackage *)[packageQueue dequeue];
        BOOL success = [compressor compressPackage: package];
        if (success == NO) {
            //Better error handling is needed
            NSLog(@"Error occurred during compression.");
        }
        [lock unlock];
        [pool release];
    }
    [AppController setProcessing: NO];
    [NSThread exit];
}
*/
- (void)awakeFromNib {
	[self registerGlobalHotKey];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];

	statusItemView = [[CMDroppableView alloc] init];
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
	
    CMPackage *package = [[CMPackage alloc] init];
	NSArray *items = [selection arrayByApplyingSelector:@selector(URL)];
	for (NSString *item in items) {
		NSURL *url = [NSURL URLWithString: item];
        [package addURLToPackage: url];
	}
    [packageQueue enqueue: package];
    [self packageAndShare: nil];
    /*
    if (![AppController processing]) {
        NSLog(@"No process running; detach new thread.");
        [NSThread detachNewThreadSelector:@selector(processQueue:) toTarget:[AppController class] withObject: nil];
    }
    */
} 

- (IBAction)packageAndShare: (id)sender {
    while ([packageQueue count] > 0) {
        CMPackage *package = [packageQueue dequeue];
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
        CMPackage *package = [[CMPackage alloc] init];
        NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
        for (id item in fileArray) {
            NSString *path = (NSString *) item;
            NSLog(@"Adding URL to package: %@", path);
            [package addURLToPackage: [NSURL URLWithString: path]];
        }
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