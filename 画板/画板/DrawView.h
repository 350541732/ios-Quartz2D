//
//  DrawView.h
//  画板
//
//  Created by root1 on 2019/1/16.
//  Copyright © 2019 root1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawView : UIView


@property (nonatomic,strong)UIImage *image;

-(void)clear;

-(void)undo;

-(void)erase;

-(void)setLineWidth:(CGFloat)width;

-(void)setLineColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
