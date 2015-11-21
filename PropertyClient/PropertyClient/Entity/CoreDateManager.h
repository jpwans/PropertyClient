//
//  CoreDateManager.h
//  PropertyOwnerClient
//
//  Created by MoPellet on 15/5/29.
//  Copyright (c) 2015年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MessageDB.h"
#define TableName @"MessageDB"
#import "FMDB.h"
@interface CoreDateManager : NSObject
@property (nonatomic, strong) FMDatabase *db;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//根据TYPE删除
-(void)deleteByType:(NSString *)type;

- (void)updateMessageByAdviceId:(NSString *)adviceId;

-(NSMutableArray *)msgGroupByType;
//更新
//- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end