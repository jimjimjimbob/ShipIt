//
//  CMPackage.h
//  ShipIt!
//
//  Created by doomspork on 5/15/11.
//  Copyright 2011 Codez4Mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMPackage : NSObject {
    @private
    NSMutableArray *packageFiles;
}

-(CMPackage *)init;
-(void)addURLToPackage:(NSURL *)aURL;
-(NSArray *)packageContentsAsArray;
-(NSUInteger)size;
@end
