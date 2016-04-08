//
//  APFeedTableViewController.m
//  APFeedBack
//
//  Created by Parti Albert on 2016. 04. 04..
//  Copyright © 2016. Albert Parti. All rights reserved.
//

#import "APFeedTableViewController.h"
#import <MessageUI/MessageUI.h>



@interface APFeedTableViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>{
    
}




@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *Items1;
@property (nonatomic, strong) NSArray *Items2;
@property (nonatomic, strong) NSArray *Items3;
@property (nonatomic, strong) NSArray *Items3_1;

@property (strong, nonatomic)UISwitch * switchLog;

@property(nonatomic , retain) UIPickerView *topicPicker;
@property(nonatomic , retain) NSArray *pickerData;

@property NSString *selectedtopicstr;

@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (weak, nonatomic) UIImage *attachimage;

@property NSString *appVersionstr;
@property NSString *appBuildtr;
@property NSString *appNamestr;
@property NSString *systemstr;
@property NSString *devicestr;

@property (nonatomic, strong) NSArray *toRecipients;
@property (nonatomic, strong) NSArray *ccRecipients;
@property (nonatomic, strong) NSArray *bccRecipients;


@end

@implementation APFeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
    // self.mailHTML = YES;
    // self.developer_LogFile =YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(self.navigationController != nil){
        if( [self.navigationController viewControllers][0] == self){
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
        }else{
            
            self.navigationItem.leftBarButtonItem = nil;
        }
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    }
    
    self.navigationItem.leftBarButtonItem.tintColor=NavigationItem_leftButtonColor;
    [self loadUserDefaults];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self deviceinfo];
    
     self.toRecipients = [NSArray arrayWithObjects:mail_toRecipients,nil];
     self.ccRecipients = [NSArray arrayWithObjects:mail_ccRecipients,nil];
     self.bccRecipients = [NSArray arrayWithObjects:mail_bccRecipients,nil];

    
    self.navigationItem.title=NSLocalizedString(@"AP_FeedBack", nil);
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NavigationTitleColorFont};
    [self.navigationController.navigationBar setTintColor:NavigationBack_arrow_Color];
    self.navigationController.navigationBar.barTintColor=NavigationController_Color;
    self.tableView.backgroundColor=TableviewBackground_Color;
    
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"AP_Question", nil),NSLocalizedString(@"AP_Request", nil),NSLocalizedString(@"AP_Bug Report", nil),NSLocalizedString(@"AP_Other", nil),nil];
    self.pickerData = array;
    
    self.sections = [[NSArray alloc] initWithObjects:NSLocalizedString(@"AP_Question", nil),NSLocalizedString(@"AP_Attachments", nil),NSLocalizedString(@"AP_Device and Application info",nil), nil];
    
    self.Items1 = [NSArray arrayWithObjects:NSLocalizedString(@"AP_Topic", nil),NSLocalizedString(@"AP_", nil), nil];
    
    if (self.developer_LogFile)
    {
         self.Items2 = [NSArray arrayWithObjects:NSLocalizedString(@"AP_Attachment1", nil),NSLocalizedString(@"AP_Attachment2", nil), nil];
    }else
    {
         self.Items2 = [NSArray arrayWithObjects:NSLocalizedString(@"AP_Attachment1", nil), nil];
        
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setBool:NO forKey:Log_Key];
         [defaults synchronize];
    }
    
    self.Items3 = [NSArray arrayWithObjects:NSLocalizedString(@"AP_Device", @""),NSLocalizedString(@"AP_iOS", @""),NSLocalizedString(@"AP_AppNAMe", @""),NSLocalizedString(@"AP_Versions", @""),NSLocalizedString(@"AP_Build", @""), nil];
    self.Items3_1 = [NSArray arrayWithObjects:self.devicestr,self.systemstr,self.appNamestr,self.appVersionstr,self.appBuildtr, nil];
    
    self.selectedtopicstr=NSLocalizedString(@"AP_Question", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"AP_Mail", nil) style:UIBarButtonItemStylePlain target:self action:@selector(sendMail)];
    self.navigationItem.rightBarButtonItem.tintColor=NavigationItem_rightButtonColor;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = TableViewSeparator_Color;
   
}

-(void)deviceinfo
{
    self.devicestr = [[DeviceInfo deviceManager]platformString];
    self.appVersionstr = [[DeviceInfo deviceManager]infoVersion];
    self.appBuildtr = [[DeviceInfo deviceManager]appBuild];
    self.appNamestr = [[DeviceInfo deviceManager]appName];
    self.systemstr =  [[DeviceInfo deviceManager]systemversion];
    
    
}
// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Table view data source
// ---------------------------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return [self.Items1 count];
        
    }
    else if (section == 1) {
        return [self.Items2 count];
        
    }
    else if (section == 2) {
        return [self.Items3 count];
        
    }
    
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.sections objectAtIndex:section];
    
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.font = TableViewHeader_Font;
    header.textLabel.textColor = TableViewHeader_Color;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = SelectedColor;
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;
    self.tableView.rowHeight=cellRow;
    
    cell.backgroundColor=TableviewCell_Color;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row==0)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = [self.Items1 objectAtIndex:indexPath.row];
            cell.detailTextLabel.text= [NSString stringWithFormat:@"%@", self.selectedtopicstr];
            
            cell.textLabel.font = celltextLabelFont;
            cell.detailTextLabel.font = celldetailtextLabelFont;
            cell.textLabel.textColor = celltextLabelColor;
            cell.detailTextLabel.textColor = celldetailtextLabelColor;
           
        }
        else if (indexPath.row==1)
        {
            

            self.textV=[[UITextView alloc] initWithFrame:CGRectMake(5, 0, cell.frame.size.width, 100)];
            self.textV.font = [UIFont systemFontOfSize:15.0];
            self.textV.textColor=TableViewTextView_TextColor;
            self.textV.backgroundColor=TableViewTextViewBackground_Color;
            self.textV.tintColor=TableViewTextView_TintColor;
            self.textV.editable=YES;
            self.textV.scrollEnabled = NO;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.textV.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:FeedBackText_Key]];
            
            [cell.contentView addSubview:self.textV];
            self.tableView.rowHeight=cellRowTextView;
            
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    
        
    }
    else if (indexPath.section ==1) {
        
        if (indexPath.row==0)
        {
            self.tableView.rowHeight=cellRow2;
            
            NSUserDefaults *defaults7 = [NSUserDefaults standardUserDefaults];
            NSData *imageData1 = [defaults7 dataForKey:ImageMail_key];
            UIImage *attachImagemail = [UIImage imageWithData:imageData1];
            cell.imageView.image = attachImagemail;

            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.imageView.layer.cornerRadius = 10;
            cell.imageView.layer.borderWidth = 1.0f;
            cell.imageView.layer.borderColor = TableViewImageCellBorder_Color;
            cell.imageView.clipsToBounds = YES;
         
            
            cell.textLabel.text = self.title;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            cell.detailTextLabel.text = [self.Items2 objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.font = celltextLabelFont;
            cell.detailTextLabel.font = celldetailtextLabelFontIMAGE;
            cell.textLabel.textColor = celltextLabelColor;
            cell.detailTextLabel.textColor = celldetailtextLabelColor;
            
        }
        else if (indexPath.row==1)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.switchLog = [[UISwitch alloc] initWithFrame:CGRectZero];
            self.switchLog.tag = 400;
            self.switchLog.on = [defaults boolForKey:SwitchKey_Log];
            cell.accessoryView = self.switchLog;
            [self.switchLog setOnTintColor: SwitchColorOn];
            self.switchLog.tintColor=SwitchColorOff;
            [self.switchLog addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.textLabel.text = [self.Items2 objectAtIndex:indexPath.row];
            
            
            cell.textLabel.font = celltextLabelFont;
            cell.detailTextLabel.font = celldetailtextLabelFont;
            cell.textLabel.textColor = celltextLabelColor;
            cell.detailTextLabel.textColor = celldetailtextLabelColor;
    
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    }
    else if (indexPath.section ==2) {
        
        cell.textLabel.text = [self.Items3 objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.Items3_1 objectAtIndex:indexPath.row];
       
        cell.textLabel.font = celltextLabelFont;
        cell.detailTextLabel.font = celldetailtext_deviceLabelFont;
        cell.textLabel.textColor = celltextLabelColor;
        cell.detailTextLabel.textColor = celldetailtextLabelColor;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.Items1 objectAtIndex:indexPath.row]];
        
        
        if ([NSLocalizedString(@"AP_Topic", @"") isEqualToString:identifier]){
            
            [self topicalert];
        
        }
        
        
        
    }else if (indexPath.section ==1){
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.Items2 objectAtIndex:indexPath.row]];
        
        if ([NSLocalizedString(@"AP_Attachment1", @"") isEqualToString:identifier]){
            
           [self picture_attachment:indexPath];
            
        }

        
    }else if (indexPath.section ==2){
        
       
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)updateSwitchAtIndexPath:(UISwitch *)aswitch {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (aswitch.tag == 400) {
        
        if ([aswitch isOn]) {
            [defaults setBool:YES forKey:Log_Key];
        }else{
            [defaults setBool:NO forKey:Log_Key];
        }
        
    }
    
}

// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Topic alert select topic
// ---------------------------------------------------------------------------------------------------------------
- (void)topicalert
{
    
    NSString *title = NSLocalizedString(@"AP_Topic selection", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"AP_Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"AP_OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSInteger row = [self.topicPicker selectedRowInComponent:0];
        
        NSString *selected = [self.pickerData objectAtIndex:row];
        
        self.selectedtopicstr = [[NSString alloc] initWithFormat:@"%@", selected];
        
        [self performSelector:@selector(tbreload)];
    }];
    

    UIViewController *viewController = [[UIViewController alloc]init];
    [viewController.view setBackgroundColor:[UIColor clearColor]];
    
    self.topicPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 270 , 100)];
    [self.topicPicker setDataSource: self];
    [self.topicPicker setDelegate: self];

    
    [viewController.view addSubview:self.topicPicker];
    
    [self.topicPicker reloadAllComponents];
    
    [alertController setValue:viewController forKey:@"contentViewController"];
    
 
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    });
    
    

}
// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UIPickerView
// ---------------------------------------------------------------------------------------------------------------
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = PickerFont;
        pickerLabel.textColor=PickerColor;
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setText:[self.pickerData objectAtIndex:row]];
    
    return pickerLabel;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return[self.pickerData objectAtIndex:row];
}
// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark ScrollView Hide Keyboard
// ---------------------------------------------------------------------------------------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textV resignFirstResponder];
    
}

// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UIAlertControllerStyleActionSheet Style Alerts
// ---------------------------------------------------------------------------------------------------------------

- (void)picture_attachment:(NSIndexPath *)selectedPath  {
    
    
    
    NSString *cameratitle = NSLocalizedString(@"AP_Camera", nil);
    NSString *photolibrarytitle = NSLocalizedString(@"AP_PhotoLibrary", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"AP_Cancel", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
   
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:cameratitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if([self isCameraAvailable]) {
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self createImagePickerControllerWithSourceType:sourceType];
        
    }];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:photolibrarytitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
         UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
          [self createImagePickerControllerWithSourceType:sourceType];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:libraryAction];
    [alertController addAction:cameraAction];
    
   
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:selectedPath];
        popoverPresentationController.sourceRect = selectedCell.frame;
        popoverPresentationController.sourceView = self.view;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}


// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark UIImagePickerController
// ---------------------------------------------------------------------------------------------------------------

- (void)createImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = sourceType;
    controller.allowsEditing = YES;
    controller.delegate = self;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if ([UIPopoverPresentationController class]) {
            controller.modalPresentationStyle = UIModalPresentationFormSheet;
            
            UIPopoverPresentationController *presentationController = [controller popoverPresentationController];
            presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
            presentationController.sourceView = self.view;
            presentationController.sourceRect = self.view.frame;
            
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
            [self.popoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    } else {
        [self presentViewController:controller animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    self.attachimage = image;
 
    NSData *imageData = UIImageJPEGRepresentation(self.attachimage, 1);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imageData forKey:ImageMail_key];
    [defaults synchronize];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad && ![UIPopoverPresentationController class]) {
        [self.popoverController dismissPopoverAnimated:YES];
      
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self performSelector:@selector(tbreload) withObject:self afterDelay:1.0];
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad && ![UIPopoverPresentationController class]) {
        [self.popoverController dismissPopoverAnimated:YES];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)tbreload
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.textV.text forKey:FeedBackText_Key];
    [defaults synchronize];
    
    [self.tableView reloadData];
}

// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark Camera
// ---------------------------------------------------------------------------------------------------------------
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark MailComposer
// ---------------------------------------------------------------------------------------------------------------


- (NSData *)mailAttachment{
    
    NSUserDefaults *defaults7 = [NSUserDefaults standardUserDefaults];
    NSData *imageData1 = [defaults7 dataForKey:ImageMail_key];
    UIImage *attachImagemail = [UIImage imageWithData:imageData1];
    
    return UIImageJPEGRepresentation(attachImagemail, 0.5);
}

- (NSString *)mailBody
{
    NSString *content = self.textV.text;
    NSString *body;
    
    if (self.mailHTML) {
        body = [NSString stringWithFormat:@"<style>td {padding-right: 20px}</style>\
                <p>%@</p><br />\
                <table cellspacing=0 cellpadding=0>\
                <tr><td>Device:</td><td><b>%@</b></td></tr>\
                <tr><td>iOS:</td><td><b>%@</b></td></tr>\
                <tr><td>App:</td><td><b>%@</b></td></tr>\
                <tr><td>Version:</td><td><b>%@</b></td></tr>\
                <tr><td>Build:</td><td><b>%@</b></td></tr>\
                </table>",
                [content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"],
                self.devicestr,
                self.systemstr,
                self.appNamestr,
                self.appVersionstr,
                self.appBuildtr];
    } else {
        body = [NSString stringWithFormat:@"%@\n\n\nDevice: %@\niOS: %@\nApp: %@\nVersion: %@\nBuild: %@",
                content,
                self.devicestr,
                self.systemstr,
                self.appNamestr,
                self.appVersionstr,
                self.appBuildtr];
    }
    
   
    return body;
}
-(void)sendMail
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
    
     if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:self.toRecipients];
        [controller setCcRecipients:self.ccRecipients];
        [controller setBccRecipients:self.bccRecipients];
        [controller setSubject:[NSString stringWithFormat:@"%@:%@", self.appNamestr, self.selectedtopicstr]];
        [controller setMessageBody:self.mailBody isHTML:self.mailHTML];
        
         if (YES == [defaults boolForKey:Log_Key]){
        [controller addAttachmentData:[[DeviceInfo deviceManager]LogPathData] mimeType:@"text/plain" fileName:@"feedbacklog.txt"];   }
         
        if (self.mailAttachment && [self.mailAttachment length]>0) {
            [controller addAttachmentData:self.mailAttachment mimeType:MIME_TYPE_JPEG fileName:ATTACHMENT_FILENAME];
        }
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        if ([UIAlertController class]) {
            UIAlertController *alert= [UIAlertController alertControllerWithTitle:NSLocalizedString(@"AP_Error", nil)
                                                                          message:NSLocalizedString(@"AP_Mail no configuration", nil)
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *dismiss = [UIAlertAction actionWithTitle:NSLocalizedString(@"AP_Dismiss", nil)
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                            }];
            
            [alert addAction:dismiss];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AP_Error", nil)
                                                            message:NSLocalizedString(@"AP_Mail no configuration", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"AP_Dismiss", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}
// ---------------------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark MFMailComposeViewController delegate
// ---------------------------------------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    void (^completion)(void) = ^{
        if (self.presentingViewController.presentedViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    
    if (result == MFMailComposeResultCancelled) {
        completion = nil;
    } else if (result == MFMailComposeResultFailed && error) {
        if ([UIAlertController class]) {
            UIAlertController *alert= [UIAlertController alertControllerWithTitle:NSLocalizedString(@"AP_Error", nil)
                                                                          message:error.localizedDescription
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *dismiss = [UIAlertAction actionWithTitle:NSLocalizedString(@"AP_Dismiss", nil)
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                            }];
            
            [alert addAction:dismiss];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AP_Error", nil)
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"AP_Dismiss", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    [controller dismissViewControllerAnimated:YES completion:completion];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:ImageMail_key];
    [defaults setObject:@"" forKey:FeedBackText_Key];
    [defaults synchronize];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveUserDefaults];
}

- (void)cancelButtonTapped:(id)sender
{
    if(self.navigationController != nil){
        if( [self.navigationController viewControllers][0] == self){
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)saveUserDefaults {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:self.switchLog.isOn forKey:SwitchKey_Log];
    [defaults synchronize];
}

- (void)loadUserDefaults {
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.switchLog.on = [defaults boolForKey:SwitchKey_Log];
    
    [defaults setBool:self.developer_LogFile forKey:developer_Key];
   
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
