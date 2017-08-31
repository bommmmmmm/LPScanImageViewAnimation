//
//  LPScanImageView.m
//  PNCMobileBank-bbw
//
//  Created by liuping on 17/6/27.
//  Copyright © 2017年 张瑞. All rights reserved.
//

#import "LPScanImageView.h"

@implementation LPScanImageView

//原始尺寸
static CGRect oldframe;
static NSString * strType;
/**
 *  浏览大图
 *
 *  @param scanImageView 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview{
    //当前imageview的图片
    UIImage *image = currentImageview.image;
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    //此时视图不会显示
    [backgroundView setAlpha:0];
    //将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
//    [PNCGlobal sharedInstance].changeBarQR = ^(UIImage *qrImage, UIImage *barcodeImage, NSString *QRcode) {
//        imageView.image = qrImage;
//    };
    strType = @"二维码";
    [imageView setImage:image];
    [imageView setTag:0];
    [backgroundView addSubview:imageView];
    //将原始视图添加到背景视图中
    [window addSubview:backgroundView];
    
    
    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //动画放大所展示的ImageView
    
    [UIView animateWithDuration:0.4 animations:^{
//        CGFloat y,width,height;
//        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
//        //宽度为屏幕宽度
//        width = [UIScreen mainScreen].bounds.size.width;
//        //高度 根据图片宽高比设置
//        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(0, 0, oldframe.size.width * 1.2, oldframe.size.height *1.2)];
    
        imageView.center =backgroundView.center;
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    
}

/**
 *  恢复imageView原始尺寸
 *
 *  @param tap 点击事件
 */
+(void)hideImageView:(UITapGestureRecognizer *)tap{
//    UIView *backgroundView = tap.view;
//    //原始imageview
//    UIImageView *imageView = [tap.view viewWithTag:0];
//    //恢复
//    [UIView animateWithDuration:0.4 animations:^{
//        [imageView setBounds:oldframe];
//        [backgroundView setAlpha:0];
//    } completion:^(BOOL finished) {
//        //完成后操作->将背景视图删掉
//        [backgroundView removeFromSuperview];
//    }];
    
    
    if (isEqual(strType, @"二维码")) {
        UIView *backgroundView = tap.view;
        //原始imageview
        UIImageView *imageView = [tap.view viewWithTag:0];
        //恢复
        [UIView animateWithDuration:0.4 animations:^{
            [imageView setBounds:oldframe];
            [backgroundView setAlpha:0];
        } completion:^(BOOL finished) {
            //完成后操作->将背景视图删掉
            [backgroundView removeFromSuperview];
        }];

    }else{
        UIView *backgroundView = tap.view;
        //原始imageview
        UIImageView *imageView = [tap.view viewWithTag:1];
        //恢复
        [UIView animateWithDuration:0.4 animations:^{
            [imageView setBounds:oldframe];
            [backgroundView setAlpha:0];
        } completion:^(BOOL finished) {
            //完成后操作->将背景视图删掉
            [backgroundView removeFromSuperview];
        }];
    }
}


+(void)scanBarCodeImageWithImageView:(UIImageView *)currentImageview barcode:(NSString *)barcode{
    //当前imageview的图片
    UIImage *image = currentImageview.image;
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    //此时视图不会显示
    [backgroundView setAlpha:0];
    //将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    [imageView setTag:0];
    [backgroundView addSubview:imageView];
    //将原始视图添加到背景视图中
    [window addSubview:backgroundView];
    
    strType = @"条形码";
    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //动画放大所展示的ImageView
    
    [UIView animateWithDuration:0.4 animations:^{
        // 旋转图片
        imageView.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
        
                CGFloat y,width,height;
                y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
                //宽度为屏幕宽度
                width = [UIScreen mainScreen].bounds.size.width;
                //高度 根据图片宽高比设置
                height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(50*SCALE, 50*SCALE,150*SCALE , GLOBALHEIGHT - 100*SCALE)];
        
        
        
        imageView.center =backgroundView.center;
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
        
        UILabel *label = [[UILabel alloc] init];
        
        NSString *dispalyStr = [NSString stringWithFormat:@"%@  %@  %@  %@  %@", [barcode substringWithRange:NSMakeRange(0, 4) ], [barcode substringWithRange:NSMakeRange(4, 4)], [barcode substringWithRange:NSMakeRange(8, 4)], [barcode substringWithRange:NSMakeRange(12, 4)], [barcode substringFromIndex:16]];
        
        label.text = dispalyStr;
        
        
//        [PNCGlobal sharedInstance].changeBarQR = ^(UIImage *qrImage, UIImage *barcodeImage, NSString *QRcode) {
//            imageView.image = barcodeImage;
//            label.text = QRcode;
//        };
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:25]];
        label.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
        [backgroundView addSubview:label];
        [label setFrame:CGRectMake(60*SCALE, 50*SCALE,20*SCALE , GLOBALHEIGHT - 100*SCALE)];
        
        UILabel *warringlabel = [[UILabel alloc] init];
        warringlabel.text = @"付款码数字仅用于支付时向收银员展示，请勿泄露以防诈骗";
        warringlabel.textAlignment = NSTextAlignmentCenter;
        [warringlabel setFont:[UIFont systemFontOfSize:15]];
        warringlabel.textColor = PNCColor(250, 218, 141);
        warringlabel.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
        [backgroundView addSubview:warringlabel];
//        [warringlabel setFrame:CGRectMake((GLOBALWIDTH - 400)/2, 50*SCALE,20*SCALE , 400)];
        [warringlabel setFrame:CGRectMake(GLOBALWIDTH - 60*SCALE, (GLOBALHEIGHT - 400)/2,15 , 400)];
        
        
        UIImageView *alartImageView = [[UIImageView alloc] init];
        alartImageView.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
        alartImageView.image = [UIImage imageNamed:@"pay_cok_image"];
        [backgroundView addSubview:alartImageView];

        [alartImageView setFrame:CGRectMake(GLOBALWIDTH - 60*SCALE, 60*SCALE,20*SCALE , 20*SCALE)];
        [alartImageView setFrame:CGRectMake(GLOBALWIDTH - 60*SCALE, ((GLOBALHEIGHT - 400)/2) - 15,15 , 15)];
        
        
        
    }];
    
}






@end
