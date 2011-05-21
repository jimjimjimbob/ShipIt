#import <Cocoa/Cocoa.h>
#import "SIDroppableView.h"
#import "SICompressor.h"
#import "SIQueue.h"

@interface AppController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIDroppableView *statusItemView;
    SICompressor *compressor;
    NSMutableArray *packageQueue;
}

- (IBAction) packageAndShare: (id) sender;
- (void)createAndEnqueuePackageWithFinderSelection;
@end

@interface AppController (Private)
- (void)registerGlobalHotKey;
@end
