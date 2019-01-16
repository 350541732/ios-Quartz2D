//
//  clockView.m
//  test
//
//  Created by root1 on 2019/1/14.
//  Copyright © 2019 root1. All rights reserved.
//

#import "clockView.h"

/*
 解锁手势
 **/
#define kDefaultBackNumber @"01258"

@interface clockView()

@property(nonatomic,strong)NSMutableArray *selectedBtnArray;

@property(nonatomic,assign)CGPoint curP;

@end

@implementation clockView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        /*记得设置背景色，不然点击结束后之前画线不会消失*/
        self.backgroundColor = [UIColor clearColor];
        
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    for (int i = 0; i<9; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.userInteractionEnabled = NO;
        
        btn.tag = i;
        
        [btn setImage:[UIImage imageNamed:@"center.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"center-2.png"] forState:UIControlStateSelected];
        
        [self addSubview:btn];
        
    }
}

#pragma mark ----private func
///获取当前手指的点
-(CGPoint)getCurPoint:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    return curP;
}

///给定一个点,判断这个点在不在按钮身上
-(UIButton *)btnContainsPoint:(CGPoint)point
{
    for(UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}
#pragma mark touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint curP = [self getCurPoint:touches];
    
    UIButton *btn = [self btnContainsPoint:curP];
    
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        
        [self.selectedBtnArray addObject:btn];
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint curP = [self getCurPoint:touches];
    self.curP = curP;
    
    UIButton *btn = [self btnContainsPoint:curP];
    
    if (btn&&btn.selected == NO){
        btn.selected = YES;
        
        [self.selectedBtnArray addObject:btn];
    }
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableString *str = [NSMutableString string];
    
    for(UIButton *btn in self.selectedBtnArray) {
        btn.selected = NO;
        [str appendFormat:@"%ld",btn.tag];
        
    }
    
    if ([str isEqualToString:kDefaultBackNumber]) {
        NSLog(@"OK");
    }else{
        NSLog(@"NO");
    }
    
    [self.selectedBtnArray removeAllObjects];
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    if (self.selectedBtnArray.count) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        for (int i = 0; i<self.selectedBtnArray.count; i++) {
            
            UIButton *btn = self.selectedBtnArray[i];
            
            if (i == 0) {
                [path moveToPoint:btn.center];
            }
            else{
                [path addLineToPoint:btn.center];
                
            }
            
            [path setLineWidth:10];
            [[UIColor redColor]set];
            [path setLineJoinStyle:kCGLineJoinRound];
            [path stroke];
            
        }
    }
}


    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat btnWH = 74;
    
    int column = 3;
    CGFloat margin = (self.bounds.size.width - column * btnWH) / (column + 1);
    
    int curColumn = 0;
    int curRow = 0;
    
    //取出每一个子控件,设置frame.    self.subviews.count值为9
    for (int i = 0 ; i < self.subviews.count; i++) {
        // 九宫格布局。获取到的列和行本质是坐标(0,0)(0,1)(0,2)(1,0)(1,1)(1,2)(2,0)(2,1)(2,1)
        
        //当前所在的列
        curColumn = i % column;
        //当前所在的行
        curRow = i / column;
        
        x = margin + (margin + btnWH) * curColumn;
        y = margin + (margin + btnWH) * curRow;
        
        //取出每一按钮
        UIButton *btn = self.subviews[i];
        // 确定每个按钮的frame
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
    
}
    
#pragma mark ---lazy
-(NSMutableArray *)selectedBtnArray
{
    if (!_selectedBtnArray) {
        _selectedBtnArray = [NSMutableArray array];
    }
    return _selectedBtnArray;
}

@end
