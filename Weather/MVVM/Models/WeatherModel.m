//
//  WeatherModel.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

+(BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

@end

@implementation WeatherStatusModel


+(JSONKeyMapper*)keyMapper
{
	return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
													   @"wDescription" : @"description"
													   }];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

@end

@implementation TemperatureModel

+ (JSONKeyMapper *)keyMapper
{
	return [JSONKeyMapper mapperForSnakeCase];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
	return YES;
}

@end
