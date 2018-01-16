//
//  WeatherModel.h
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ForecastModel
@end

@interface ForecastModel : JSONModel

@property (nonatomic) NSString *cod;
@property (nonatomic) NSNumber *message;
@property (nonatomic) NSNumber *cnt;
@property (nonatomic) CityModel *city;
@property (nonatomic) NSArray <WeatherModel> *list;

@end
