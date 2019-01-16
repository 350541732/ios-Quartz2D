//
//  ViewController.m
//  test
//
//  Created by root1 on 2019/1/10.
//  Copyright © 2019 root1. All rights reserved.
//

#import "ViewController.h"

#import "Quartz2DView.h"

#import "CustomView.h"

#import "snowView.h"

#import "clockView.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *coverView;

@property (nonatomic,strong)CustomView *customView;

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)UIImageView *iconImageV;

@property(nonatomic,assign)CGPoint startP;

@property(nonatomic,strong)clockView *clockV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*
    Quartz2DView *view = [[Quartz2DView alloc]init];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(20, 50, 300, 300);
    
    [self.view addSubview:view];
 */
    
//     = [[CustomView alloc]initWithFrame:self.view.bounds];
    /*
    _customView = [[CustomView alloc]initWithFrame:self.view.bounds];
    _customView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_customView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_customView addGestureRecognizer:tap];
    */
    
    /*
    snowView *snowV = [[snowView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:snowV];
     */
    
    /*
    /// 画水印
    UIImage *ori = [UIImage imageNamed:@"1.jpg"];
    UIGraphicsBeginImageContext(ori.size);
    [ori drawAtPoint:CGPointZero];
    
    NSString *str = @"LeeSin水印";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:36];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
//    [str drawAtPoint:CGPointMake(100, 100) withAttributes:dict];
    [str drawInRect:CGRectMake(100, 100, 200, 100) withAttributes:dict];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
     */
    
   /*
    ///裁剪图片
    CGFloat borderW = 20;
    UIImage *oriImage = [UIImage imageNamed:@"1.jpg"];
    
    CGSize size = CGSizeMake(oriImage.size.width + 2*borderW, oriImage.size.height + 2*borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    UIGraphicsBeginImageContext(size);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [[UIColor greenColor]set];
    [path fill];
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, oriImage.size.width, oriImage.size.height)];
    [clipPath addClip];
    [oriImage drawAtPoint:CGPointMake(borderW, borderW)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.iconImageV.image = newImage;
    */
   
    /*
    ///配合手势裁剪
    self.imageV.image = [UIImage imageNamed:@"4.png"];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    self.imageV.userInteractionEnabled = YES;
    [self.imageV addGestureRecognizer:pan];
    */
   
    /*
    ///配合手势擦除
    UIImageView *backImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageV.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:backImageV];
    
    self.imageV.image = [UIImage imageNamed:@"4.png"];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    self.imageV.userInteractionEnabled = YES;
    [self.imageV addGestureRecognizer:pan];
    */
    [self.view addSubview:self.clockV];
    
}

-(void)pan:(UIPanGestureRecognizer *)pan
{
    /*
    CGPoint curP = [pan locationInView:self.imageV];
    
    if (pan.state == UIGestureRecognizerStateBegan) { //1
        self.startP = curP;
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {//2
        CGFloat w = curP.x - self.startP.x;
        CGFloat h = curP.y - self.startP.y;
        
        CGRect rect = CGRectMake(self.startP.x, self.startP.y, w, h);
        self.coverView.frame = rect;
        
    }
    else if (pan.state == UIGestureRecognizerStateEnded) { //3
        
        UIGraphicsBeginImageContext(self.imageV.bounds.size);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        [path addClip];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.imageV.layer renderInContext:ctx];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.imageV.image = newImage;
        [self.coverView removeFromSuperview];
        
        
    }
     */
    
    CGFloat rectWH = 20;
    CGPoint curP = [pan locationInView:self.imageV];
    
    CGFloat x = curP.x - rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    
    CGRect rect = CGRectMake(x, y, rectWH, rectWH);
    
    UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.imageV.layer renderInContext:ctx];
    
    CGContextClearRect(ctx, rect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    self.imageV.image = newImage;
    UIGraphicsEndImageContext();
    
}

/*
///配合手势裁剪
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/root1/Desktop/123.jpg" atomically:YES];
    
}
*/


-(UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_imageV];
    }
    return _imageV;
}

-(UIImageView *)iconImageV
{
    if (!_iconImageV) {
        
        _iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 300, 300)];
        _iconImageV.backgroundColor = [UIColor redColor];
        [self.view addSubview:_iconImageV];
    }
    return _iconImageV;
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:_customView];
    
    if([_customView.path containsPoint:tapPoint]) {
        
        _customView.fillColor = [UIColor yellowColor];
        
        [_customView setNeedsDisplay];
    }
}

-(UIView *)coverView {
    
    if (_coverView == nil) {
        //创建UIView
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.7;
        _coverView = coverView;
        [self.view addSubview:coverView];
    }
    return _coverView;
    
}

-(clockView *)clockV
{
    if (!_clockV) {
        _clockV = [[clockView alloc]initWithFrame:self.view.bounds];
    }
    return _clockV;
}
@end
