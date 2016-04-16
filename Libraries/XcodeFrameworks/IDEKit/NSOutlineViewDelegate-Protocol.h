/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSControlTextEditingDelegate-Protocol.h"

@protocol NSOutlineViewDelegate <NSControlTextEditingDelegate>

@optional
- (id)outlineView:(id)arg1 dataCellForTableColumn:(id)arg2 item:(id)arg3;
- (void)outlineView:(id)arg1 didAddRowView:(id)arg2 forRow:(long long)arg3;
- (void)outlineView:(id)arg1 didClickTableColumn:(id)arg2;
- (void)outlineView:(id)arg1 didDragTableColumn:(id)arg2;
- (void)outlineView:(id)arg1 didRemoveRowView:(id)arg2 forRow:(long long)arg3;
- (double)outlineView:(id)arg1 heightOfRowByItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2;
- (void)outlineView:(id)arg1 mouseDownInHeaderOfTableColumn:(id)arg2;
- (id)outlineView:(id)arg1 nextTypeSelectMatchFromItem:(id)arg2 toItem:(id)arg3 forString:(id)arg4;
- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2;
- (id)outlineView:(id)arg1 selectionIndexesForProposedSelection:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldCollapseItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldEditTableColumn:(id)arg2 item:(id)arg3;
- (BOOL)outlineView:(id)arg1 shouldExpandItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldReorderColumn:(long long)arg2 toColumn:(long long)arg3;
- (BOOL)outlineView:(id)arg1 shouldSelectItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldSelectTableColumn:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldShowCellExpansionForTableColumn:(id)arg2 item:(id)arg3;
- (BOOL)outlineView:(id)arg1 shouldShowOutlineCellForItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldTrackCell:(id)arg2 forTableColumn:(id)arg3 item:(id)arg4;
- (BOOL)outlineView:(id)arg1 shouldTypeSelectForEvent:(id)arg2 withCurrentSearchString:(id)arg3;
- (double)outlineView:(id)arg1 sizeToFitWidthOfColumn:(long long)arg2;
- (id)outlineView:(id)arg1 toolTipForCell:(id)arg2 rect:(struct CGRect *)arg3 tableColumn:(id)arg4 item:(id)arg5 mouseLocation:(struct CGPoint)arg6;
- (id)outlineView:(id)arg1 typeSelectStringForTableColumn:(id)arg2 item:(id)arg3;
- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3;
- (void)outlineView:(id)arg1 willDisplayCell:(id)arg2 forTableColumn:(id)arg3 item:(id)arg4;
- (void)outlineView:(id)arg1 willDisplayOutlineCell:(id)arg2 forTableColumn:(id)arg3 item:(id)arg4;
- (void)outlineViewColumnDidMove:(id)arg1;
- (void)outlineViewColumnDidResize:(id)arg1;
- (void)outlineViewItemDidCollapse:(id)arg1;
- (void)outlineViewItemDidExpand:(id)arg1;
- (void)outlineViewItemWillCollapse:(id)arg1;
- (void)outlineViewItemWillExpand:(id)arg1;
- (void)outlineViewSelectionDidChange:(id)arg1;
- (void)outlineViewSelectionIsChanging:(id)arg1;
- (BOOL)selectionShouldChangeInOutlineView:(id)arg1;
@end

