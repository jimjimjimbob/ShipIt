//
//  Compressor.m
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "CMCompressor.h"

@implementation CMCompressor

- (CMCompressor *)init {
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

- (BOOL)compressPackage: (CMPackage *)aPackage {
	return TRUE;
}
@end
