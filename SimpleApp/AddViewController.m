//
//  AddViewController.m
//  SimpleApp
//
//  Created by evhive on 14/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//

#import "AddViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (Tasks *)makeTask
{
    Tasks *task = [[Tasks alloc] initWithTitle:self.titleTextField.text task:self.textView.text dueDate:self.datePicker.date isCompleted:@"NO"];
    
    return task;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate didCancel];
}

- (IBAction)dismissKeyboard:(UIButton *)sender {
    [self.view endEditing:NO];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    [self.delegate didAddTask:[self makeTask]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end

