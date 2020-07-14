//
//  LSChangeAvatar.m
//  larson
//
//  Created by larson on 2016/11/1.
//  Copyright © 2016年 larosn. All rights reserved.
//

#import "LSChangeAvatarTool.h"
#import <AFHTTPSessionManager.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@interface LSChangeAvatarTool()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/** 更换图片成功之后的回调*/
@property(nonatomic,copy) void(^didPickerImageBlock)(UIImage *);

@end

@implementation LSChangeAvatarTool
- (void)changeAvatarWithContainerVC:(UIViewController *)containerVC completion:(void (^)(UIImage *))completion
{
    self.didPickerImageBlock = completion;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 检测相机权限
        AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (cameraStatus == AVAuthorizationStatusRestricted || cameraStatus == AVAuthorizationStatusDenied) {
            [LSAlertController alertUserToOpenPermissions:ZCKJGetCameraPermissions];
            return;
        }
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [containerVC presentViewController:pickerVC animated:YES completion:nil];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 相册
        PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
        if (photoStatus == PHAuthorizationStatusRestricted || photoStatus == PHAuthorizationStatusDenied) {
            [LSAlertController alertUserToOpenPermissions:ZCKJGetPhotoPermissions];
            return;
        } else if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            [SSJDAlertController alertUserToOpenPermissions:@"相机不可用"];
            return;
        }
        [pickerVC.navigationBar setBarTintColor:UIColor.whiteColor];
        // 字体颜色
        [pickerVC.navigationBar setTintColor:[UIColor whiteColor]];
        // titleView的字体颜色
        [pickerVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        pickerVC.navigationBar.translucent = NO;
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [containerVC presentViewController:pickerVC animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [containerVC dismissViewControllerAnimated:YES completion:nil];
    }]];
    [containerVC presentViewController:alert animated:YES completion:nil];
}



// 选择图片
- (void)selectImageWithContainerVC:(UIViewController *)containerVC
completion:(void(^)(UIImage *))completion
{
    self.didPickerImageBlock = completion;
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusRestricted || photoStatus == PHAuthorizationStatusDenied) {
        [LSAlertController alertUserToOpenPermissions:ZCKJGetPhotoPermissions];
        return;
    } else if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [LSAlertController alertUserToOpenPermissions:@"相机不可用"];
        return;
    }
    [pickerVC.navigationBar setBarTintColor:UIColor.whiteColor];
    // 字体颜色
    [pickerVC.navigationBar setTintColor:[UIColor whiteColor]];
    // titleView的字体颜色
    [pickerVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    pickerVC.navigationBar.translucent = NO;
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.allowsEditing = YES;
    pickerVC.delegate = self;
    [containerVC presentViewController:pickerVC animated:YES completion:nil];
}



#pragma mark <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *newImage = [image imageScaleWithScreenWidth];
//    NSData *imageData = UIImagePNGRepresentation(newImage);
    !self.didPickerImageBlock ? : self.didPickerImageBlock(newImage);
           [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
