//
//  Api.m
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "Api.h"
#import <AFNetworking/AFNetworking.h>

#define kOpenWeatherApi @"28bebe2bc6d070b23254c35c096417c2"
#define kBaseUrl @"https://api.openweathermap.org/data/2.5/"

@implementation Api

+ (void)requestPath:(NSString *)path params:(NSMutableDictionary *)params method:(HttpMethod)method showLoadingAnimation:(BOOL)showLoadingAnimation callback:(void (^)(id response, BOOL success))callback
{
	
	if (!params) {
		params = [[NSMutableDictionary alloc] init];
	}
	params = [params mutableCopy];
	[params setObject:[WeatherManager sharedInstance].settings.temperatureUnite.code forKey:@"units"];
	[params setObject:[Constants currentLanguageCode] forKey:@"lang"];

	[params setObject:kOpenWeatherApi forKey:@"APPID"];
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
	
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[manager.requestSerializer setTimeoutInterval:30];
	manager.securityPolicy.allowInvalidCertificates = NO;
	manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
		
	path = [path stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
	
	void (^success)(NSURLSessionDataTask *operation, id responseObject) = ^(NSURLSessionDataTask *operation, id responseObject)
	{
		callback(responseObject, YES);
		
	};
	
	void (^fail)(NSURLSessionDataTask *operation, NSError *error) = ^(NSURLSessionDataTask *operation, NSError *error)
	{
		NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
		if (errorData) {
			NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
			
			callback(serializedData, NO);

			
		}
	};
	
	switch (method) {
		case GET:
			[manager GET:[kBaseUrl stringByAppendingString:path] parameters:params progress:nil success:success failure:fail];
			break;
		case POST:
			[manager POST:[kBaseUrl stringByAppendingString:path] parameters:params progress:nil success:success failure:fail];
			break;
		case PUT:
			[manager PUT:[kBaseUrl stringByAppendingString:path] parameters:params success:success failure:fail];
			break;
		case DELETE:
			[manager DELETE:[kBaseUrl stringByAppendingString:path] parameters:params success:success failure:fail];
			break;
		case PATCH:
			[manager PATCH:[kBaseUrl stringByAppendingString:path] parameters:params success:success failure:fail];
			break;
			
		default:
			break;
	}
}

@end
