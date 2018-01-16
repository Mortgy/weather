//
//  SettingsTableViewController.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingTableViewCell.h"
#import "CityPickerViewController.h"
#import <ActionSheetPicker.h>

@interface SettingsViewController () <CityPickerViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) IBOutlet UILabel *appVersionLabel;

@end

@implementation SettingsViewController
{
	
}
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.appVersionLabel.text = [NSString stringWithFormat:@"v%@", [Constants appVersion]];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)backAction:(id)sender {
	
	if (![WeatherManager sharedInstance].settings.selectedCity) {
		NSLog(@"Please Select a city!");
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"", nil) message:NSLocalizedString(@"select_a_city", nil) preferredStyle:UIAlertControllerStyleAlert];
		[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
		[self presentViewController:alertController animated:YES completion:nil];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
	
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
	return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = @"settingCell";
	
	SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell) {
		[tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	}
	
    // Configure the cell...
	cell.titleLabel.text = @[NSLocalizedString(@"location", nil),
							 NSLocalizedString(@"temperature_unites", nil),
							 NSLocalizedString(@"forecast_days", nil)][indexPath.row];
	cell.valueLabel.text = @[[self selectedCity],
							 [WeatherManager sharedInstance].settings.temperatureUnite.name,
							 [WeatherManager sharedInstance].settings.forecastDays.stringValue][indexPath.row];
    return cell;
}

- (NSString *)selectedCity {
	return [WeatherManager sharedInstance].settings.selectedCity.name ?
	[NSString stringWithFormat:@"%@, %@", [WeatherManager sharedInstance].settings.selectedCity.name, [WeatherManager sharedInstance].settings.selectedCity.country] :
	@"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case 0:
		{
			[self showCityPicker];
		}
			break;
		case 1:
		{
			[self showTemperatureUnitePickerForIndexpath:indexPath];
		}
			break;
		case 2:
		{
			[self showForecastDaysPickerForIndexpath:indexPath];
		}
			break;
		default:
			break;
	}
}

#pragma mark - CityPickerViewControllerDelegate
- (void)citySelected:(CityModel *)city {
	[WeatherManager sharedInstance].settings.selectedCity = city;
	[[WeatherManager sharedInstance] saveSettings];
	[self.tableView reloadData];
}

#pragma mark - pickers

- (void)showCityPicker {
	CityPickerViewController *cityPickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CityPickerViewController"];
	cityPickerViewController.delegate = self;
	[self presentViewController:cityPickerViewController animated:YES completion:nil];
}

- (void)showTemperatureUnitePickerForIndexpath:(NSIndexPath *)indexPath {
	ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc] initWithTitle:NSLocalizedString(@"temperature_unite", @"") rows:[[Constants temperatureUnites] valueForKey:@"name"] initialSelection:[self selectedTemperatureIndex] doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
		
		[WeatherManager sharedInstance].settings.temperatureUnite = [Constants temperatureUnites][selectedIndex];
		[[WeatherManager sharedInstance] saveSettings];
		[self.tableView reloadData];
		
	} cancelBlock:nil origin:[self.tableView cellForRowAtIndexPath:indexPath]];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
	doneButton.title = NSLocalizedString(@"ok", @"");
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] init];
	cancelButton.title = NSLocalizedString(@"cancel", @"");
	
	[picker setDoneButton:doneButton];
	[picker setCancelButton:cancelButton];
	picker.tapDismissAction = TapActionCancel;
	[picker showActionSheetPicker];
}

- (void)showForecastDaysPickerForIndexpath:(NSIndexPath *)indexPath{
	ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc] initWithTitle:NSLocalizedString(@"forecast_days", @"") rows:@[@1, @2, @3, @4, @5] initialSelection:[WeatherManager sharedInstance].settings.forecastDays.integerValue-1 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
		
		[WeatherManager sharedInstance].settings.forecastDays = @(selectedIndex+1);
		[[WeatherManager sharedInstance] saveSettings];
		[self.tableView reloadData];
		
	} cancelBlock:nil origin:[self.tableView cellForRowAtIndexPath:indexPath]];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
	doneButton.title = NSLocalizedString(@"ok", @"");
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] init];
	cancelButton.title = NSLocalizedString(@"cancel", @"");
	
	[picker setDoneButton:doneButton];
	[picker setCancelButton:cancelButton];
	picker.tapDismissAction = TapActionCancel;
	[picker showActionSheetPicker];
}

- (NSInteger)selectedTemperatureIndex {
	NSInteger indexOfSelectedTemperature = [[[Constants temperatureUnites] valueForKey:@"code"] indexOfObject:[WeatherManager sharedInstance].settings.temperatureUnite.code];
	return indexOfSelectedTemperature;
}

@end
