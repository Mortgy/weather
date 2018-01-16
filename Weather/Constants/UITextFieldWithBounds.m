//
//  UITextFieldWithBounds.m
//  zingat
//
//  Created by mortgy on 06/09/16.
//  Copyright © 2016 Zingat. All rights reserved.
//

#import "UITextFieldWithBounds.h"

@implementation UITextFieldWithBounds

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

//
- (CGRect) rightViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 10;
    return textRect;
}

@end
