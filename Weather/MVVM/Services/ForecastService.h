//
//  WeatherService.h
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Api.h"

@interface ForecastService : NSObject

- (void)getForecastForCity:(CityModel *)cityModel
				 callback:(void (^)(ForecastModel * response, BOOL success))callback;

@end
