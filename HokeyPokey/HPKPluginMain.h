//
//  PluginMain.h
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/12.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HPKPluginMain : NSObject

// hokey pokey数据库
@property (nonatomic, strong) NSMutableDictionary *originalTextDic;
@property (nonatomic, strong) NSMutableDictionary *contentArrDic;

// 当前编辑文档地址
- ( NSURL *) activeDocumentURL;

// 根据用户对hokey pokey窗口的点击更新文档和显示
- (void) refreshFileContentAccording2Selection;
@end
