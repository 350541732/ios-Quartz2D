//
//  ViewController.m
//  画板
//
//  Created by root1 on 2019/1/16.
//  Copyright © 2019 root1. All rights reserved.
//

#import "ViewController.h"

#import "DrawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.drawView];
    
}
- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)photo:(id)sender {
   
    UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickVC.delegate = self;
    
    [self presentViewController:pickVC animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.drawView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)save:(id)sender {
    
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.drawView.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//当写入完成时调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%s",__func__);
}


- (IBAction)setLineWidth:(UISlider *)sender {
    
    [self.drawView setLineWidth:sender.value];
}

- (IBAction)setLineColor:(UIButton *)sender {
    
    [self.drawView setLineColor:sender.backgroundColor];
}




-(DrawView *)drawView
{
    if (!_drawView) {
        _drawView = [[DrawView alloc]initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-300)];
      
    }
    return _drawView;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
