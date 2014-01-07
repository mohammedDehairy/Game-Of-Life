//
//  ActionOnGraph.m
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "ActionOnGraph.h"

@implementation ActionOnGraph
-(id)initWithStatus:(GraphCellStatus)status withPosition:(PositionEntity *)position
{
    self = [super init];
    if(self)
    {
        _statusToBeDone = status;
        _positionOfCellToAltered = position;
    }
    return self;
}
@end
