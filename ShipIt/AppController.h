#import <Cocoa/Cocoa.h>
#import "CMDroppableView.h"
#import "CMCompressor.h"
#import "CMQueue.h"

@interface AppController : NSObject {
    @private
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    CMDroppableView *statusItemView;
    CMCompressor *compressor;
    NSMutableArray *packageQueue;
    //BOOL processing;

}

- (IBAction) packageAndShare: (id) sender;
- (void)createAndEnqueuePackageWithFinderSelection;
//+ (void)setProcessing: (BOOL) aBool;
//+ (BOOL)processing;
@end

@interface AppController (Private)
- (void)registerGlobalHotKey;
@end
