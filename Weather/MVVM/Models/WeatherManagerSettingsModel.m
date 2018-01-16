//
//  WeatherManagerSettingsModel.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "WeatherManagerSettingsModel.h"

@implementation WeatherManagerSettingsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

- (void)setSelectedCity:(CityModel *)selectedCity {
	_selectedCity = selectedCity;
	//save settings
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCityUpdated object:nil];
}

- (void)setTemperatureUnite:(TemperatureUnitModel *)temperatureUnite {
	_temperatureUnite = temperatureUnite;
	//save settings
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTemperatureUnitChanged object:nil];
}

- (void)setForecastDays:(NSNumber *)forecastDays {
	_forecastDays = forecastDays;
	//save settings
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNumberOfForecastDaysChanged object:nil];
	
}

@end
