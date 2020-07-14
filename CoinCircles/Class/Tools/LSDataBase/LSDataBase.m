//
//  LSDataBase.m
//  CoinCircles
//
//  Created by Larson on 2020/7/11.
//  Copyright © 2020 zhongchuangkongjian. All rights reserved.
//

#import "LSDataBase.h"
#import <FMDB.h>
#import "ZXKJNewsModel.h"                       // 收藏
#import "ZXKJNewsDetailsModel.h"                // 资讯评论
#import "ZXKJCelebrityModel.h"                  // 名人榜
#import "ZXKJHeadlinesDetailsModel.h"           // 头条资讯

static LSDataBase *_db = nil;

@interface LSDataBase ()
/** 数据库*/
@property(nonatomic,strong) FMDatabase *dataBase;

@end

@implementation LSDataBase

#pragma mark - <share instancet>
+ (instancetype)sharedDataBase{
    if (!_db) {
        _db = [[LSDataBase alloc] init];
        [_db initDataBase];
    }
    return _db;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!_db) {
        _db = [super allocWithZone:zone];
    }
    return _db;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}



#pragma mark - <init dataBase>
-(void)initDataBase{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", ZCKJCollectKey]];

    // 实例化FMDataBase对象
    self.dataBase = [FMDatabase databaseWithPath:filePath];
}



#pragma mark - <API>
#pragma mark <collect>
// 保存收藏数据
- (void)insertCollectData:(ZXKJNewsModel *)model
{
    // 数据是否存在
    if ([self checkDataExistsWithTableName:ZCKJCollectKey IDName:@"ID" ID:model.ID]) {
        return;
    }
    
    [self.dataBase open];
    
    // 初始化数据表
    // 主键必须要设置，可以设置为ID
    NSString *tableName = [NSString stringWithFormat:@"create table if not exists '%@' ('ID' integer primary key autoincrement,coverUrl varchar(255), title varchar(255), source varchar(255), sourceUrl varchar(255), type varchar(255), content varchar(255));", ZCKJCollectKey];
    [self.dataBase executeUpdate:tableName];

    // 插入收藏数据
    NSString *insertInfo = [NSString stringWithFormat:@"insert into collect values('%@','%@','%@','%@','%@','%@','%@');", @(model.ID), model.coverUrl, model.title, model.source, model.sourceUrl, model.type, model.content];
    [self.dataBase executeUpdate:insertInfo];

    [self.dataBase close];
}

// 根据id删除收藏数据
- (void)delectCollectDataWithID:(NSInteger)ID
{
    [self.dataBase open];
    
    NSString *deleteStr = [NSString stringWithFormat:@"delete from %@ where %@ = %@", ZCKJCollectKey, @"ID", @(ID)];
    [self.dataBase executeUpdate:deleteStr];
    
    [self.dataBase close];
}

// 获取所有的收藏数据
- (NSMutableArray *)getAllCollectData
{
    [self.dataBase open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *allDataStr = [NSString stringWithFormat:@"select * from %@", ZCKJCollectKey];
    FMResultSet *res = [self.dataBase executeQuery:allDataStr];
    while (res.next) {
        ZXKJNewsModel *model = [[ZXKJNewsModel alloc] init];
        model.ID = [res longLongIntForColumn:@"ID"];
        model.coverUrl = [res stringForColumn:@"coverUrl"];
        model.title = [res stringForColumn:@"title"];
        model.source = [res stringForColumn:@"source"];
        model.sourceUrl = [res stringForColumn:@"sourceUrl"];
        model.type = [res stringForColumn:@"type"];
        model.content = [res stringForColumn:@"content"];
        [dataArray addObject:model];
    }
    
    [self.dataBase close];
    
    return dataArray;
}


#pragma mark <news comment>
// 保存资讯评论
- (void)insertNewsCommentData:(ZXKJNewsDetailsModel *)model
{
    if ([self checkDataExistsWithTableName:ZCKJNewsCommentKey time:model.time]) {
        return;
    }
    
    [self.dataBase open];
    
    NSString *tableName = [NSString stringWithFormat:@"create table if not exists '%@' ('time' integer primary key ,imageNamed varchar(255),nickname varchar(255), content varchar(255));", ZCKJNewsCommentKey];
    [self.dataBase executeUpdate:tableName];

    NSString *insertInfo = [NSString stringWithFormat:@"insert into %@ values('%@','%@','%@','%@');",ZCKJNewsCommentKey, model.time,model.imageNamed, model.nickname, model.content];
    [self.dataBase executeUpdate:insertInfo];

    [self.dataBase close];
}

// 根据id删除资讯评论
- (void)delectNewsCommentDataWithTime:(NSString *)time
{
    [self.dataBase open];
    
    NSString *deleteStr = [NSString stringWithFormat:@"delete from %@ where %@ = %@", ZCKJNewsCommentKey, @"time", time];
    [self.dataBase executeUpdate:deleteStr];
    
    [self.dataBase close];
}

// 获取所有的资讯评论数据
- (NSMutableArray *)getAllNewsCommentData
{
    [self.dataBase open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *allDataStr = [NSString stringWithFormat:@"select * from %@", ZCKJNewsCommentKey];
    FMResultSet *res = [self.dataBase executeQuery:allDataStr];
    while (res.next) {
        ZXKJNewsDetailsModel *model = [[ZXKJNewsDetailsModel alloc] init];
        model.imageNamed = [res stringForColumn:@"imageNamed"];
        model.nickname = [res stringForColumn:@"nickname"];
        model.content = [res stringForColumn:@"content"];
        model.time = [res stringForColumn:@"time"];
        [dataArray addObject:model];
    }
    
    [self.dataBase close];
    
    return dataArray;
}


#pragma mark <headline comment>
// 保存头条资讯评论
- (void)insertHeadlineCommentData:(ZXKJHeadlinesDetailsModel *)model
{
    if ([self checkDataExistsWithTableName:ZCKJHeadlineCommentKey IDName:@"ID" ID:model.ID]) {
        return;
    }
    
    [self.dataBase open];
    
    NSString *tableName = [NSString stringWithFormat:@"create table if not exists '%@' ('ID' integer primary key autoincrement,imageNamed varchar(255),nickname varchar(255), content varchar(255), time varchar(255));", ZCKJHeadlineCommentKey];
    [self.dataBase executeUpdate:tableName];

    NSString *insertInfo = [NSString stringWithFormat:@"insert into %@ values('%@','%@','%@','%@','%@');",ZCKJHeadlineCommentKey, @(model.ID),model.imageNamed, model.nickname, model.content, model.time];
    [self.dataBase executeUpdate:insertInfo];

    [self.dataBase close];
}

// 根据id删除头条资讯评论
- (void)delectHeadlineCommentDataWithID:(NSInteger)ID
{
    [self.dataBase open];
    
    NSString *deleteStr = [NSString stringWithFormat:@"delete from %@ where %@ = %@", ZCKJHeadlineCommentKey, @"ID", @(ID)];
    [self.dataBase executeUpdate:deleteStr];
    
    [self.dataBase close];
}

// 获取所有的头条资讯评论数据
- (NSMutableArray *)getAllHeadlineCommentData
{
    [self.dataBase open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *allDataStr = [NSString stringWithFormat:@"select * from %@", ZCKJHeadlineCommentKey];
    FMResultSet *res = [self.dataBase executeQuery:allDataStr];
    while (res.next) {
        ZXKJNewsDetailsModel *model = [[ZXKJNewsDetailsModel alloc] init];
        model.imageNamed = [res stringForColumn:@"imageNamed"];
        model.nickname = [res stringForColumn:@"nickname"];
        model.content = [res stringForColumn:@"content"];
        model.time = [res stringForColumn:@"time"];
        [dataArray addObject:model];
    }
    
    [self.dataBase close];
    
    return dataArray;
}



#pragma mark <celebrity>
// 保存名人榜数据
- (void)insertCelebrityData:(ZXKJCelebrityModel *)model
{
    if ([self checkDataExistsWithTableName:ZCKJCelebrityKey IDName:@"ID" ID:model.ID]) {
        NSLog(@"该数据存在");
        return;
    } else {
        NSLog(@"数据不存在");
    }
    
    [self.dataBase open];
    
    NSString *tableName = [NSString stringWithFormat:@"create table if not exists '%@' ('ID' integer primary key autoincrement,name varchar(255),image varchar(255), intro varchar(255), title varchar(255), content varchar(255));", ZCKJCelebrityKey];
    BOOL tab = [self.dataBase executeUpdate:tableName];
    if (tab) {
        NSLog(@"建表成功");
    } else {
        NSLog(@"建表失败");
    }

    NSString *insertInfo = [NSString stringWithFormat:@"insert into %@ values('%@','%@','%@','%@','%@','%@');",ZCKJCelebrityKey, @(model.ID), model.name, model.image, model.intro, model.title, model.content];
    BOOL res = [self.dataBase executeUpdate:insertInfo];
    if (res) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }

    [self.dataBase close];
}

// 根据id删除名人榜数据
- (void)delectCelebrityDataWithID:(NSInteger)ID
{
    [self.dataBase open];
    
    NSString *deleteStr = [NSString stringWithFormat:@"delete from %@ where %@ = %@", ZCKJCelebrityKey, @"ID", @(ID)];
    [self.dataBase executeUpdate:deleteStr];
    
    [self.dataBase close];
}

// 获取所有的名人榜数据
- (NSMutableArray *)getAllCelebrityData
{
    [self.dataBase open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *allDataStr = [NSString stringWithFormat:@"select * from %@", ZCKJCelebrityKey];
    FMResultSet *res = [self.dataBase executeQuery:allDataStr];
    while (res.next) {
        ZXKJCelebrityModel *model = ZXKJCelebrityModel.alloc.init;
        model.ID = [res intForColumn:@"ID"];
        model.name = [res stringForColumn:@"name"];
        model.title = [res stringForColumn:@"title"];
        model.intro = [res stringForColumn:@"intro"];
        model.image = [res stringForColumn:@"image"];
        model.content = [res stringForColumn:@"content"];
        
        [dataArray addObject:model];
    }
    
    [self.dataBase close];
    
    return dataArray;
}



#pragma mark - <general>
// 使用ID检测某个数据是否存在
- (BOOL)checkDataExistsWithTableName:(NSString *)tableName IDName:(NSString *)IDName ID:(NSInteger)ID
{
    [self.dataBase open];
    
    NSString *checkStr = [NSString stringWithFormat:@"select * from %@", tableName];
    FMResultSet *res = [self.dataBase executeQuery:checkStr];
    while ([res next]) {
        if (ID == [res longLongIntForColumn:@"ID"]) {
            return YES;
        }
    }
    [self.dataBase close];
    
    return NO;
}

// 使用时间戳检测某个数据是否存在
- (BOOL)checkDataExistsWithTableName:(NSString *)tableName time:(NSString *)time
{
    [self.dataBase open];
    
    NSString *checkStr = [NSString stringWithFormat:@"select * from %@", tableName];
    FMResultSet *res = [self.dataBase executeQuery:checkStr];
    while ([res next]) {
        if ([time isEqual:[res stringForColumn:@"time"]]) {
            return YES;
        }
    }
    [self.dataBase close];
    
    return NO;
}

@end
