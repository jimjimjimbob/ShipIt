#import <Cocoa/Cocoa.h>
#import "SIStatusItemView.h"
#import "SIPluginController.h"

@interface ShipItController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    SIStatusItemView *statusItemView;
    NSMutableArray *packageQueue;
    SIPluginController *serviceManager;
    
}

- (IBAction)packageAndShare: (id) sender;
- (void)createAndEnqueuePackageWithFinderSelection;

@end

@interface ShipItController (Private)
- (void)registerGlobalHotKey;
@end
