//
//  CityModel.h
//  Weather
//
//  Created by mortgy on 12.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class LocationModel;

@protocol CityModel
@end

@interface CityModel : JSONModel

@property (nonatomic) NSNumber *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *country;
@property (nonatomic) LocationModel *coord;

@end

@interface LocationModel : JSONModel

@property (nonatomic) NSNumber *lon;
@property (nonatomic) NSNumber *lat;

@end
