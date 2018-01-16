//
//  CityPickerViewController.h
//  Weather
//
//  Created by mortgy on 14.01.2018.
//  Copyright © 2018 Mortgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityPickerViewControllerDelegate

- (void)citySelected:(CityModel *)city;

@end

@interface CityPickerViewController : UIViewController

@property (weak, nonatomic) id <CityPickerViewControllerDelegate> delegate;

@end
