//
//  SIPackage.h
//  ShipIt!
//
//  Created by doomspork on 5/15/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SIPackage : NSObject {
    @private
    NSMutableArray *packageFiles;
}

-(SIPackage *)init;
-(void)addURLToPackage:(NSURL *)aURL;
-(NSArray *)packageContentsAsArray;
-(NSUInteger)size;
@end
