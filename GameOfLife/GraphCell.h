//
//  GraphCell.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 6/21/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PositionEntity.h"
typedef enum {
    GraphCellStatusDead,
    GraphCellStatusAlive
} GraphCellStatus;
@interface GraphCell : NSObject<NSCoding,NSCopying>

@property(nonatomic,assign)GraphCellStatus status;
@property(nonatomic,retain)PositionEntity *position;
-(id)initWithStatus:(GraphCellStatus)color withPosition:(PositionEntity*)position;
-(void)toggelStatus;

@end
