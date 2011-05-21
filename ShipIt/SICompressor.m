//
//  Compressor.m
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "SICompressor.h"

@implementation SICompressor

- (SICompressor *)init {
    self = [super init];
    return self;
}

- (void)dealloc {
	[destination release];
	[super dealloc];
}

- (void)setDestination:(NSURL *)destinationURL {
	[destinationURL retain];
	[destination release];
	destination = destinationURL;
}

- (NSURL *)destination {
	return destination;
}

- (BOOL)compressPackage: (SIPackage *)aPackage {
	return TRUE;
}
@end
