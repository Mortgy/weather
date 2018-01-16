//
//  WeatherManager.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager

+ (instancetype)sharedInstance
{
	static WeatherManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[WeatherManager alloc] init];
	});
	return sharedInstance;
}

- (void)initialize {
	
	NSError *error;
	
	if ([[NSUserDefaults standardUserDefaults] valueForKey:@"Settings"]) {
		
		NSDictionary *settings = [[NSUserDefaults standardUserDefaults] valueForKey:@"Settings"];
		NSLog(@"%@", settings);
		
		self.settings = [[WeatherManagerSettingsModel alloc] initWithDictionary:settings error:&error];
		if (error) {
			NSLog(@"%@", error.description);
		}
		
	} else {
		
		self.settings = [[WeatherManagerSettingsModel alloc] initWithDictionary:[self initialSettings] error:&error];
		if (error) {
			NSLog(@"%@", error.description);
		}
	}
}

- (NSDictionary *)initialSettings {
	return @{@"forecastDays" : @5,
			 @"temperatureUnite": [Constants temperatureUnites].firstObject.toDictionary};
}

- (void)saveSettings {
	[[NSUserDefaults standardUserDefaults] setObject:self.settings.toDictionary forKey:@"Settings"];
}

@end
