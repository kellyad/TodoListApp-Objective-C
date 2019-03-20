//
//  Tasks.h
//  SimpleApp
//
//  Created by evhive on 18/03/19.
//  Copyright © 2019 Coco. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Tasks : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *task;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, strong) NSString *isCompleted;

- (id)initWithTitle:(NSString *)title task:(NSString *)task dueDate:(NSDate *)dueDate isCompleted:(NSString *)isCompleted;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
