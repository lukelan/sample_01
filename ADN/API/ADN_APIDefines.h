//
//  APIDefines.h
//  MovieTicket
//
//  Created by Phuong. Nguyen Minh on 12/7/12.
//  Copyright (c) 2012 Phuong. Nguyen Minh. All rights reserved.
//

#ifndef ADN_APIDefines_h
#define ADN_APIDefines_h

#pragma mark
#pragma mark server config
#define ROOT_SERVER ([NSString stringWithFormat:@"%@%@",BASE_URL_SERVER,MSERVICE_API])
#define MSERVICE_API @"api?"
#ifdef DEBUG
    #define BASE_URL_SERVER @"http://adn-dev.123.vn/"
    #define MAPP_KEY @"MAPP_1@3Phim1@3"
#else
    #define BASE_URL_SERVER @"hhttp://adn-dev.123.vn/"
    #define MAPP_KEY @"MAPP_1@3Phim_IOS_920"
#endif

#pragma mark
#pragma mark api links
#pragma mark
#define ADN_API_GET_CATEGORY @"%@version=1&do=category.gettopbar&channel=123phim"
#define ADN_API_GET_LIST_APP_BY_CATEGORY @"%@version=1&do=app.getListByCategory&channel=123phim&categoryId=%d&limit=30&offset=0&os=2"
#define ADN_API_GET_APP_DETAIL @"%@version=1&do=app.getDetail&os=2&packageName=%@&productId=%@"
#define ADN_API_GET_LIST_APP_BY_SEARCH_KEY @"%@do=app.search&version=1&os=2&refreshcache=1"
//version=1&do=app.getListByPackageName&channel=123phim&packageList=%@

#pragma mark
#pragma mark
#pragma mark api tags
#define ID_REQUEST_GET_CATEGORY    0
#define ID_REQUEST_GET_LIST_APP_BY_CATEGORY    1
#define ID_REQUEST_GET_APP_DETAIL    2
#define ID_REQUEST_GET_LIST_APP_BY_SEARCH_KEY  3

#endif