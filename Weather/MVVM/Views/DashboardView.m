//
//  DashboardView.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "DashboardView.h"

@implementation DashboardView
{
	IBOutlet UILabel *cityLabel;
	IBOutlet UILabel *weatherLabel;
	IBOutlet UILabel *degreeLabel;
	IBOutlet UIImageView *weatherStatusImageView;
	IBOutlet UILabel *todayDateLabel;
	IBOutlet UILabel *lowTempLabel;
	IBOutlet UILabel *highTempLabel;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forecastUpdated) name:kNotificationForecastUpdated object:nil];
}


- (void)forecastUpdated {
	[self setupUI];
}

- (void)setupUI {
	
	WeatherModel *weatherModel = (WeatherModel *)[[WeatherManager sharedInstance].settings.forecast.list firstObject];
	WeatherStatusModel *weatherStatusModel = (WeatherStatusModel *)[weatherModel.weather firstObject];
	cityLabel.text = [WeatherManager sharedInstance].settings.selectedCity.name;
	weatherLabel.text = weatherStatusModel.wDescription;
	todayDateLabel.text = [Constants shortFormattedDateFromDate:weatherModel.dt];
	degreeLabel.text = [NSString stringWithFormat:@"%@º", @(weatherModel.main.temp.integerValue).stringValue];
	lowTempLabel.text = @(weatherModel.main.tempMin.integerValue).stringValue;
	highTempLabel.text = @(weatherModel.main.tempMax.integerValue).stringValue;
	NSString *iconName = [NSString stringWithFormat:@"%@_white", [Constants weatherIconNameForName:weatherStatusModel.icon]];
	weatherStatusImageView.image = [UIImage imageNamed:iconName];
}

@end
