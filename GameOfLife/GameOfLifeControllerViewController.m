//
//  GameOfLifeControllerViewController.m
//  GameOfLife
//
//  Created by Mohammed Eldehairy on 1/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "GameOfLifeControllerViewController.h"

@interface GameOfLifeControllerViewController ()

@end

@implementation GameOfLifeControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:(67.0f/255.0f) green:(180.0f/255.0f) blue:(230.0f/255.0f) alpha:1.0];
    playing = NO;
    
    MSize *size = [[MSize alloc] init];
    size.width = 23;
    size.height = 23;
    
    int cellSize = CELL_SIZE;
    matrixView = [[MatrixView alloc]  initWithFrame:CGRectMake(0, 0, ((cellSize+4)*size.width), ((cellSize+4)*size.height)) withSize:size];
    matrixView.delegate = self;
    [self.view addSubview:matrixView];
    
    
    graph = [[Graph alloc] initWithSize:size];
    
    
    
             
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 900, 100, 44)];
    startBtn.backgroundColor = [UIColor greenColor];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 900, 100, 44)];
    resetBtn.backgroundColor = [UIColor yellowColor];
    [resetBtn setTitle:@"reset" forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    
    animatedGifCreator = [[AnimatedGifCreator alloc] init];
}
-(void)reset:(UIButton*)resetBtn
{
    if(!playing)
    {
        [graph ResetGraph];
        [matrixView resetMatrix];
        [self getAnimatedGif];
    }
}
-(void)start:(UIButton*)startBtn
{
    playing = !playing;
    
    if(!playing)
    {
        [clock invalidate];
        [startBtn setTitle:@"Start" forState:UIControlStateNormal];
        [startBtn setBackgroundColor:[UIColor greenColor]];
        [resetBtn setEnabled:YES];

    }else
    {
        clock = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [startBtn setTitle:@"Stop" forState:UIControlStateNormal];
        [startBtn setBackgroundColor:[UIColor redColor]];
        
        [resetBtn setEnabled:NO];
    }
    
}
-(void)cellTouchedAtIndex:(int)index
{
    if(!playing)
    {
        GraphCell *GCell = [graph getGraphCellWithIndex:index];
        [GCell toggelStatus];
        
        [matrixView setStatusOfCellWithGraphCell:GCell];
    }
    
}
-(void)tick
{
    
    NSMutableArray *actions = [NSMutableArray array];
    
    for(int index = 0;index <= graph.size.height*graph.size.width;index++)
    {
        GraphCell *GCell = [graph getGraphCellWithIndex:index];
        
        if(GCell.status == GraphCellStatusAlive)
        {
            ActionOnGraph *action = [self actionForLiveGraphCell:GCell];
            
            if(action)
                [actions addObject:action];
            
        }else
        {
            ActionOnGraph *action = [self actionForDeadCell:GCell];
            
            if(action)
                [actions addObject:action];
        }
    }
    if(actions.count>0)
    {
        [self executeActions:actions];
    }else
    {
        [self getAnimatedGif];
    }
    
}
-(void)getAnimatedGif
{
    //NSString *pathOfGif = [animatedGifCreator pathOfGifAnimated];
    //NSLog(@"%@",pathOfGif);
}
-(ActionOnGraph*)actionForLiveGraphCell:(GraphCell*)GCell
{
    ActionOnGraph *action ;
    
    NSArray *neighbors = [self getNeighborsForCell:GCell];
    
    int numberOfLiveOnes = [self getNumberOfLiveCellsInArray:neighbors];
    
    if(numberOfLiveOnes > 3 || numberOfLiveOnes < 2)
    {
        PositionEntity *position = [[PositionEntity alloc] init];
        
        position.x = GCell.position.x;
        position.y = GCell.position.y;
        
        action = [[ActionOnGraph alloc] initWithStatus:GraphCellStatusDead withPosition:position];
        
    }else
    {
        
        action = nil;
    }
    
    
    
    return action;
}
-(ActionOnGraph*)actionForDeadCell:(GraphCell*)GCell
{
    ActionOnGraph *action;
    
    NSArray *neighbors = [self getNeighborsForCell:GCell];
    
    int numberOfLiveOnes = [self getNumberOfLiveCellsInArray:neighbors];
    
   if(numberOfLiveOnes == 3)
   {
       PositionEntity *position = [[PositionEntity alloc] init];
       
       position.x = GCell.position.x;
       position.y = GCell.position.y;
       
       action = [[ActionOnGraph alloc] initWithStatus:GraphCellStatusAlive withPosition:position];
       
   }else
   {
       
       
       action = nil;
   }
    
    return action;
}
-(int)getNumberOfLiveCellsInArray:(NSArray*)cells
{
    int numberOfLiveOnes = 0;
    
    for(GraphCell *neighbor in cells)
    {
        if(neighbor.status == GraphCellStatusAlive)
        {
            numberOfLiveOnes++;
        }
    }
    return numberOfLiveOnes;
}
-(NSArray*)getNeighborsForCell:(GraphCell*)GCell
{
    NSMutableArray *neighbors = [NSMutableArray array];
    
    if(GCell.position.x % graph.size.width != 0 && GCell.position.y != 0)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x-1 withY:GCell.position.y-1]];
    
    
    if(GCell.position.y != 0)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x withY:GCell.position.y-1]];
    
    
    if((GCell.position.x+1) % graph.size.width != 0 && GCell.position.y != 0)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x+1 withY:GCell.position.y-1]];
    
    if(GCell.position.x % graph.size.width != 0)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x-1 withY:GCell.position.y]];
    
    if((GCell.position.x+1) % graph.size.width != 0)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x+1 withY:GCell.position.y]];
    
    if(GCell.position.x % graph.size.width != 0 && GCell.position.y != graph.size.height-1)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x-1 withY:GCell.position.y+1]];
    
    if(GCell.position.y != graph.size.height-1)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x withY:GCell.position.y+1]];
    
    if((GCell.position.x+1) % graph.size.width != 0 && GCell.position.y != graph.size.height-1)
        [neighbors addObject:[graph getGraphCellWithX:GCell.position.x+1 withY:GCell.position.y+1]];
    
    return neighbors;
}

-(void)executeActions:(NSArray*)actions
{
    for(ActionOnGraph *action in actions)
    {
        GraphCell *GCell = [graph getGraphCellWithX:action.positionOfCellToAltered.x withY:action.positionOfCellToAltered.y];
        
        [GCell setStatus:action.statusToBeDone];
        
        [matrixView setStatusOfCellWithGraphCell:GCell];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
