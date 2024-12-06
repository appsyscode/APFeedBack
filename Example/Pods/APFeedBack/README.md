# APFeedBack

<!--[![CI Status](http://img.shields.io/travis/appsyscode/APFeedBack.svg?style=flat)](https://travis-ci.org/appsyscode/APFeedBack)-->
[![Version](https://img.shields.io/cocoapods/v/APFeedBack.svg?style=flat)](http://cocoapods.org/pods/APFeedBack)
[![License](https://img.shields.io/cocoapods/l/APFeedBack.svg?style=flat)](http://cocoapods.org/pods/APFeedBack)
[![Platform](https://img.shields.io/cocoapods/p/APFeedBack.svg?style=flat)](http://cocoapods.org/pods/APFeedBack)
[![language](https://img.shields.io/badge/Language-Objective%20C-blue.svg)](http://cocoapods.org/pods/APFeedBack)

![Screenshot0][img0]

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

APFeedBack is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

````ruby
pod "APFeedBack"
````

## Example
````objective-c
- (IBAction)feedback_Push:(id)sender;

{

APFeedTableViewController *fd = [[APFeedTableViewController alloc]init];
fd.developer_LogFile=NO;  //To turn feedbacklog.txt on, turn on developer_LogFile = YES
fd.mailHTML=YES;
[self.navigationController pushViewController:fd animated:YES];

}

- (IBAction)feedback_modal:(id)sender

{

APFeedTableViewController *fd = [[APFeedTableViewController alloc]init];
UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fd];
navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
[self presentViewController:navController animated:YES completion:nil];

}
````


````objective-c  
[[DeviceInfo deviceManager]logfilecreate];
````



[img0]:APFeedBack1.png
[img1]:APFeedBack2.png
[img2]:APFeedBack3.png


## Author

appsyscode, info@appsyscode.com

## License

APFeedBack is available under the MIT license. See the LICENSE file for more info.
