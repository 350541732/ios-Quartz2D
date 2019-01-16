//
//  snowView.m
//  test
//
//  Created by root1 on 2019/1/11.
//  Copyright © 2019 root1. All rights reserved.
//

#import "snowView.h"

@implementation snowView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}
static int _snowY = 0;
-(void)update
{
    _snowY += 10;
    
    if (_snowY > [UIScreen mainScreen].bounds.size.height) {
        _snowY = 0;
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"xuehua.png"];
    [image drawAtPoint:CGPointMake(20, _snowY)];
}
@end
