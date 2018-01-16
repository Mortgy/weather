//
//  WeatherViewModel.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "WeatherViewModel.h"
#import "ForecastService.h"

@implementation WeatherViewModel
{
	ForecastService *forecastService;
}

- (instancetype)initWithForecastService:(ForecastService *)forecast {
	self = [super init];
	
	if (self) {
		forecastService = forecast;
	}
	
	return self;
}

- (void)fetchForecast {
	
	if (![WeatherManager sharedInstance].settings.selectedCity) {
		return;
	}
	
	[forecastService getForecastForCity:[WeatherManager sharedInstance].settings.selectedCity callback:^(ForecastModel *response, BOOL success) {
		[self.delegate forecastFetched:[self orderForecastModelList:response]];
	}];
}

- (ForecastModel *)orderForecastModelList:(ForecastModel *)forecast {
	
	NSMutableArray <WeatherModel> *list = (NSMutableArray <WeatherModel> *)[[NSMutableArray alloc] init];
	
	for (WeatherModel *weatherModel in forecast.list) {
		weatherModel.day = [Constants dayFromDate:weatherModel.dt];
		if (![[list valueForKey:@"day"] containsObject:[Constants dayFromDate:weatherModel.dt]] ) {
			[list addObject:weatherModel];
		}
	}
	
	forecast.list = list;
	return forecast;
}

@end

