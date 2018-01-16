//
//  TemperatureModel.h
//  Weather
//
//  Created by mortgy on 16.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TemperatureUnitModel
@end

@interface TemperatureUnitModel : JSONModel

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *code;

@end
