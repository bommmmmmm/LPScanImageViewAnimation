//
//  LPScanImageView.h
//  PNCMobileBank-bbw
//
//  Created by liuping on 17/6/27.
//  Copyright © 2017年 张瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LPScanImageView : NSObject
/**
 *  浏览大图
 *
 *  @param scanImageView 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview;

+(void)scanBarCodeImageWithImageView:(UIImageView *)currentImageview barcode:(NSString *)barcode;
@end
