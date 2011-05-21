#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "SICompressor.h"
#import "SIQueue.h"

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    SICompressor *compressor;
    NSMutableArray *packageQueue;
}

- (IBAction)packageAndShare: (id) sender;
- (void)createAndEnqueuePackageWithFinderSelection;
@end

@interface ShipItController (Private)
- (void)registerGlobalHotKey;
@end
