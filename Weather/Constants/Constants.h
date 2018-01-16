//
//  Constants.h
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemperatureUnitModel.h"

#define kNotificationCityUpdated @"SelectedCityUpdated"
#define kNotificationNumberOfForecastDaysChanged @"NumberOfForecastDaysChanged"
#define kNotificationTemperatureUnitChanged @"TemperatureUnitChanged"
#define kNotificationForecastUpdated @"ForecastUpdated"

@interface Constants : NSObject

+ (NSString *)appVersion;
+ (NSString *)shortFormattedDateFromDate:(NSNumber *)date;
+ (NSString *)dayFromDate:(NSNumber *)date;
+ (NSString *)weatherIconNameForName:(NSString *)icon;
+ (NSString *)currentLanguageCode;
+ (NSArray <TemperatureUnitModel *> *)temperatureUnites;

@end
