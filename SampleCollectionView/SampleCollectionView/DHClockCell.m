//
//  DHClockCell.m
//  SampleCollectionView
//
//  Created by derrick on 4/15/13.
//  Copyright (c) 2013 Derrick Hathaway. All rights reserved.
//

#import "DHClockCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DHClockCell ()
@property (nonatomic) CALayer *hourHand;
@property (nonatomic) CALayer *minuteHand;
@property (nonatomic) CALayer *secondHand;
@property (nonatomic) CALayer *face;
@end

@implementation DHClockCell

- (CALayer *)hourHand
{
    if (_hourHand) {
        return _hourHand;
    }
    _hourHand = [CALayer layer];
    _hourHand.backgroundColor = [UIColor darkGrayColor].CGColor;
    [self.face addSublayer:_hourHand];
    
    return _hourHand;
}

- (CALayer *)minuteHand
{
    if (_minuteHand) {
        return _minuteHand;
    }
    _minuteHand = [CALayer layer];
    _minuteHand.backgroundColor = [UIColor darkGrayColor].CGColor;
    [self.face insertSublayer:_minuteHand above:self.hourHand];
    
    return _minuteHand;
}

- (CALayer *)secondHand
{
    if (_secondHand) {
        return _secondHand;
    }
    _secondHand = [CALayer layer];
    _secondHand.backgroundColor = [UIColor redColor].CGColor;
    [self.face insertSublayer:_secondHand above:self.minuteHand];
    
    return _secondHand;
}

- (CALayer *)face
{
    if (_face) {
        return _face;
    }
    _face = [CALayer layer];
    _face.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_face];
    
    return _face;
}

- (void)layoutHand:(CALayer *)hand withWidth:(CGFloat)width length:(CGFloat)length angle:(CGFloat)angle
{
    static const CGFloat tailLength = 8.f;
    
    CGSize boundSize = self.bounds.size;
    
    CGRect rect = CGRectMake(0., 0., length + tailLength, width);
    hand.bounds = rect;
    hand.position = CGPointMake(boundSize.width/2.f, boundSize.height/2.f);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, angle, 0., 0., 1.);
    transform = CATransform3DTranslate(transform, length/2.f, 0.f, 0.f);
    hand.transform = transform;
}

- (void)layoutClock
{
    CGSize boundSize = self.bounds.size;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self.timestamp];
    
    static const CGFloat TWO_PI = M_PI + M_PI;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.face.frame = CGRectMake(0., 0., boundSize.width, boundSize.height);
    self.face.cornerRadius = boundSize.width/2.f;
    
    CGFloat hourProgress = components.minute / 60.f;
    [self layoutHand:self.hourHand withWidth:6.f length:boundSize.width * 0.25  angle:((components.hour + hourProgress) / 12.f * TWO_PI) - M_PI_2];
    [self layoutHand:self.minuteHand withWidth:4.f length:boundSize.width * 0.40 angle:hourProgress * TWO_PI - M_PI_2];
    [self layoutHand:self.secondHand withWidth:1.f length:boundSize.width * 0.45 angle:components.second / 60.f * TWO_PI - M_PI_2];
    
    [CATransaction commit];
}

- (void)setTimestamp:(NSDate *)timestamp
{
    if (_timestamp == timestamp) {
        return;
    }
    
    _timestamp = timestamp;
    [self layoutClock];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutClock];
}
@end
