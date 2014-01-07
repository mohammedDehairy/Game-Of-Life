//
//  MatrixView.h
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSize.h"
#import "CellView.h"
#import <QuartzCore/QuartzCore.h>
#import "Graph.h"
#import <GameKit/GameKit.h>
#import "MSize.h"
@protocol MatrixViewDelegate;
@interface MatrixView : UIView
{

}
@property(nonatomic,weak)id<MatrixViewDelegate> delegate;
@property(nonatomic,readonly,retain)MSize *size;

-(id)initWithFrame:(CGRect)frame withSize:(MSize*)size;
-(void)setStatusOfCellWithGraphCell:(GraphCell*)graphCell;
-(void)resetMatrix;
-(UIImage*)takeSnapshot;
@end
@protocol MatrixViewDelegate <NSObject>

-(void)cellTouchedAtIndex:(int)index;

@end