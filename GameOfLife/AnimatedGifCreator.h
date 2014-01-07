//
//  AnimatedGifCreator.h
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/4/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface AnimatedGifCreator : NSObject
{
    NSMutableArray *images;
}
-(void)addsnapShot:(UIImage*)snapShot;
-(NSString*)pathOfGifAnimated;
@end
