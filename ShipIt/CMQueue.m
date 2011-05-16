//
//  CMQueue.m
//  ShipIt
//
//  Created by Sean Callan on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CMQueue.h"


@implementation NSMutableArray (CMQueue)
- (id) dequeue {
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
        [[headObject retain] autorelease];
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

- (void) enqueue:(id)anObject {
    [self addObject:anObject];
}
@end
