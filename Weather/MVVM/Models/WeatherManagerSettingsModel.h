//
//  WeatherManagerSettingsModel.h
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Constants.h"

@interface WeatherManagerSettingsModel : JSONModel

@property (nonatomic) CityModel *selectedCity;
@property (nonatomic) ForecastModel *forecast;

@property (nonatomic) TemperatureUnitModel *temperatureUnite;
@property (nonatomic) NSNumber *forecastDays;

@end

