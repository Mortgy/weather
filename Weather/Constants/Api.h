//
//  Api.h
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	GET,
	POST,
	PUT,
	DELETE,
	PATCH
} HttpMethod;

@interface Api : NSObject

+ (void)requestPath:(NSString *)path
			 params:(NSDictionary *)params
			 method:(HttpMethod)method
showLoadingAnimation:(BOOL)showLoadingAnimation
		   callback:(void (^)(id response, BOOL success))callback;

@end
