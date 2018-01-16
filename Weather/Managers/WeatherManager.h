//
//  WeatherManager.h
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

@property (nonatomic) WeatherManagerSettingsModel *settings;

+ (instancetype)sharedInstance;
- (void)initialize;
- (void)saveSettings;

@end
