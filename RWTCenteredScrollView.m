//
//  RWTCenteredScrollView.m
//  CenteredImageScroller
//
//  Created by Main Account on 4/26/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTCenteredScrollView.h"

@interface RWTCenteredScrollView ()
@property (nonatomic, assign) BOOL isFirstTime;
@end


@implementation RWTCenteredScrollView


- (id)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        self.isFirstTime = YES;
    }
    return self;
}


- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.isFirstTime) {
        [self setZoomScales];
  }
  [self centerContent];
  if (self.isFirstTime) {
        self.isFirstTime = NO;
  }
}

- (void)centerContent {

  if (self.delegate && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
  
    UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];
    
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = viewToCenter.frame;
    
    if (frameToCenter.size.width < boundsSize.width) {
      frameToCenter.origin.x =(boundsSize.width - frameToCenter.size.width) / 2;
    } else {
      frameToCenter.origin.x = 0;
    }
    
    if (frameToCenter.size.height < boundsSize.height) {
      frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
      frameToCenter.origin.y = 0;
    }
    
    viewToCenter.frame = frameToCenter;
  
  }

}


- (void)setZoomScales {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        UIView *view = [self.delegate viewForZoomingInScrollView:self];
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = view.bounds.size;
    
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    self.maximumZoomScale = 3.0;
    }
}


@end
