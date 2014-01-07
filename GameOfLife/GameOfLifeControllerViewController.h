//
//  GameOfLifeControllerViewController.h
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatrixView.h"
#import "Graph.h"
#import "ActionOnGraph.h"
#import "AnimatedGifCreator.h"
@interface GameOfLifeControllerViewController : UIViewController<MatrixViewDelegate>
{
    Graph *graph;
    MatrixView *matrixView;
    
    NSTimer *clock;
    
    BOOL playing;
    
    UIButton *resetBtn ;
    AnimatedGifCreator *animatedGifCreator;
}
@end
