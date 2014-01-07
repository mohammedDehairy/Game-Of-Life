//
//  GraphCell.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 6/21/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "GraphCell.h"

@implementation GraphCell
-(id)initWithStatus:(GraphCellStatus)status withPosition:(PositionEntity *)position
{
    self = [super init];
    if(self)
    {
        self.status = status;
        self.position = position;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.status = ((NSNumber*)[aDecoder decodeObjectForKey:@"status"]).intValue;
        self.position = [aDecoder decodeObjectForKey:@"position"];

    }
    return self;
}
-(void)toggelStatus
{
    if(self.status == GraphCellStatusAlive)
    {
        self.status = GraphCellStatusDead;
    }else
    {
        self.status = GraphCellStatusAlive;
    }
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInt:self.status] forKey:@"status"];
    [aCoder encodeObject:self.position forKey:@"position"];
}

-(id)copyWithZone:(NSZone *)zone
{
    GraphCell *copy = [[GraphCell alloc] init];
    if(copy)
    {
        [copy setStatus:self.status];
        [copy setPosition:self.position];
    }
    return copy;
}
@end
