//
//  CMDeliveryProtocol.h
//  ShipIt
//
//  Created by Sean Callan on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SIDeliveryServiceProtocol <NSObject>
- (id)initializeService;
- (void)terminateService;
+ (NSString *)name;
- (BOOL)deliverPackage: (SIPackage *)aPackage;
@end
