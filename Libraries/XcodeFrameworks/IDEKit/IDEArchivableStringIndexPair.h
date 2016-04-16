/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

#import "NSCoding-Protocol.h"
#import "NSCopying-Protocol.h"

@class NSString;

@interface IDEArchivableStringIndexPair : NSObject <NSCopying, NSCoding>
{
    NSString *_identifier;
    unsigned long long _index;
}

- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)description;
- (void)encodeWithCoder:(id)arg1;
- (unsigned long long)hash;
@property(readonly) NSString *identifier; // @synthesize identifier=_identifier;
@property(readonly) unsigned long long index; // @synthesize index=_index;
- (id)initWithCoder:(id)arg1;
- (id)initWithIdentifier:(id)arg1 index:(unsigned long long)arg2;
- (BOOL)isEqual:(id)arg1;

@end

