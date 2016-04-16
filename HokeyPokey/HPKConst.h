//
//  HPKConst.h
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/13.
//  Copyright © 2016年 Disney. All rights reserved.
//

#ifndef HPKConst_h
#define HPKConst_h

// ------------ hokeypokey识别的开始和结束标志
#define HPKStartStringTag             @"//hokey"
#define HPKEndStringTag               @"//pokey"

// ------------ 表头和窗口状态切换的UI文案
#define HPKHeaderTitle4Show           @"SHOW"
#define HPKHeaderTitle4Identifier     @"IDENTIFIER"

#define HPKLabel4WindowDock           @"dock"
#define HPKLable4WindowNormal         @"normal"

// ------------ 快捷键设置
#define HPKRequireKey4HideShow        @YES
#define HPKKeyEquivalent4HideShow     @"h"
#define HPKKeyMask4HideShow           NSShiftKeyMask | NSCommandKeyMask

#define HPKRequireKey4Make            @YES
#define HPKKeyEquivalent4Make         @"w"
#define HPKKeyMask4Make               NSShiftKeyMask | NSCommandKeyMask

#define HPKRequireKey4Resume          @YES
#define HPKKeyEquivalent4Resume       @"x"
#define HPKKeyMask4Resume             NSShiftKeyMask | NSCommandKeyMask

// ------------ 以下请勿更改
#define HPKIsShownKey                 @"isShow"
#define HPKTitleKey                   @"identifier"
#define HPKPockyResultsKey            @"pockyResultsKey"
#define HPKFileURLKey                 @"fileURLKey"

#endif /* HPKConst_h */
