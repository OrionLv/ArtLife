//
//  GobelDefine.h
//  PageItem
//
//  Created by lxb on 16/8/15.
//  Copyright © 2016年 huanshan. All rights reserved.
//

#ifndef GobelDefine_h
#define GobelDefine_h

//页面的宏
#define  W [UIScreen mainScreen].bounds.size.width / 320
#define  H [UIScreen mainScreen].bounds.size.height / 568

//获取设备屏幕的宽和高
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//定义颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//MASony
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS


//NSUserDefaults的存储
#define Fsave(obj, key)\
{\
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
}

//NSUserDefaults的读取
#define Fread(key)\
({\
[[NSUserDefaults standardUserDefaults] objectForKey:key];\
})

//作品宏
#define MyEnFontTwo @"Lobster 1.4"

#define MyChinFont @"FZLTZCHJW--GB1-0"

#define MyChinFontTwo @"FZLTXIHJW--GB1-0"

#define Blog @"http://www.jianshu.com/u/5d388cebf5e2"


// 每日列表
#define dailyList @"http://baobab.wandoujia.com/api/v1/feed.bak?num=%ld&date=%@"

#define MyLog(FORMAT, ...) fprintf(stderr,"%s: 第%d行\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#endif /* GobelDefine_h */
