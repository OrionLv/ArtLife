//
//  XBHeaderView.m
//  ArtLife
//
//  Created by lxb on 2017/3/7.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBHeaderView.h"

@interface XBHeaderView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *headIcon;

@end

@implementation XBHeaderView

+(instancetype)loadHeadView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XBHeaderView class]) owner:nil options:nil] lastObject];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        [self setupSubViews];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setupSubViews];
}

#pragma mark - private Method
-(void)setupSubViews{
    
    
    
}


#pragma mark - button Action

- (IBAction)login:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          UIImagePickerController *imageCon = [[UIImagePickerController alloc] init];
                          imageCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                          imageCon.delegate = self;
                          imageCon.allowsEditing = YES;
                          
                          [self.controller presentViewController:imageCon animated:YES completion:nil];
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self.controller presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [self.headIcon setBackgroundImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
