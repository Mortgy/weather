//
//  WeatherDayTableViewCell.h
//  Weather
//
//  Created by mortgy on 15.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDayTableViewCell : UITableViewCell

@property (nonatomic) BOOL isToday;
@property (nonatomic) WeatherModel *weather;

@end
