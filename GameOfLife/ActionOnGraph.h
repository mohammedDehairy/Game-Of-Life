//
//  ActionOnGraph.h
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphCell.h"
@interface ActionOnGraph : NSObject
@property(nonatomic,assign,readonly)GraphCellStatus statusToBeDone;
@property(nonatomic,retain,readonly)PositionEntity *positionOfCellToAltered;
-(id)initWithStatus:(GraphCellStatus)status withPosition:(PositionEntity *)position;
@end
