//
//  Compressor.h
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CMQueue.h"

@interface CMCompressor : NSObject {
    @private
    NSURL *destination;
    NSMutableArray *packageQueue;
}

- (CMCompressor *)init;
- (void)setDestination: (NSURL *)destinationURL;
- (NSURL *)destination;
- (void)addFileAtURL: (NSURL *)atURL;
- (BOOL) compress;
@end
