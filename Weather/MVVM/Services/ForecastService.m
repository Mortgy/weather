//
//  WeatherService.m
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "ForecastService.h"

@implementation ForecastService

- (void)getForecastForCity:(CityModel *)cityModel
				 callback:(void (^)(ForecastModel * response, BOOL success))callback {
	[Api requestPath:@"forecast" params:@{@"id": cityModel.id} method:GET showLoadingAnimation:NO callback:^(id response, BOOL success) {
		
		NSError *error;
		ForecastModel *weatherModel = [[ForecastModel alloc] initWithDictionary:response error:&error];
		
		if (error) {
			NSLog(@"%@", error.description);
			callback(weatherModel, NO);
		} else {
			callback(weatherModel, YES);
		}
	}];
}

@end
