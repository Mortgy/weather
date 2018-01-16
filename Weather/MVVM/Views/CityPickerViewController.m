//
//  CityPickerViewController.m
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import "CityPickerViewController.h"

@interface CityPickerViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation CityPickerViewController
{
	IBOutlet UITextField *searchTextField;
	IBOutlet UITableView *tableView;
	
	NSMutableArray *filteredCities;
	NSArray <CityModel> *cities;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self performSelectorInBackground:@selector(createCitiesArray) withObject:nil];
	[searchTextField becomeFirstResponder];
}

- (void)createCitiesArray {
	NSError *error;
	cities = (NSArray <CityModel> *)[CityModel arrayOfModelsFromDictionaries:[self citiesFromFile] error:&error];
	
}

- (NSArray *)citiesFromFile {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"city.list" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (IBAction)textFieldDidChange:(UITextField *)textfield {
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];

	[self performSelector:@selector(performSearchActionWithString:) withObject:textfield.text afterDelay:1.0f];

}

- (void)performSearchActionWithString:(NSString *)string {
	NSPredicate *predicate = [NSPredicate predicateWithSearch:string searchTerm:@"name"];
	filteredCities = [[NSMutableArray alloc] initWithArray:[cities filteredArrayUsingPredicate:predicate]];
	[tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	CityModel *city = filteredCities[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", city.name, city.country];
	
	return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.delegate citySelected:filteredCities[indexPath.row]];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return filteredCities.count;
}


@end
