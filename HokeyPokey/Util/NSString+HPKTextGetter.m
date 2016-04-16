//
//  NSString+HPKTextGetter.m
//  textView
//
//  Created by 胡 帅 on 16/4/13.
//  Copyright © 2016年 Disney. All rights reserved.
//



#import "NSString+HPKTextGetter.h"

@implementation HPKSearchResult

-(instancetype) initWithRange:(NSRange)aRange string:(NSString *)aString title:(NSString *)aTitle{
    self = [super init];
    if (self) {
        _range = aRange;
        _string = aString;
        _title = aTitle;
    }
    return self;
}

@end

@implementation NSString (HPKTextGetter)


- (NSArray<HPKSearchResult *> *) HPK_textResultsWithPairOpenString:(NSString *)open
                                                       closeString:(NSString *)close {

    NSRange startRange = [self rangeOfString:open];
    
    if (startRange.length == 0) {
        return nil;
    }
    
    NSUInteger startLocation = startRange.location;
    
    NSMutableArray<HPKSearchResult *> *mArr = [NSMutableArray array];

    HPKSearchResult * result;
    while ( (result = [self HPK_textResultWithPairOpenString:open closeString:close currentLocation:startLocation])) {
        [mArr addObject:result];
        startLocation = result.range.location + result.range.length + 1;
        result = nil;
    }
    if ([mArr count] == 0) {
        return nil;
    } else {
        return [mArr copy];
    }
    
    
}


- (HPKSearchResult *) HPK_textResultWithPairOpenString:(NSString *)open
                                           closeString:(NSString *)close
                                       currentLocation:(NSInteger)location {
    NSInteger curseLocation = location;
    
    NSRange range = NSMakeRange(curseLocation, self.length - curseLocation);
    
    NSRange searchRange = range;
    
    NSInteger openCount = 0;
    NSInteger closeCount = 0;
    
    NSRange nextOpenRange = [self rangeOfString:open options:0 range:searchRange];
    NSRange nextCloseRange = [self rangeOfString:close options:0 range:searchRange];
    
    NSRange firstOpenRange = nextOpenRange;
    NSString *firstTilte = @"pocky";

    if (firstOpenRange.location != NSNotFound) {
        NSRange thisLineRange = [self HPK_rangeOfCurrentLineCurrentLocation:firstOpenRange.location];
        NSRange substractRange = NSMakeRange(firstOpenRange.location+firstOpenRange.length, thisLineRange.length - firstOpenRange.length);
        if (substractRange.location < [self length] && NSMaxRange(substractRange) < [self length]) {
            firstTilte = [self substringWithRange:substractRange];
        }
    }

    if (nextOpenRange.location == NSNotFound || nextCloseRange.location == NSNotFound || nextCloseRange.location < nextOpenRange.location) {
        return nil;
    }
    openCount++;
    
    searchRange = NSMakeRange(nextOpenRange.location + 1, self.length - nextOpenRange.location - 1);

    
    NSRange targetRange = NSMakeRange(0,0);
    while (openCount != closeCount) {
        nextOpenRange = [self rangeOfString:open options:0 range:searchRange];
        nextCloseRange = [self rangeOfString:close options:0 range:searchRange];
        
        if (nextCloseRange.location == NSNotFound) {
            return nil;
        }
        
        if (nextOpenRange.location < nextCloseRange.location) {
            targetRange = nextOpenRange;
            openCount++;
        } else {
            targetRange = nextCloseRange;
            closeCount++;
        }

        searchRange = NSMakeRange(targetRange.location + 1, self.length - targetRange.location - 1);
    }
    
    NSRange resultRange = NSMakeRange(firstOpenRange.location, targetRange.location - firstOpenRange.location);

    if (resultRange.location < [self length] && NSMaxRange(resultRange) <= [self length]) {
        NSString *result = [self substringWithRange:resultRange];
        return [[HPKSearchResult alloc] initWithRange:resultRange string:result title:firstTilte];
    } else {
        return nil;
    }
}

- (NSString *) HPK_stringBySubtractSearchResults:(NSArray<HPKSearchResult *> *) searchResults {
    searchResults = [searchResults sortedArrayUsingComparator:^NSComparisonResult(HPKSearchResult *obj1, HPKSearchResult *obj2) {
        return [@(obj1.range.location) compare:@(obj2.range.location)];
    }];
    
    NSMutableString *mStr = [NSMutableString string];
    NSRange nowRange = NSMakeRange(0, self.length);
    for (HPKSearchResult *searchResult in searchResults) {
        NSRange range = searchResult.range;
        NSRange parseRange = NSMakeRange(nowRange.location, searchResult.range.location - nowRange.location);
        if (parseRange.location < self.length && parseRange.length <= self.length && NSMaxRange(parseRange) <= self.length) {
            NSString * subStr = [self substringWithRange:parseRange];
            [mStr appendString:subStr];
        }

        nowRange = NSMakeRange(range.location + range.length, self.length - range.location - range.length);
    }
    
    if (nowRange.location < self.length && nowRange.length <= self.length && NSMaxRange(nowRange) <= self.length){
        NSString * subStr = [self substringWithRange:nowRange];
        [mStr appendString:subStr];
    }
    
    return [mStr copy];
}

- (NSRange) HPK_rangeOfCurrentLineCurrentLocation:(NSInteger)location {
    NSInteger curseLocation = location;
    NSRange range = NSMakeRange(curseLocation, self.length - curseLocation);
    NSRange thisLineRange = [self rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:0 range:range];
    
    if (thisLineRange.location != NSNotFound) {
        NSRange lineRange = NSMakeRange(curseLocation, thisLineRange.location - curseLocation + 1);
        return lineRange;
    } else {
        return NSMakeRange(0, 0);
    }
}


@end
