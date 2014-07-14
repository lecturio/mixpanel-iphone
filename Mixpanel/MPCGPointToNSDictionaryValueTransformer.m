//
// Copyright (c) 2014 Mixpanel. All rights reserved.

#import "MPValueTransformers.h"


@implementation MPCGPointToNSDictionaryValueTransformer

+ (Class)transformedValueClass
{
    return [NSDictionary class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    if ([value respondsToSelector:@selector(CGPointValue)])
    {
        return CFBridgingRelease(CGPointCreateDictionaryRepresentation([value CGPointValue]));
    }

    return nil;
}

- (id)reverseTransformedValue:(id)value
{
    CGPoint point = CGPointZero;
    if ([value isKindOfClass:[NSDictionary class]] && CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)value, &point))
    {
        return [NSValue valueWithCGPoint:point];
    }

    return [NSValue valueWithCGPoint:CGPointZero];
}

@end