//
//  UIView+User_View.m
//  Mango_User
//
//  Created by 雷学田 on 2018/6/5.
//  Copyright © 2018年 Mango. All rights reserved.
//

#import "UIView+User_View.h"

@implementation UIView (User_View)

-(void)setX:(CGFloat)x {
     CGRect frame = self.frame;
     frame.origin.x = x;
     self.frame = frame;
}

-(CGFloat)x {
     return self.frame.origin.x;
}

-(void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;

    self.frame = frame;
}
-(CGFloat)y {
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


-(CGFloat)centerX {
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;

    self.frame = frame;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;

    self.frame = frame;
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
}

-(CGSize)size {
    return self.frame.size;
}

-(void)setOrign:(CGPoint)orign {
    CGRect frame = self.frame;
    frame.origin = orign;

    self.frame = frame;
}

-(CGPoint)orign {
    return self.frame.origin;
}


@end
