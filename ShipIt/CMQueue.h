//
//  CMQueue.h
//  ShipIt
//
//  Created by doomspork on 5/15/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (CMQueue)
- (id)dequeue;
- (void) enqueue:(id)obj;
@end
