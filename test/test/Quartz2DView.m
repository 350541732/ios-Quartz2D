//
//  Quartz2DView.m
//  test
//
//  Created by root1 on 2019/1/10.
//  Copyright © 2019 root1. All rights reserved.
//

#import "Quartz2DView.h"

@implementation Quartz2DView

-(void)drawRect:(CGRect)rect
{
    /*
    ///描边或者填充颜色
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    CGContextAddPath(ctx, path.CGPath);
    
    [[UIColor redColor] set];
    
    CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
    */
    
    /*
    ///画扇形或者填充
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = rect.size.width/2 ;
    CGFloat startA = 0;
    CGFloat endA = -M_PI_2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
    [path addLineToPoint:center];
    [path closePath];
    [[UIColor redColor] set];
//    [path fill];
    [path stroke];
     */
    
    /*
    ///画圆形或描边
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:rect.size.width/2];
    CGContextAddPath(ctx, path.CGPath);
    [[UIColor redColor] set];
    
//    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
     */
    
    /*
    ///圆角矩形描边或者填充
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(30, 30, 100, 100) cornerRadius:20];
    CGContextAddPath(ctx, path.CGPath);
    [[UIColor redColor] set];
//    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
     */
    
    /*
    ///画直线
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 150)];
    [path addLineToPoint:CGPointMake(250, 50)];
    
//    [path moveToPoint:CGPointMake(50, 250)];
    [path addLineToPoint:CGPointMake(250, 100)];
    
    CGContextSetLineWidth(ctx, 15);
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    
    [[UIColor redColor] set];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
   */
    /*
    ///画贝塞尔曲线
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(10, 150)];
    [path addQuadCurveToPoint:CGPointMake(200, 150) controlPoint:CGPointMake(150, 10)];
    [[UIColor redColor]set];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    */
    
    /*
    ///画饼状图
    NSArray *dataArray = @[@25,@25,@50];
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = rect.size.width/2 -10;
    
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    for(NSNumber *num in dataArray) {
        startA = endA;
        angle = num.intValue / 100.0 * M_PI *2;
        endA = startA + angle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [[self randomColor]set];
        [path addLineToPoint:center];
//        [path stroke];
        [path fill];
    }
    */
    
    /*
    ///画文字
    NSString *str = @"LeeSin啥都不会QAQ英雄联盟活动不喝酒";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    //同时设置了空心的两个属性，并且NSStrokeWidthAttributeName属性设置为整数，文字前景色(NSForegroundColorAttributeName)就无效果了
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSStrokeColorAttributeName] = [UIColor blueColor];
    dict[NSStrokeWidthAttributeName] = @3;
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowOffset = CGSizeMake(-2, -2);
    shadow.shadowBlurRadius = 3;
    
    dict[NSShadowAttributeName] = shadow;
    
    //drawAtPoint 不会换行
//    [str drawAtPoint:CGPointZero withAttributes:dict];
    //drawInPoint 会自动换行
    [str drawInRect:self.bounds withAttributes:dict];
    */
    
    ///矩阵之缩放、移动、旋转UIView
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 50, 200, 100)];
    //
    CGContextScaleCTM(ctx, 0.5, 0.5);
    CGContextTranslateCTM(ctx, 200, 100);
    CGContextRotateCTM(ctx, M_PI_4);
    [[UIColor redColor]set];
    
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
}
-(UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}
@end
