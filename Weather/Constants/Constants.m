//
//  Constants.m
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "Constants.h"
#import "AppDelegate.h"

@implementation Constants

+ (NSString *)appVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)shortFormattedDateFromDate:(NSNumber *)date {
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setLocale:[NSLocale localeWithLocaleIdentifier:[Constants currentLanguageCode]]];
	[df setDateFormat:@"E d MMM"];
	return [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:[date longLongValue]]];
}

+ (NSString *)dayFromDate:(NSNumber *)date {
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setLocale:[NSLocale localeWithLocaleIdentifier:[Constants currentLanguageCode]]];
	[df setDateFormat:@"EEEE"];
	return [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:[date longLongValue]]];
}

+ (NSString *)weatherIconNameForName:(NSString *)icon {
	if ([icon isEqualToString:@"01d"] || [icon isEqualToString:@"01n"] ||
		[icon isEqualToString:@"02d"] || [icon isEqualToString:@"02n"] ) {
		return @"ic_sunny_clear";
	}
	
	if ([icon isEqualToString:@"03d"] || [icon isEqualToString:@"03n"] ||
		[icon isEqualToString:@"04d"] || [icon isEqualToString:@"04n"] ) {
		return @"ic_clouds";
	}
	
	if ([icon isEqualToString:@"09d"] || [icon isEqualToString:@"09n"] ||
		[icon isEqualToString:@"10d"] || [icon isEqualToString:@"10n"] ) {
		return @"ic_rain";
	}
	
	if ([icon isEqualToString:@"11d"] || [icon isEqualToString:@"11n"] ) {
		return @"ic_thunder_storm";
	}
	
	if ([icon isEqualToString:@"13d"] || [icon isEqualToString:@"13n"] ) {
		return @"ic_snow";
	}
	
	return @"";
}

+ (NSString *)currentLanguageCode {
	
	NSString * language = [[NSLocale preferredLanguages] firstObject];
	NSString * languageCode = [[NSLocale componentsFromLocaleIdentifier:language] objectForKey:@"kCFLocaleLanguageCodeKey"];
	
	if ([@[@"en", @"nl", @"pt"] containsObject:languageCode]) {
		return languageCode;
	} else {
		return @"en";
	}
}

+ (NSArray <TemperatureUnitModel *> *)temperatureUnites {
	
	NSError *error;
	NSArray *unites = @[@{@"name": @"Celsius", @"code": @"metric"},
					   @{@"name": @"Fahrenheit", @"code": @"imperial"}];
	
	return [[TemperatureUnitModel arrayOfModelsFromDictionaries:unites error:&error] copy];
	
}

@end
