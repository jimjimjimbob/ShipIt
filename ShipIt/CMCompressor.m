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
    if (self) {
        packageQueue = [[NSMutableArray array] retain]; 
    }
    return self;
}

- (void)dealloc {
    [packageQueue release];
	[destination release];
	[super dealloc];
}

- (void)setDestination:(NSURL *)destinationURL {
	[destinationURL retain];
	[destination release];
	destination = destinationURL;
}

- (void)addFileAtURL:(NSURL *)atURL {
    [packageQueue enqueue: atURL];
}

- (NSURL *)destination {
	return destination;
}

- (BOOL)compress {
	return TRUE;
}
@end
