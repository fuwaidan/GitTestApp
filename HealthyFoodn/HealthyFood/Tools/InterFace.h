//
//  InterFace.h
//  HealThyFood
//
//  Created by NXN on 16/4/17.
//  Copyright © 2016年 NiuXuan. All rights reserved.
//




//菜谱
#define SPECIAL_LIST_URL @"http://ibaby.ipadown.com/api/food/food.topic.list.php?p=%ld&pagesize=20&order=addtime"
#define SPECIAL_DETAIL_URL @"http://ibaby.ipadown.com/api/food/food.topic.detail.php?id=%@"


#define LIST_DETAIL_URL @"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=%@"

//热门
#define HOOT_LIST_URL @"http://api.izhangchu.com?methodName=HomeMore&page=%ld&size=6&type=1&user_id=0&version=4.01"

#define HOOT_DETAIL_URL @"http://api.izhangchu.com?dishes_id=%@&methodName=DishesView&user_id=0&version=4.01"


//新品

#define XINPIN_LIST_URL @"http://api.izhangchu.com/?methodName=HomeMore&page=%ld&size=6&type=2&user_id=0&version=4.01"

//
#define XINPIN_DETAIL_URL @"http://api.izhangchu.com?dishes_id=%@&methodName=DishesView&user_id=0&version=4.01"



//专题

#define ZHUANTI_LIST_URL @"http://api.izhangchu.com?methodName=TopicList&page=%ld&size=10&type=1&version=4.01"


#define ZHUANTI_DETAIL_URL @"http://api.izhangchu.com?methodName=TopicView&version=1.0&user_id=0&topic_id=%@"


#define ScreenBounds [[UIScreen mainScreen] bounds]


//UI当中的宏的宏名,一般以k开头
#define kUserSavePath [NSString stringWithFormat:@"%@/Documents/Users/userFile.plist",NSHomeDirectory()]

#define FENLEI_LIST_URL @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=bc474e37b7e6150f14359cf68c2976e0&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C0D9B6AF7-6977-4FAF-9B85-AB31D8755827%7CBFC9D217-1390-416D-9C9F-330DB989DEDF&format=json&loguid=&method=Index.index&nonce=1447036452&sessionid=1447036451&signmethod=md5&timestamp=1447036452&uuid=5386fffed2439140aab60d19608156a4&v=2&vc=42&vn=v5.3.0?cacheKey=Recipe.getCollectList_0_20&limit=20&offset=0&sign=&uid=&uuid=5386fffed2439140aab60d19608156a4"




#define ZAOCAN_URL @"http://cookbook-cn.appcookies.com/article/link_container/BreakfastCookBook.appcookies.com.json"




#define  ZAOCAN_LIST_URL @"http://cookbook-cn.appcookies.com/article/list_by_tag/%@.json?order=title"


#define ZAOCAN_DETAIL_URL @"http://cookbook-cn.appcookies.com/article/show/%@.html"
