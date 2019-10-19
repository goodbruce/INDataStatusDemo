//
//  NSString+Size.h
//  BruceGuo
//
//  Created by BruceGuo on 2018/07/18.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 计算字符串的Size
 
 @param font 字体大小
 @param maxSize 最大范围的Size
 @return 计算后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font forMaxSize:(CGSize)maxSize;

@end
