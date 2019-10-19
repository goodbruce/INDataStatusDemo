//
//  NSString+Size.m
//  BruceGuo
//
//  Created by BruceGuo on 2018/07/18.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

/**
 计算字符串的Size
 
 @param font 字体大小
 @param maxSize 最大范围的Size
 @return 计算后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font forMaxSize:(CGSize)maxSize {
    if (self && self.length == 0) {
        return CGSizeMake(0.0, 0.0);
    }
    
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange allRange = [self rangeOfString:self];
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    [attributedStr setAttributes:attribute range:allRange];
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize textSize = [attributedStr boundingRectWithSize:maxSize options:options context:nil].size;
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end
