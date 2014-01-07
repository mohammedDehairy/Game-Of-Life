//
//  MatrixView.m
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import "MatrixView.h"

@implementation MatrixView

-(id)initWithFrame:(CGRect)frame withSize:(MSize*)size
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _size = size;
        [self ReloadWithSize:_size];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    }
    return self;
}


//**********************MATRIX RELOAD WITH CELLS ***************************************************

-(void)ReloadWithSize:(MSize*)size
{
    
    NSArray *subviews = [self subviews];
    for(UIView *subview in subviews)
    {
        if(subview.tag>=1000)
            [subview removeFromSuperview];
    }
    

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.center = CGPointMake(160, 210);
    }else
    {
        self.center = CGPointMake(400, 450);
    }
    
    
    
    [self LoadWithCells];
    
}

-(void)LoadWithCells
{
    
    int TotalCellsCount = self.size.width*self.size.height;

    
    
    
    CGFloat AnimationDelay =0.0;
    int CurrentX = CELL_SIZE;
    CurrentX *= -1;
    CurrentX += 5;
    int CurrentY = 5;
    for(int i =0 ;i<TotalCellsCount;i++)
    {
        if(i%self.size.width == 0)
        {
            
            //if reached full width
            //Reset x and increase y
            
            
            CurrentX = 5;
            CurrentY+=CELL_SIZE+2;
            
            
        }else
        {
            //if did not reach full width
            //increase x
            
            CurrentX+=CELL_SIZE+2;
        }
        
        
        
        
        CellView *cell = [[CellView alloc] initWithFrame:CGRectMake(CurrentX, CurrentY, CELL_SIZE, CELL_SIZE)];
        cell.tag = i+1000;
        
        [cell addTarget:self action:@selector(cellTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        
        GraphCell *emptyGraphCell = [[GraphCell alloc] init];
        emptyGraphCell.status = GraphCellStatusDead;
        
        
        [cell SetStatusWithGraphCell:emptyGraphCell];
        
        [self addSubview:cell];
        
        
        
        AnimationDelay += 0.1;

        
        
        
    }

    
}
-(void)resetMatrix
{
    for (int i = 0; i < (_size.width*_size.height); i++) {
        CellView *cell = ((CellView*)[self viewWithTag:i+1000]);
        cell.backgroundColor = [UIColor whiteColor];
    }
}
-(void)cellTouched:(CellView*)cellView
{
    if([_delegate respondsToSelector:@selector(cellTouchedAtIndex:)])
    {
        [_delegate cellTouchedAtIndex:cellView.tag-1000];
    }
}
-(void)setStatusOfCellWithGraphCell:(GraphCell *)graphCell
{
    int index = ( graphCell.position.y * _size.height ) + graphCell.position.x;
    
    CellView *cellView = ((CellView*)[self viewWithTag:index+1000]);
    
    [cellView SetStatusWithGraphCell:graphCell];
}
-(UIImage*)takeSnapshot
{
    CGRect rectToSnapShot = self.frame;
    UIGraphicsBeginImageContextWithOptions(rectToSnapShot.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return capturedImage;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
