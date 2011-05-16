//
//  Compressor.m
//  ShipIt!
//
//  Created by doomspork on 5/13/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "CMCompressor.h"

@implementation CMCompressor

- (CMCompressor *)initWithDestinationURL: (NSURL *)destinationURL {
	self = [super init];
	if (self) {
		[self setDestination: destinationURL];
		return self;
	}
	return nil;
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

- (void)addFileAtURL:(NSURL *)atURL {
	//[compression addFileAtURL: atURL];
}

- (NSURL *)destination {
	return destination;
}

- (BOOL)compress {
	return TRUE;
}
@end
