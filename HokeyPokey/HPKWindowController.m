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
    
    NSURL *url = [self.pluginMain activeDocumentURL];
    NSMutableArray *mArr = [self.pluginMain.contentArrDic objectForKey:url];
    
    __block NSUInteger found = -1;
    [mArr enumerateObjectsUsingBlock:^(NSMutableDictionary * obj, NSUInteger idx, BOOL * stop) {
        if ([obj[HPKTitleKey] isEqualToString: editTile]) {
            found = idx;
            *stop = YES;
        }
    }];
    
    if (found != -1) {
        NSDictionary *editItem = [mArr objectAtIndex:found];
        NSMutableDictionary *mEditItem = [NSMutableDictionary dictionary];
        [mEditItem addEntriesFromDictionary:editItem];
        [mEditItem setObject:@(shouldShow) forKey:HPKIsShownKey];
        [mArr removeObject:editItem];
        [mArr insertObject:mEditItem atIndex:found];
        [self.pluginMain refreshFileContentAccording2Selection];
    }
}




@end
