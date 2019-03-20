//
//  ViewController.m
//  SimpleApp
//
//  Created by evhive on 14/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//
#define TITLE @"title"
#define TASK @"task"
#define DUE_DATE @"dueDate"
#define IS_COMPLETED @"isCompleted"

#define OVERDUE_TASKS @"overdueTasks"
#define COMPLETED_TASKS @"completedTasks"
#define ARRAY_OF_DICTIONARIES @"arrayOfDictionaries"

#import "ViewController.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "Tasks.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *EditButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddButton;
@property (strong, nonatomic) NSMutableArray *overdueTasks;
@property (strong, nonatomic) NSMutableArray *completedTasks;
@property (strong, nonatomic) NSMutableArray *allTasks;
@property (strong, nonatomic) NSDate *today;
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.today = [NSDate date];
    [self loadTasks];
    
}

- (NSMutableArray *)allTasks
{
    if (!_allTasks) {
        _allTasks = [[NSMutableArray alloc] init];
    }
    
    return _allTasks;
}

- (NSMutableArray *)overdueTasks
{
    if (!_overdueTasks) {
        _overdueTasks = [[NSMutableArray alloc] init];
    }
    
    return _overdueTasks;
}

- (NSMutableArray *)completedTasks
{
    if (!_completedTasks) {
        _completedTasks = [[NSMutableArray alloc] init];
    }
    
    return _completedTasks;
}

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(Tasks *)task
{
    if ([self isOverdue:task.dueDate]) {
        [self.overdueTasks addObject:task];
    } else{
        [self.allTasks addObject:task];
    }
    [self saveTasks];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadTasks
{
    self.allTasks = nil;
    self.overdueTasks = nil;
    self.completedTasks = nil;
    
    NSMutableArray *loadedTasks = [[NSUserDefaults standardUserDefaults] objectForKey:ARRAY_OF_DICTIONARIES];
    NSMutableArray *loadedcompletedTasks = [[NSUserDefaults standardUserDefaults] objectForKey:COMPLETED_TASKS];
    NSMutableArray *loadOverdueTasks = [[NSUserDefaults standardUserDefaults] objectForKey:OVERDUE_TASKS];
    
    for (NSDictionary *dictionary in loadedTasks) {
        Tasks *task = [[Tasks alloc] initWithDictionary:dictionary];
        if ([task.isCompleted isEqualToString:@"YES"]) {
            [self.completedTasks addObject:task];
        }else if ([self isOverdue:task.dueDate]){
            [self.overdueTasks addObject:task];
        }else{
            [self.allTasks addObject:task];
        }
    }
    
    for (NSDictionary *dictionary in loadedcompletedTasks) {
        Tasks *task = [[Tasks alloc] initWithDictionary:dictionary];
        
        if ([task.isCompleted isEqualToString:@"YES"]) {
            [self.completedTasks addObject:task];
        }else if ([self isOverdue:task.dueDate]){
            [self.overdueTasks addObject:task];
        }else{
            [self.allTasks addObject:task];
        }    }
    
    for (NSDictionary *dictionary in loadOverdueTasks) {
        Tasks *task = [[Tasks alloc] initWithDictionary:dictionary];
        
        if ([task.isCompleted isEqualToString:@"YES"]) {
            [self.completedTasks addObject:task];
        }else if ([self isOverdue:task.dueDate]){
            [self.overdueTasks addObject:task];
        }else{
            [self.allTasks addObject:task];
        }
    }
}


- (void)didSaveTask:(Tasks *)task atIndexPath:(NSIndexPath *)indexPath
{
    //find sorce item location
    
    if (indexPath.section == 0) {
        [self.allTasks removeObjectAtIndex:indexPath.row];
        [self.completedTasks addObject:task];
    } else if (indexPath.section == 1){
        [self.overdueTasks removeObjectAtIndex:indexPath.row];
        [self.completedTasks addObject:task];
    } else{
        [self.completedTasks removeObjectAtIndex:indexPath.row];
        if ([self isOverdue:task.dueDate]) {
            [self.overdueTasks addObject:task];
        } else {
            [self.allTasks addObject:task];
        }
    }
    
    
    [self saveTasks];
    [self loadTasks];
    [self.tableView reloadData];
}

- (void)saveTasks
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    NSMutableArray *saveCompletedArray = [[NSMutableArray alloc] init];
    NSMutableArray *saveOverdueArray = [[NSMutableArray alloc] init];
    
    
    for (Tasks *task in self.allTasks) {
        NSDictionary *saveDictionary = [self dictionaryFromTask:task];
        NSLog(@"saving normal");
        [saveArray addObject:saveDictionary];
    }
    
    for (Tasks *task in self.completedTasks) {
        NSLog(@"saving completed");
        NSDictionary *saveDictionary = [self dictionaryFromTask:task];
        
        [saveCompletedArray addObject:saveDictionary];
    }
    
    for (Tasks *task in self.overdueTasks) {
        NSDictionary *saveDictionary = [self dictionaryFromTask:task];
        NSLog(@"saving overdue");
        
        [saveOverdueArray addObject:saveDictionary];
    }
    
    [userDefaults setObject:saveArray forKey:ARRAY_OF_DICTIONARIES];
    [userDefaults setObject:saveCompletedArray forKey:COMPLETED_TASKS];
    [userDefaults setObject:saveOverdueArray forKey:OVERDUE_TASKS];
    
    [userDefaults synchronize];
}

- (NSDictionary *)dictionaryFromTask:(Tasks *)task
{
    NSDictionary *dictionary = @{TITLE: task.title, TASK: task.task, DUE_DATE: task.dueDate, IS_COMPLETED:task.isCompleted};
    
    return dictionary;
}


- (BOOL)isOverdue:(NSDate *)dueDate
{
    self.today = [NSDate date];
    
    int intToday = [self.today timeIntervalSince1970];
    int intDueDate = [dueDate timeIntervalSince1970];
    
    if (intDueDate < intToday) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark - tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if ([self.overdueTasks count] > 0) {
            return @"Overdue tasks";
        }
    } else if (section == 2){
        if ([self.completedTasks count] > 0) {
            return @"completed tasks";
        }
    }else {
        return @"Current tasks";
    }
    return @"";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return [self.overdueTasks count];
    } else if (section == 2){
        return [self.completedTasks count];
    } else {
        return [self.allTasks count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Tasks *task;
    
    //get the task at indexPath
    if (indexPath.section == 0) {
        task = self.allTasks[indexPath.row];
    } else if (indexPath.section == 1 && [self.overdueTasks count] > 0){
        task = self.overdueTasks[indexPath.row];
    } else if (indexPath.section == 2 && [self.completedTasks count] > 0){
        task = self.completedTasks[indexPath.row];
    }
    
    //create dateformatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    NSString *dueDate = [dateFormatter stringFromDate:task.dueDate];
    
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = dueDate;
    
    //check the state of task
    if ([task.isCompleted isEqualToString:@"YES"]) {
        cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.5];
    }
    else if ([self isOverdue:task.dueDate]) {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.5];
    } else{
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //get the task, remove from array
    Tasks *task;
    if (indexPath.section == 1) {
        task = self.overdueTasks[indexPath.row];
        [self.overdueTasks removeObjectAtIndex:indexPath.row];
    } else if (indexPath.section == 2){
        task = self.completedTasks[indexPath.row];
        [self.completedTasks removeObjectAtIndex:indexPath.row];
    } else {
        task = self.allTasks[indexPath.row];
        [self.allTasks removeObjectAtIndex:indexPath.row];
    }
    
    //chage the completed state
    if ([task.isCompleted isEqualToString:@"YES"]){
        task.isCompleted = @"NO";
    } else{
        task.isCompleted = @"YES";
    }
    
    //add the task back
    //[self.allTasks insertObject:task atIndex:indexPath.row];
    
    if (indexPath.section == 1 || indexPath.section == 0){
        [self.completedTasks addObject:task];
    } else if ([self isOverdue:task.dueDate]){
        [self.overdueTasks addObject:task];
    } else {
        [self.allTasks addObject:task];
    }
    
    [self saveTasks];
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //delete here
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //check were the delete section is called from
        if (indexPath.section == 1) {
            [self.overdueTasks removeObjectAtIndex:indexPath.row];
        } else if (indexPath.section == 2){
            [self.completedTasks removeObjectAtIndex:indexPath.row];
        } else {
            [self.allTasks removeObjectAtIndex:indexPath.row];
        }
        
        [self saveTasks];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
     toIndexPath:(NSIndexPath *)toIndexPath {
    
    Tasks *fromTask;
    
    //remove from old location
    if (fromIndexPath.section == 0) {
        fromTask = self.allTasks[fromIndexPath.row];
        [self.allTasks removeObjectAtIndex:fromIndexPath.row];
    } else if (fromIndexPath.section == 1){
        fromTask = self.overdueTasks[fromIndexPath.row];
        [self.overdueTasks removeObjectAtIndex:fromIndexPath.row];
    } else{
        fromTask = self.completedTasks[fromIndexPath.row];
        [self.completedTasks removeObjectAtIndex:fromIndexPath.row];
    }
    
    //insert to new location
    if (toIndexPath.section == 0) {
        NSLog(@"moving to normal");
        fromTask.isCompleted = @"NO";
        [self.allTasks insertObject:fromTask atIndex:toIndexPath.row];
    } else if (toIndexPath.section == 1){
        fromTask.isCompleted = @"NO";
        NSLog(@"moving to overdue");
        [self.overdueTasks insertObject:fromTask atIndex:toIndexPath.row];
    } else{
        NSLog(@"moving to completed");
        fromTask.isCompleted = @"YES";
        [self.completedTasks insertObject:fromTask atIndex:toIndexPath.row];
    }
    
    //reload and save
    [self.tableView reloadData];
    [self saveTasks];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"to detailVC" sender:indexPath];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //check which segue is calling
    if ([segue.identifier isEqualToString:@"to addItemVC"]) {
        if ([segue.destinationViewController isKindOfClass:[AddItemViewController class]]) {

            AddItemViewController *addItemVC = segue.destinationViewController;
            addItemVC.delegate = self;

        }
    }
    else if ([segue.identifier isEqualToString:@"to detailVC"]){
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {

            DetailViewController *detailVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;

            Tasks *task;

            //find where the task is
            if (indexPath.section == 0) {
                task = self.allTasks[indexPath.row];
            } else if (indexPath.section == 1){
                task = self.overdueTasks[indexPath.row];
            } else{
                task = self.completedTasks[indexPath.row];
            }

            detailVC.delegate = self;
            detailVC.task = task;
            detailVC.taskIndexPath = indexPath;
        }
    }
}


- (IBAction)AddButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"to addItemVC" sender:sender];
}

- (IBAction)EditButtonPressed:(UIBarButtonItem *)sender {
    if (self.tableView.editing) {
        sender.title = @"Edit";
        [self.tableView setEditing:NO animated:YES];
    } else {
        sender.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
    }
}

@end
