//
//  DrawView.m
//  画板
//
//  Created by root1 on 2019/1/16.
//  Copyright © 2019 root1. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"

@interface DrawView()

@property (nonatomic,strong)UIBezierPath *path;

@property (nonatomic,strong)NSMutableArray *pathArray;

@property (nonatomic,assign)CGFloat width;

@property (nonatomic,strong)UIColor *color;

@end

@implementation DrawView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        self.color = [UIColor blackColor];
        
        self.width = 1;
        
    }
    return self;
    
}
/////pan
-(void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint curP = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        MyBezierPath *path = [[MyBezierPath alloc]init];
        
        [path setLineWidth:self.width];
        [path setLineJoinStyle:kCGLineJoinRound];
        [path setLineCapStyle:kCGLineCapRound];
        
        path.color = self.color;
        self.path = path;
        
        [self.pathArray addObject:path];
        
        [path moveToPoint:curP];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        
        [self.path addLineToPoint:curP];
        
        [self setNeedsDisplay];
    }
}

-(void)drawRect:(CGRect)rect
{
    for(MyBezierPath *path in self.pathArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            
            [image drawInRect:rect];
        }
        else{
            [path.color set];
            [path stroke];
            
        }
        
    }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    [self.pathArray addObject:image];
    
    [self setNeedsDisplay];
    
}

-(void)clear
{
    [self.pathArray removeAllObjects];
    
    [self setNeedsDisplay];
    
}

-(void)undo
{
    [self.pathArray removeLastObject];
    
    [self setNeedsDisplay];
    
}

-(void)erase
{
    [self setColor:[UIColor whiteColor]];
    
}

-(void)setLineWidth:(CGFloat)width
{
    self.width = width;
}

- (void)setLineColor:(UIColor *)color
{
    self.color = color;
}

-(NSMutableArray *)pathArray
{
    if (!_pathArray) {
       
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}
@end
