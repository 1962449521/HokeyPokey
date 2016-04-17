//
//  MyWindowController.h
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/12.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HPKPluginMain;
@interface HPKWindowController : NSWindowController

@property (weak) HPKPluginMain *pluginMain;// 插件管理对象
@property (weak) IBOutlet NSTableView *tableView;// 插件窗口主控件

// 文案内容绑定
@property (strong)  NSString *windowTitle;
@property (strong)  IBOutlet NSArrayController *contentArray;

// 用户双击事件绑定
- (void) inspect:(NSArray *)selectedObjects;

@end
