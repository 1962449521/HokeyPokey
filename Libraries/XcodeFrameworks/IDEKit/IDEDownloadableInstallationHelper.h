/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

#import "DVTDownloadableInstallationHelper-Protocol.h"

@interface IDEDownloadableInstallationHelper : NSObject <DVTDownloadableInstallationHelper>
{
}

- (void)alertEnded:(id)arg1 returnCode:(long long)arg2 contextInfo:(void *)arg3;
- (void)downloadableNamed:(id)arg1 needsTerminationOfAppsWithBundleIdentifier:(id)arg2 completionBlock:(id)arg3;

@end

