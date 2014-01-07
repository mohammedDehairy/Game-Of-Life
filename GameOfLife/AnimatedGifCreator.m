//
//  AnimatedGifCreator.m
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/4/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "AnimatedGifCreator.h"

@implementation AnimatedGifCreator
-(id)init
{
    self = [super init];
    if(self)
    {
        images = [NSMutableArray array];
    }
    return self;
}
-(void)addsnapShot:(UIImage *)snapShot
{
    [images addObject:snapShot];
}
-(NSString*)pathOfGifAnimated
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"GameOfLifeAnimated.gif"];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:path],
                                                                        kUTTypeGIF,
                                                                        2,
                                                                        NULL);
    
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:2] forKey:(NSString *)kCGImagePropertyGIFDelayTime]
                                                                forKey:(NSString *)kCGImagePropertyGIFDictionary];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                              forKey:(NSString *)kCGImagePropertyGIFDictionary];
    for(UIImage *snapshot in images)
    {
        CGImageDestinationAddImage(destination, snapshot.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    
    return path;
}
@end
