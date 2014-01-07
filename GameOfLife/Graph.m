//
//  Graph.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 6/21/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "Graph.h"
@interface Graph()
@property(nonatomic,retain)NSMutableArray *graphArray;
@end
@implementation Graph
-(id)initWithSize:(MSize *)size
{
    self = [super init];
    if(self)
    {
        _size = size;
        self.graphArray = [NSMutableArray array];
        int TotalNoOfCells = self.size.width*self.size.height;
        for(int i = 0;i< TotalNoOfCells;i++)
        {
            GraphCellStatus stat = GraphCellStatusDead;
            PositionEntity *position = [[PositionEntity alloc] init];
            position.x = i % self.size.width;
            position.y = i /self.size.height;
            
           /* if(i == 54|| i == 55 || i == 56 || i == 29 || i == 1)
            {
                stat = GraphCellStatusAlive;
            }*/
            
            GraphCell *cell = [[GraphCell alloc] initWithStatus:stat withPosition:position] ;
            
            
            [self.graphArray addObject:cell];
        }
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.graphArray = [aDecoder decodeObjectForKey:@"graphArray"];
        self.size = [aDecoder decodeObjectForKey:@"size"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.graphArray forKey:@"graphArray"];
    [aCoder encodeObject:self.size forKey:@"size"];
}

-(GraphCell*)getGraphCellWithIndex:(int)index
{
    GraphCell *cell = nil;
    if(index < self.graphArray.count)
        cell = [self.graphArray objectAtIndex:index];
    return cell;
}

-(int)indexWithX:(int)x AndY:(int)y
{
    return y*self.size.width+x;
}
-(GraphCell*)getGraphCellWithX:(int)x withY:(int)y
{
    int index = y*self.size.width+x;
    
    GraphCell *cell = nil;
    if(index<self.graphArray.count)
        cell = [self.graphArray objectAtIndex:index];
    
    return cell;
}

-(int)getIndexOfGraphCell:(GraphCell*)GCell
{
    return [self.graphArray indexOfObject:GCell];
}
-(void)ResetGraph
{
    for(GraphCell *cell in _graphArray)
    {
        cell.status = GraphCellStatusDead;
    }
}
-(id)copyWithZone:(NSZone *)zone
{
    Graph *copy = [[Graph alloc] init];
    if(copy)
    {
        NSMutableArray *CopyArray = [NSMutableArray array];
        for(GraphCell *cell in _graphArray)
        {
            GraphCell *copyGCell = [cell copyWithZone:zone];
            [CopyArray addObject:copyGCell];
        }
        [copy setGraphArray:CopyArray];
        [copy setSize:[self.size copyWithZone:zone]];
    }
    return copy;
}
@end
