//
//  Compressor.h
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CMPackage.h"

@interface CMCompressor : NSObject {
    @private
    NSURL *destination;
}

- (CMCompressor *)init;
- (void)setDestination: (NSURL *)destinationURL;
- (NSURL *)destination;
- (BOOL)compressPackage: (CMPackage *)aPackage;
@end
