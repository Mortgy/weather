//
//  WeatherDayTableViewCell.m
//  Weather
//
//  Created by mortgy on 15.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "WeatherDayTableViewCell.h"

@implementation WeatherDayTableViewCell
{
	
	__weak IBOutlet UILabel *dayLabel;
	__weak IBOutlet UIImageView *weatherImageView;
	__weak IBOutlet UILabel *minDegreeLabel;
	__weak IBOutlet UILabel *maxDegreeLabel;
	
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWeather:(WeatherModel *)weather {
	
	_weather = weather;
	
	if (self.isToday) {
		dayLabel.text = NSLocalizedString(@"tomorrow", nil);
	} else {
		dayLabel.text = [Constants dayFromDate:weather.dt];
	}
	
	weatherImageView.image = [UIImage imageNamed:[Constants weatherIconNameForName:((WeatherStatusModel *)[weather.weather firstObject]).icon]];
	minDegreeLabel.text = @(weather.main.tempMin.integerValue).stringValue;
	maxDegreeLabel.text = @(weather.main.tempMax.integerValue).stringValue;
}

@end
