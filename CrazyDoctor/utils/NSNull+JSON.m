//
//  NSNull+JSON.m
//  HiGolf
//
//  Created by xubojoy on 15/10/23.
//
//

#import "NSNull+JSON.h"

@implementation NSNull (JSON)
- (NSUInteger)length {
    return 0;
}

- (NSInteger)integerValue {
    return 0;
};

- (float)floatValue {
    return 0;
};

- (NSString *)description {
    return @"0(NSNull)";
}

- (NSArray *)componentsSeparatedByString:(NSString *)separator {
    return @[];
}

- (id)objectForKey:(id)key {
    return nil;
}

- (BOOL)boolValue {
    return NO;
}

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet{
    NSRange nullRange = {NSNotFound, 0};
    return nullRange;
}
@end
