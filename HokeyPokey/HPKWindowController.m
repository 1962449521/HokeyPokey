//
//  MyWindowController.m
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/12.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import "HPKWindowController.h"

#import "HPKConst.h"
#import "HPKPluginMain.h"


@interface HPKWindowController () <NSTableViewDelegate>

// 文案内容绑定
@property (strong)  NSString *headerTitle4Show;
@property (strong)  NSString *headerTitle4Identifier;

// 切换窗口显示是否悬浮按钮
@property (weak) IBOutlet NSButton *btnDock;

@end

@implementation HPKWindowController {
    BOOL _isDock; // 当前窗口level标志
}

#pragma mark - 生命周期
- (NSString *) windowNibName {
    return @"HPKWindowController";
}

- (void) windowDidLoad {
    [super windowDidLoad];
    _isDock = NO;
}

- (void)awakeFromNib {
    self.headerTitle4Show = HPKHeaderTitle4Show;
    self.headerTitle4Identifier = HPKHeaderTitle4Identifier;
    [self.btnDock setTitle:HPKLabel4WindowDock];
}

#pragma mark - 用户交互

// 切换窗口显示是否悬浮
- (IBAction) dockOrnotBtnClick:(NSButton *)sender {
    _isDock = !_isDock;
    [sender setTitle:_isDock? HPKLable4WindowNormal : HPKLabel4WindowDock];
    [self.window setLevel:_isDock? NSDockWindowLevel : NSNormalWindowLevel ];
}

- (void) inspect:(NSArray *)selectedObjects {
    NSUInteger savedSelectionIndex = [self.contentArray selectionIndex];
    NSDictionary *editItem = [selectedObjects objectAtIndex:0];
    [self.contentArray removeObjects:selectedObjects];

    NSMutableDictionary *mEditItem = [NSMutableDictionary dictionary];
    [mEditItem addEntriesFromDictionary:editItem];
    BOOL shouldShow = ![editItem[HPKIsShownKey] boolValue];
    [mEditItem setObject:@(shouldShow) forKey:HPKIsShownKey];
    NSString *editTile = editItem[HPKTitleKey];
    
    [self.contentArray insertObject:mEditItem atArrangedObjectIndex:savedSelectionIndex];
    [self.pluginMain refreshEditorAndFileAtTiltle:editTile shouldShow:shouldShow];
}




@end
