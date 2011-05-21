//
//  Compressor.h
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SIPackage.h"

@interface SICompressor : NSObject {
    @private
    NSURL *destination;
}

- (SICompressor *)init;
- (void)setDestination: (NSURL *)destinationURL;
- (NSURL *)destination;
- (BOOL)compressPackage: (SIPackage *)aPackage;
@end
