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
    NSString *name;
    NSMutableArray *packageFiles;
    NSData *compressed;
}

@property (retain) NSData *compressed;
@property (retain) NSString *name; //name will be used for naming the compressed result: test.dmg, test.zip

-(SIPackage *)init;
-(void)addURLToPackage:(NSURL *)aURL;
-(NSArray *)packageContentsAsArray;
-(NSUInteger)size;
@end
