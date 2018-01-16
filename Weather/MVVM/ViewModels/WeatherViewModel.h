//
//  WeatherViewModel.h
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForecastService.h"

@protocol WeatherViewModelDelegate

- (void)forecastFetched:(ForecastModel *)forecast;

@end

@interface WeatherViewModel : NSObject

@property (weak, nonatomic) id <WeatherViewModelDelegate> delegate;

- (instancetype)initWithForecastService:(ForecastService *)forecast;
- (void)fetchForecast;


@end
