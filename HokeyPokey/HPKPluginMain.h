//
//  PluginMain.h
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/12.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HPKPluginMain : NSObject

/**
 *  根据用户对hokey pokey窗口的点击更新XCode显示和物理文档
 *
 *  @param editedTitle 要操作的方案名
 *  @param isShow      该方案是否显示
 */
- (void) refreshEditorAndFileAtTiltle:(NSString *)editedTitle shouldShow:(BOOL)shouldShow;

@end
