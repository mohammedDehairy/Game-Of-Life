//
//  Graph.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 6/21/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSize.h"
#import "GraphCell.h"
@interface Graph : NSObject<NSCoding,NSCopying>
{
    
}
@property(nonatomic,retain)MSize *size;
-(id)initWithSize:(MSize*)size;
-(GraphCell*)getGraphCellWithX:(int)x withY:(int)y;
-(GraphCell*)getGraphCellWithIndex:(int)index;
-(int)getIndexOfGraphCell:(GraphCell*)GCell;
-(void)ResetGraph;
-(int)indexWithX:(int)x AndY:(int)y;
@end
