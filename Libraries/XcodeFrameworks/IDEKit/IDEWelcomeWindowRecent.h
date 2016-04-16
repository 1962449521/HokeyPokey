/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

#import "NSCopying-Protocol.h"

@class NSImage, NSString, NSURL;

@interface IDEWelcomeWindowRecent : NSObject <NSCopying>
{
    NSURL *_url;
}

+ (id)_descriptionForLastOpenedDate:(id)arg1 isLastOpenedDate:(BOOL)arg2;
+ (id)recentsForURLs:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
@property(readonly) NSImage *image;
- (id)initWithURL:(id)arg1;
@property(readonly) NSString *lastOpenedDate;
@property(readonly) NSString *name;
@property(readonly) NSString *truncatedPath;
@property(readonly) NSURL *url;

@end

