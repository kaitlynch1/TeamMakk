//
//  JBLineChartScaleView.m
//  TeamMakk
//
//  Created by Kaitlyn Lee on 2/21/15.
//  Copyright (c) 2015 teammakk. All rights reserved.
//

#import "JBLineChartScaleView.h"
CGFloat const kJBLineChartScaleViewSeparatorWidth = 0.5f;


@interface JBLineChartScaleView () {
  int _numSections;
}
@property (nonatomic, strong) UIView *topSeparatorView;
@end

@implementation JBLineChartScaleView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    _labels = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    _topSeparatorView = [[UIView alloc] init];
    _topSeparatorView.backgroundColor = [UIColor grayColor];
    [self addSubview:_topSeparatorView];
    
    _numSections = 3;
    _zeroLabel = [[UILabel alloc] init];
    _zeroLabel.adjustsFontSizeToFitWidth = YES;
    _zeroLabel.font = [UIFont systemFontOfSize:10];
    _zeroLabel.textAlignment = NSTextAlignmentLeft;
    _zeroLabel.textColor = [UIColor grayColor];
    _zeroLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_zeroLabel];
    
    _topLabel = [[UILabel alloc] init];
    _topLabel.adjustsFontSizeToFitWidth = YES;
    _topLabel.font = [UIFont systemFontOfSize:10];
    _topLabel.textAlignment = NSTextAlignmentRight;
    _topLabel.textColor = [UIColor grayColor];
    _topLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_topLabel];
    [self layoutSubviews];
  }
  return self;
}

- (void)layoutSubviews {
  [_topLabel sizeToFit];
  [_zeroLabel sizeToFit];
  CGRect topFrame = _topLabel.frame;
  topFrame.origin = CGPointMake(0, 0);
  _topLabel.frame = topFrame;
  _zeroLabel.frame = CGRectMake(0, self.frame.size.height - _zeroLabel.frame.size.height/2, _zeroLabel.frame.size.width, _zeroLabel.frame.size.height);
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
  CGContextSetLineWidth(context, 0.5);
  CGContextSetShouldAntialias(context, YES);
  
  CGFloat xOffset = 3;
  CGFloat yOffset = 0;
  CGFloat lineLength = self.frame.size.height - 2*yOffset;
  CGFloat stepLength = ceil((self.bounds.size.width) / (self.sectionCount - 1));
  
  for (int i=0; i<_numSections; i++)
  {
    CGContextSaveGState(context);
    {
      CGContextMoveToPoint(context, self.frame.size.width - (kJBLineChartScaleViewSeparatorWidth * 0.5), yOffset);
      CGContextAddLineToPoint(context, self.frame.size.width -  (kJBLineChartScaleViewSeparatorWidth * 0.5), yOffset + lineLength);
      CGContextStrokePath(context);
      xOffset += stepLength;
    }
    CGContextRestoreGState(context);
  }
}

@end