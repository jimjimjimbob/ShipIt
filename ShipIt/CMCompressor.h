//
//  Compressor.h
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CMCompressor : NSObject {
NSURL *destination;
}

- (CMCompressor *)initWithDestinationURL: (NSURL *)aDestination;
- (void)setDestination: (NSURL *)destinationURL;
- (NSURL *)destination;
- (void)addFileAtURL: (NSURL *)atURL;
- (BOOL) compress;
@end
