//
//  SIPackage.m
//  ShipIt!
//
//  Created by doomspork on 5/15/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import "SIPackage.h"


@implementation SIPackage

@synthesize compressed;
@synthesize name;

-(SIPackage *)init {
    self = [super init];
    if(self) {
        packageFiles = [[NSMutableArray array] retain];
    }
    return self;
}

-(void)dealloc {
    [packageFiles release];
    [super dealloc];
}

-(void)addURLToPackage:(NSURL *)aURL {
    [packageFiles addObject: aURL];
}

-(NSArray *)packageContentsAsArray {
    return [NSArray arrayWithArray: packageFiles];
}

-(NSUInteger)size {
    return [packageFiles count];
}

@end
