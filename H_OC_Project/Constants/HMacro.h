//
//  HMacro.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/16.
//

#ifndef HMacro_h
#define HMacro_h

// 宏定义文件

/*
 ＃define  定义一个预处理宏
 ＃undef   取消宏的定义
 ＃if      编译预处理中的条件命令， 相当于C语法中的if语句
 ＃ifdef   判断某个宏是否被定义(＃define过)， 若已定义， 执行随后的语句
 ＃ifndef  与＃ifdef相反， 判断某个宏是否未被定义
 ＃elif    若＃if， ＃ifdef， ＃ifndef或前面的＃elif条件不满足， 则执行＃elif之后的语句， 相当于C语法中的else-if
 ＃else    与＃if， ＃ifdef， ＃ifndef对应， 若这些条件不满足， 则执行＃else之后的语句， 相当于C语法中的else
 ＃endif   ＃if， ＃ifdef， ＃ifndef这些条件命令的结束标志.
 defined   与＃if， ＃elif配合使用， 判断某个宏是否被定义
 */


/* 简写 */
#define NotiCenter [NSNotificationCenter defaultCenter]


/*
  布局是否为RTL(阿拉伯布局)
 */
#define H_isRTL [[[[NSBundle mainBundle] preferredLocalizations] firstObject] hasPrefix:@"ar"]
#define H_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


/*
 多语言读取
 kStorageAppLanguageKey：语言种类存储key
 */
#define H_Language(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kStorageAppLanguageKey]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localizable"]
#define H_LanguageWithArg(key, arg) [NSString stringWithFormat:KLanguage(key),arg]
#define H_LanguageWith2Arg(key, arg1, arg2) [NSString stringWithFormat:KLanguage(key),arg1, arg2]
#define H_LanguageWith3Arg(key, arg1, arg2, arg3) [NSString stringWithFormat:KLanguage(key),arg1, arg2, arg3]


/*
 文本对齐方式
 */
#define H_TextAlignmentLeading (H_isRTL ? NSTextAlignmentRight : NSTextAlignmentLeft)
#define H_TextAlignmentTrailing (H_isRTL ? NSTextAlignmentLeft : NSTextAlignmentRight)
#define H_TextAlignmentCenter NSTextAlignmentCenter
#define H_TextAlignmentJustified NSTextAlignmentJustified


/*
 Log
 */
#ifdef DEBUG
#define HLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];\
[dateFormatter setTimeZone:timeZone];\
[dateFormatter setDateFormat:@"HH:mm:ss.SSSSSSZ"];\
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"--TIME：%s【FILE：%s--LINE：%d】FUNCTION：%s\n >>：%s\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__PRETTY_FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
# define HLog(...);
#endif


/*
 Device Type
 */
#define H_isIPod [[UIDevice currentDevice].model containsString:@"iPod"]
#define H_isIPad [[UIDevice currentDevice].model containsString:@"iPad"]
#define H_isIPhone [[UIDevice currentDevice].model containsString:@"iPhone"]


/*
 强弱对象引用
 */
#define H_WeakSelf __weak typeof(self) weakSelf = self;
#define H_StrongSelf __strong __typeof(self)strongSelf = self;


/*
 线程操作
 */
#define H_DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(),mainQueueBlock);
#define H_GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define H_GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)


/*
 设计稿尺寸转换
 */
#define DESIGN_WIDTH 375.0
#define DESIGN_HEIGHT 667.0
#define UI(x) floor((x / (DESIGN_WIDTH / SCREEN_WIDTH)))
#define UISize(width, height) CGSizeMake(UI(width), UI(height))
#define UIRect(x,y,width,height) CGRectMake(UI(x), UI(y), UI(width), UI(height))
#define UIEdgeInsets(top, left, bottom, right) UIEdgeInsetsMake(UI(top), UI(left), UI(bottom), UI(right))
// 字体适配
#define FONT(size) (SCREEN_WIDTH < 321 ? size-1 : SCREEN_WIDTH > 375 ? size+1 : size)*1.0


/*
 屏幕相关
 */
// 是否为横屏
#define H_isLandscape (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
// 是否为刘海屏
#define H_isIPhoneXSeries ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0)
// 屏幕宽度
#define SCREEN_WIDTH (H_isLandscape ? [[UIScreen mainScreen ] bounds].size.height : [[UIScreen mainScreen ] bounds].size.width)
// 屏幕高度
#define SCREEN_HEIGHT (H_isLandscape ? [[UIScreen mainScreen ] bounds].size.width : [[UIScreen mainScreen ] bounds].size.height)
// 状态栏高度
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
// 底部安全区域高度
#define BOTTOM_SAFEAREA_HEIGHT ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom)
// 导航栏(navigationbar)高度
#define NAVIGATION_BAR_HEIGHT 44.0
// 导航高度(navigationbar+statusbar)
#define NAVIGATION_HEIGHT (NAVIGATION_BAR_HEIGHT + STATUSBAR_HEIGHT)
// 底部Tabbar高度
#define TABBAR_HEIGHT 49.0
// 底部Tabbar+安全区域高度
#define TABBAR_WITH_SAFEAREA_HEIGHT (TABBAR_HEIGHT + BOTTOM_SAFEAREA_HEIGHT)
// 除去导航部分页面高度(body高度)
#define BODY_HEIGHT (SCREEN_HEIGHT - NAVIGATION_HEIGHT)


/*
 代码执行时间
 */
#define H_StartTime NSDate *startTime = [NSDate date]
#define H_EndDuration -[startTime timeIntervalSinceNow]


/*
 沙盒相关
 */
// 获取沙盒主目录路径
#define H_SandBoxHomeDir  NSHomeDirectory()
// 获取Documents目录路径
#define H_SandBoxDocumentDir  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取Library的目录路径
#define H_SandBoxLibraryDir  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
// 获取Caches目录路径
#define H_SandBoxCachesDir  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
// 获取tmp目录路径
#define H_SandBoxTmpDir  NSTemporaryDirectory()


/*
 UIColor相关
 */
// clear背景颜色
#define H_UIClearColor [UIColor clearColor]
// 随机颜色
#define H_UIColorFromRandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
// rgba颜色
#define H_UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 16进制 颜色
#define H_UIColorFromHex(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


/*
 参数字符串化
 */
#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]



#endif /* HMacro_h */
