//
//  CellView.m
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    //frame = CGRectMake(frame.origin.x, frame.origin.y, CELL_SIZE-0.5, CELL_SIZE-0.5);
    self = [super initWithFrame:frame];
    if (self) {
        
        
        contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:contentView];
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        
        
       
        
    }
    return self;
}



-(void)SetStatusWithGraphCell:(GraphCell*)GCell
{
    if(GCell.status == GraphCellStatusAlive)
    {
        self.backgroundColor = [UIColor blackColor];
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect
{
 
}*/


@end
