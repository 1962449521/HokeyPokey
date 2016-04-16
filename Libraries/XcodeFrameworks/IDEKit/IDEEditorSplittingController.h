/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@class DVTGradientImageButton;

@interface IDEEditorSplittingController : NSObject
{
    DVTGradientImageButton *_addSplitButton;
    DVTGradientImageButton *_removeSplitButton;
    id <IDEEditorSplittingControllerDelegate> _delegate;
}

- (void)addSplitAction:(id)arg1;
- (id)addSplitButton;
@property id <IDEEditorSplittingControllerDelegate> delegate; // @synthesize delegate=_delegate;
- (id)init;
- (void)removeSplitAction:(id)arg1;
- (id)removeSplitButton;

@end

