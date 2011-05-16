#import "AppController.h"
#import "Finder.h"
#import "CMPackage.h"
#import "CMCompressor.h"
#import <Carbon/Carbon.h>

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@implementation AppController (Private)

- (void)populateFilesWithFinderSelection {
	FinderApplication *finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
	SBElementArray *selection = [[finder selection] get];
	
	NSArray *items = [selection arrayByApplyingSelector:@selector(URL)];
	for (NSString * item in items) {
		NSURL *url = [NSURL URLWithString: item];
		NSLog(@"selected item url: %@", url);
	}
} 

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
        compressor = [[CMCompressor alloc] init];
    }
    return self;
}

- (void)awakeFromNib {
	[self registerGlobalHotKey];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];

	statusItemView = [[CMDroppableView alloc] init];
	[statusItemView retain];
    [statusItemView setDelegate: self];
    [statusItemView setStatusItem: statusItem];
	[statusItemView setMenu: statusMenu];
	[statusItemView setTitle: @"ShipIt!!"];
	
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

- (IBAction)packageAndShare: (id)sender {
	NSLog(@"ShipIt!! Package and Share.");
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
    return NO;
}

@end

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) {
	[(AppController *) userData populateFilesWithFinderSelection];
	return noErr;
}