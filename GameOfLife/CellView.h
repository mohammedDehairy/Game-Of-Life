//
//  CellView.h
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GraphCell.h"

#define CELL_SIZE 30


@interface CellView : UIButton<UIGestureRecognizerDelegate>
{
    UIImageView *contentView;
}


// Methods to set the status of the cell

-(void)SetStatusWithGraphCell:(GraphCell*)GCell;

@end
