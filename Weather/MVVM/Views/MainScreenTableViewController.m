//
//  MainScreenTableViewController.m
//  Weather
//
//  Created by mortgy on 13.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "MainScreenTableViewController.h"
#import "DashboardView.h"
#import "WeatherViewModel.h"
#import "WeatherDayTableViewCell.h"

@interface MainScreenTableViewController () <WeatherViewModelDelegate>

@end

@implementation MainScreenTableViewController
{
	IBOutlet DashboardView *dashboardView;
	WeatherViewModel *weatherViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	weatherViewModel = [[WeatherViewModel alloc] initWithForecastService:[ForecastService new]];
	weatherViewModel.delegate = self;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityUpdated) name:kNotificationCityUpdated object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(numberOfForecastDaysUpdated) name:kNotificationNumberOfForecastDaysChanged object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(temperatureUnitUpdated) name:kNotificationTemperatureUnitChanged object:nil];

	if (![WeatherManager sharedInstance].settings.selectedCity) {
		[self performSegueWithIdentifier:@"showSettings" sender:nil];
	} else {
		[weatherViewModel fetchForecast];
	}
}

- (void)forecastFetched:(ForecastModel *)forecast {
	
	for (WeatherModel *wModel in forecast.list) {
		NSLog(@"%@", [Constants dayFromDate:wModel.dt]);
	}
	
	[WeatherManager sharedInstance].settings.forecast = forecast;
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationForecastUpdated object:nil];

	[self.tableView reloadData];
}


- (void)cityUpdated {
	[weatherViewModel fetchForecast];
}

- (void)numberOfForecastDaysUpdated {
	[self.tableView reloadData];
}

- (void)temperatureUnitUpdated {
	[weatherViewModel fetchForecast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [WeatherManager sharedInstance].settings.forecast.list.count <= ([WeatherManager sharedInstance].settings.forecastDays.integerValue +1 ) ?
	([WeatherManager sharedInstance].settings.forecast.list.count - 1) :
	[WeatherManager sharedInstance].settings.forecastDays.integerValue;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellIdentifier = @"weatherCell";
	
	WeatherDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell) {
		[tableView registerNib:[UINib nibWithNibName:@"WeatherDayTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	}
	
	// Configure the cell...
	if (indexPath.row == 0) {
		cell.isToday = YES;
	}
	
	cell.weather = [WeatherManager sharedInstance].settings.forecast.list[indexPath.row + 1];
	return cell;
}

@end
