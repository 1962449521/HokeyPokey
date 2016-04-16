//
//  PluginMain.m
//  HokeyPokey
//
//  Created by 胡 帅 on 16/4/12.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import "HPKPluginMain.h"

#import "XcodeMisc.h"
#import <IDEKit/IDEWorkspaceWindowController.h>
#import <IDEKit/IDEEditorArea.h>

#import "HPKConst.h"
#import "WHUMacro.h"
#import "NSString+HPKTextGetter.h"

#import "HPKWindowController.h"
#import "WHUKVOController.h"


id objc_getClass(const char* name);

static Class DVTSourceTextViewClass;
static Class IDESourceCodeEditorClass;
static Class IDEApplicationClass;
static Class IDEWorkspaceWindowControllerClass;

@interface HPKPluginMain() <NSWindowDelegate>

@property (nonatomic, strong) IDEWorkspaceWindow *ideWorkspaceWindow;
@property (nonatomic, strong) DVTSourceTextView *ideSourceTextView;
@property (nonatomic, strong) HPKWindowController *windowController;
@property (nonatomic, strong) WHUKVOController *documentKVO;

@end


@implementation HPKPluginMain {
    __block NSURL *_activeDocumentURL;
}

#pragma mark - 获取句柄， 创建插件实例
+ (void) pluginDidLoad:(NSBundle *)bundle {
    DVTSourceTextViewClass = objc_getClass("DVTSourceTextView");
    IDESourceCodeEditorClass = objc_getClass("IDESourceCodeEditor");
    IDEApplicationClass = objc_getClass("IDEApplication");
    IDEWorkspaceWindowControllerClass = objc_getClass("IDEWorkspaceWindowController");
    
    static dispatch_once_t pred;
    static HPKPluginMain *plugin = nil;
    
    dispatch_once(&pred, ^{
        plugin = [[HPKPluginMain alloc] init];
    });
}

#pragma mark - 插件生命周期
// 实例化插件，注册本地通知
- (id) init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:NSApp];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidUpdate:) name:NSWindowDidUpdateNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowWillClose:) name:NSWindowWillCloseNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextViewWillChangeNotifyingTextView:) name:NSTextViewWillChangeNotifyingTextViewNotification object:nil];

        
        _contentArrDic = [NSMutableDictionary dictionary];
        _originalTextDic = [NSMutableDictionary dictionary];
    }
    return self;
}

// 释放时注销通知
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 系统通知处理
// XCode 程序启动，创建hokey pokey菜单项
- (void) handleApplicationDidFinishLaunching:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:NSApp];
    [self createHokeyPokeyMenu];
}

// XCode窗口创建时，获取并保存XCode窗口
- (void) handleWindowDidUpdate:(NSNotification *)notification {
    id window = [notification object];
    if ([window isKindOfClass:[NSWindow class]] && [window isMainWindow]) {
        self.ideWorkspaceWindow = window;
    }
}

// XCode代码编辑TextView出现时， 获取并保存代码编辑TextView
- (void) handleTextViewWillChangeNotifyingTextView:(NSNotification *)note {
    id newView = note.userInfo[@"NSNewNotifyingTextView"];
    if ([newView isMemberOfClass:DVTSourceTextViewClass]) {
        self.ideSourceTextView = newView;
    }
}

// hokeypokey窗口点击关闭按钮时，销毁hokeypokey窗口
- (void) handleWindowWillClose:(NSNotification *)note {
    NSWindow *window = [note object];
    if (window == self.windowController.window) {
        [self.windowController.window orderOut:self];
        self.windowController = nil;
    }
}

// 从其它程序切换至XCode时，如hokeypokey窗口存在，将其置顶
- (void) handleWindowDidBecomeMainNotification:(NSNotification *)note {
    if (!self.windowController.window.visible) {
        [self.windowController.window orderFront:self];
    }
}

#pragma mark - UI菜单或视图创建
// 创建菜单
- (void) createHokeyPokeyMenu {
    NSMenu *hokeyPokeySubMenu = [self hokeyPokeySubMenu];
    [self createSubMItemsAtMenu:hokeyPokeySubMenu];
}

// 获取一级菜单
- (NSMenu *) hokeyPokeySubMenu {
    // 找到View所在菜单项
    NSMenuItem *viewMenuItem = nil;
    for (NSMenuItem *menuItem in [[NSApp mainMenu] itemArray]) {
        if ([menuItem.title isEqualToString:@"View"]) {
            viewMenuItem = menuItem;
            break;
        }
    }
    
    NSMenuItem *hokeyPokeyMenuItem = nil;
    // 检查hokey pokey 一级菜单是否存在
    for (NSMenuItem *menuItem in [viewMenuItem.submenu itemArray]) {
        if ([menuItem.title isEqualToString:@"Hocky Pokey"]) {
            hokeyPokeyMenuItem = menuItem;
            break;
        }
    }
    
    // 创建hokey pokey 一级菜单
    if (hokeyPokeyMenuItem == nil) {
        hokeyPokeyMenuItem = [[NSMenuItem alloc] initWithTitle:@"Hocky Pokey" action:NULL keyEquivalent:@""];
        [viewMenuItem.submenu addItem:hokeyPokeyMenuItem];
        hokeyPokeyMenuItem.enabled = YES;
        hokeyPokeyMenuItem.submenu = [[NSMenu alloc] initWithTitle:hokeyPokeyMenuItem.title];
    }
    return hokeyPokeyMenuItem.submenu;
}

// 创建二级菜单
- (void) createSubMItemsAtMenu:(NSMenu *) hokeyPokeySubMenu {
    NSMenuItem *hideItem = [[NSMenuItem alloc] initWithTitle:@"Hide/Show" action:@selector(hMenuItemTriggled:) keyEquivalent:@""];
    if ([HPKRequireKey4HideShow boolValue]) {
        [hideItem setKeyEquivalent:HPKKeyEquivalent4HideShow];
        [hideItem setKeyEquivalentModifierMask:HPKKeyMask4HideShow];
    }
    hideItem.target = self;
    [hokeyPokeySubMenu addItem:hideItem];
    
    NSMenuItem *makeItem = [[NSMenuItem alloc] initWithTitle:@"Make" action:@selector(mMenuItemTriggled:) keyEquivalent:@""];
    if ([HPKRequireKey4Make boolValue]) {
        [makeItem setKeyEquivalent:HPKKeyEquivalent4Make];
        [makeItem setKeyEquivalentModifierMask:HPKKeyMask4Make];
    }
    makeItem.target = self;
    [hokeyPokeySubMenu addItem:makeItem];
    
    NSMenuItem *resumeItem = [[NSMenuItem alloc] initWithTitle:@"Resume" action:@selector(rMenuItemTriggled:) keyEquivalent:@""];
    if ([HPKRequireKey4Resume boolValue]) {
        [resumeItem setKeyEquivalent:HPKKeyEquivalent4Resume];
        [resumeItem setKeyEquivalentModifierMask:HPKKeyMask4Resume];
    }
    resumeItem.target = self;
    [hokeyPokeySubMenu addItem:resumeItem];
}

// 创建hokeypokey窗口
- (void) createHokeyPokeyWindow {
    CGFloat leftMargin = 0;
    CGFloat topMargin = 40;
    self.windowController = [[HPKWindowController alloc] init];
    self.windowController.pluginMain = self;
    
    [self.windowController showWindow:self];
    CGRect frame = [(NSWindow *)self.ideWorkspaceWindow frame];
    frame.origin.x = CGRectGetMinX(frame) + leftMargin;
    frame.origin.y = CGRectGetMaxY(frame) - CGRectGetHeight(self.windowController.window.frame) - topMargin;
    CGPoint point = frame.origin;
    
    [self.windowController.window setFrameOrigin:point];
}

#pragma mark -子菜单逻辑处理

// 显示或隐藏hokeypokey窗口
- (void) hMenuItemTriggled:(NSMenuItem *)menuItem {
    if (self.windowController) {    // 如果hokeypokey工作窗口存在，则销毁
        [self.windowController.window orderOut:self];
        self.windowController = nil;
    } else{                         // 如果hokeypokey工作窗口存在，则创建，并且根据编辑器做更新
        [self createHokeyPokeyWindow];
        [self refreshHokeyPokeyWindowWithURL:[self activeDocumentURL]];
    }
}

// 编译当前工作窗口至hokeypokey系统
- (void) mMenuItemTriggled:(NSMenuItem *)menuItem {
    NSURL *fileKey = [self activeDocumentURL];
    NSString *realStr = [[self.ideSourceTextView.string mutableCopy] copy];
    if (!fileKey || ![realStr length]) {
        return;
    }
    
    NSArray<HPKSearchResult *> *searchResult1 = [realStr HPK_textResultsWithPairOpenString:HPKStartStringTag closeString:HPKEndStringTag];
    
    NSMutableDictionary<NSString *, NSMutableArray<HPKSearchResult *> *> *groupSerachResult = [NSMutableDictionary dictionary];
    
    [searchResult1 enumerateObjectsUsingBlock:^(HPKSearchResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = obj.title;
        if(![groupSerachResult objectForKey:title]) {
            [groupSerachResult setValue:[NSMutableArray array] forKey:title];
        }
        [groupSerachResult[title] addObject:obj];
    }];
    
    [self.originalTextDic setObject:realStr forKey:fileKey];
    
    if ([groupSerachResult count] > 0) {
        NSMutableArray *mArr = [NSMutableArray new];
        [groupSerachResult enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray * _Nonnull obj, BOOL * _Nonnull stop) {
            NSDictionary *dic = @{HPKFileURLKey: fileKey,  HPKTitleKey: key, HPKIsShownKey: @YES, HPKPockyResultsKey:obj};
            [mArr addObject:dic];

        }];
        [self.contentArrDic setObject:mArr forKey:fileKey];
    }
    [self refreshHokeyPokeyWindowWithURL:fileKey];
}

// 将当前文件由hokeypokey状态切换回正常状态，即恢复所有隐藏代码块
- (void) rMenuItemTriggled:(NSMenuItem *)menuItem {
    NSURL *fileKey = [self activeDocumentURL];
    if (!fileKey) {
        return;
    }
    [self.contentArrDic removeObjectForKey:fileKey];
    self.ideSourceTextView.string = [self.originalTextDic objectForKey:fileKey];
    [self.originalTextDic removeObjectForKey:fileKey];
    // 清除当前信息窗口数据源
    NSArrayController *arrayController = self.windowController.contentArray;
    [arrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet
                                                           indexSetWithIndexesInRange:NSMakeRange(0, [[arrayController arrangedObjects] count])]];
}

// 将当前编辑窗口内容写入对应文件
- (void) write2Document {
    NSArray *windowControllers = [IDEWorkspaceWindowControllerClass workspaceWindowControllers];
    
    id workspaceWindowController;
    
    if (windowControllers.count == 1) {
        workspaceWindowController = [windowControllers firstObject];
    } else {
        for (id windowController in windowControllers) {
            if ([windowController workspaceWindow] == self.ideWorkspaceWindow) {
                workspaceWindowController = windowController;
                break;
            }
        }
    }
    
    if (workspaceWindowController) {
        id editorArea = [workspaceWindowController editorArea] ;
        id document = [editorArea primaryEditorDocument];
        NSURL *url =  [document fileURL];
        [self.ideSourceTextView.string writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

// 返回当前编辑文档的地址
- ( NSURL *) activeDocumentURL {
    if (_activeDocumentURL) {
        return _activeDocumentURL;
    }
    
    NSArray *windowControllers = [IDEWorkspaceWindowControllerClass workspaceWindowControllers];
    
    id workspaceWindowController;
    
    if (windowControllers.count == 1) {
        workspaceWindowController = [windowControllers firstObject];
    } else {
        for (id windowController in windowControllers) {
            if ([windowController workspaceWindow] == self.ideWorkspaceWindow) {
                workspaceWindowController = windowController;
                break;
            }
        }
    }
    
    if (workspaceWindowController) {
        id editorArea = [workspaceWindowController editorArea] ;
        id document = [editorArea primaryEditorDocument];
        
        @weakify(self);
        if (!self.documentKVO) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidBecomeMainNotification:) name:NSWindowDidBecomeMainNotification object:nil];
            
            self.documentKVO = [WHUKVOController controllerWithObserver:self];
            [self.documentKVO observe:editorArea keyPath:@"primaryEditorDocument" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
                @strongify(self);
                id document = change[NSKeyValueChangeNewKey];
                if (document && document != [NSNull null]) {
                    NSURL *url =  [document fileURL];
                    _activeDocumentURL = url;
                    if (self.windowController) {
                        [self refreshHokeyPokeyWindowWithURL: url];
                    }
                }
                
            }];
        }
        
        NSURL *url =  [document fileURL];
        return url;
    } else {
        return nil;
    }
}

// 刷新hokeypokey数据库
- (void) refreshHokeyPokeyWindowWithURL:(NSURL *)url {
    self.windowController.windowTitle = [url lastPathComponent];

    // 清除hokey pokey窗口数据源
    NSArrayController *arrayController = self.windowController.contentArray;
    [arrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet
                                                           indexSetWithIndexesInRange:NSMakeRange(0, [[arrayController arrangedObjects] count])]];
    // 查找对应url的hokey pokey数据源
    if ([self.contentArrDic objectForKey:url]) {
        NSMutableArray *list4URL = [self.contentArrDic objectForKey:url];
        [self.windowController.contentArray addObjects:list4URL];
        [self.windowController.tableView deselectAll:self];
    }
}

// 根据用户对hokey pokey窗口的点击更新文档和显示
- (void) refreshFileContentAccording2Selection {
    NSURL *url = _activeDocumentURL;
    NSMutableArray *mArr = [self.contentArrDic objectForKey:url];

    if ([mArr count] == 0) {
        return;
    }
    
    NSMutableArray *excludeArr = [NSMutableArray array];
    NSString *realStr =[self.originalTextDic objectForKey:url];

    [mArr enumerateObjectsUsingBlock:^(NSMutableDictionary * obj, NSUInteger idx, BOOL * stop) {
        if (![obj[HPKIsShownKey] boolValue]) {
            [excludeArr addObjectsFromArray:obj[HPKPockyResultsKey]];
        }
    }];
    
    NSString *remainStr = [realStr HPK_stringBySubtractSearchResults:excludeArr];
    self.ideSourceTextView.string = remainStr;
    [self write2Document];

}

@end
