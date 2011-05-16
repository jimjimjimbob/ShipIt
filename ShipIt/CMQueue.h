//
//  CMQueue.h
//  ShipIt
//
//  Created by Sean Callan on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (CMQueue)
- (id)dequeue;
- (void) enqueue:(id)obj;
@end
