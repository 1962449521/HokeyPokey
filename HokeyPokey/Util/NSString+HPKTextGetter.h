//
//  NSString+HPKTextGetter.h
//  textView
//
//  Created by 胡 帅 on 16/4/13.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPKSearchResult : NSObject

@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *title;


-(instancetype) initWithRange:(NSRange)aRange string:(NSString *)aString title:(NSString *)aTitle;

@end

@interface NSString (HPKTextGetter)


- (NSArray<HPKSearchResult *> *) HPK_textResultsWithPairOpenString:(NSString *)open
                                                       closeString:(NSString *)close;

- (NSString *) HPK_stringBySubtractSearchResults:(NSArray<HPKSearchResult *> *) searchResults;

@end
