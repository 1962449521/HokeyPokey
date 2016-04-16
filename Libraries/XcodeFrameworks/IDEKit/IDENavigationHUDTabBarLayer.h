/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "CALayer.h"

#import "IDENavigationHUDDisposableLayer-Protocol.h"
#import "IDENavigationHUDSelectionDrivenLayer-Protocol.h"
#import "IDENavigationHUDWindowLevelNavigableLayer-Protocol.h"

@class CAGradientLayer, CAScrollLayer, IDENavigationHUDSelection, IDENavigationHUDTabBarNewTabLayer, IDENavigationHUDTabBarTabLayer, IDENavigationHUDWorkspaceWindowLayer, IDEWorkspaceWindowController, NSDictionary, NSMapTable;

@interface IDENavigationHUDTabBarLayer : CALayer <IDENavigationHUDSelectionDrivenLayer, IDENavigationHUDWindowLevelNavigableLayer, IDENavigationHUDDisposableLayer>
{
    IDENavigationHUDWorkspaceWindowLayer *_workspaceWindowLayer;
    NSMapTable *_strongTabControllerToStrongTabLayerMap;
    IDENavigationHUDTabBarNewTabLayer *_newTabButton;
    BOOL _shouldScrollSelectedTabVisibleInLayout;
    IDENavigationHUDSelection *_initialSelection;
    IDENavigationHUDSelection *_selection;
    CAGradientLayer *_rightOverflowLayer;
    CAGradientLayer *_leftOverflowLayer;
    CAScrollLayer *_tabsScrollLayer;
    NSDictionary *_options;
}

@property(readonly) BOOL canCreateNewTab;
- (void)dispose;
- (id)initWithWorkspaceWindowLayer:(id)arg1 initialSelection:(id)arg2 options:(id)arg3;
- (void)layoutSublayersOfLayer:(id)arg1;
- (id)navigationHUDController;
- (id)orderedTabLayers;
@property(readonly) IDENavigationHUDTabBarTabLayer *selectedTabLayer;
@property(copy) IDENavigationHUDSelection *selection; // @synthesize selection=_selection;
- (id)selectionForNavigatingDown;
- (id)selectionForNavigatingLeft;
- (id)selectionForNavigatingLeftOneTab;
- (id)selectionForNavigatingRight;
- (id)selectionForNavigatingRightOneTab;
- (id)selectionForNavigatingUp;
@property(readonly) BOOL shouldOnlySelectInitialTab;
- (id)tabLayerForTabController:(id)arg1;
@property(readonly) IDEWorkspaceWindowController *workspaceWindowController;
@property(readonly) IDENavigationHUDWorkspaceWindowLayer *workspaceWindowLayer; // @synthesize workspaceWindowLayer=_workspaceWindowLayer;

@end
