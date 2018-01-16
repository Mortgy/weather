//
//  WeatherModel.h
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class WeatherStatusModel;
@class TemperatureModel;

@protocol WeatherModel
@end

@protocol WeatherStatusModel
@end

@protocol TemperatureModel
@end

@interface WeatherModel : JSONModel

@property (nonatomic) NSNumber * dt;
@property (nonatomic) NSArray <WeatherStatusModel> * weather;
@property (nonatomic) TemperatureModel * main;
@property (nonatomic) NSString *day;
@end

@interface WeatherStatusModel : JSONModel

@property (nonatomic) NSNumber * id;
@property (nonatomic) NSString * main;
@property (nonatomic) NSString * wDescription;
@property (nonatomic) NSString * icon;

@end

@interface TemperatureModel : JSONModel

@property (nonatomic) NSNumber *temp;
@property (nonatomic) NSNumber *pressure;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *tempMin;
@property (nonatomic) NSNumber *tempMax;

@end
