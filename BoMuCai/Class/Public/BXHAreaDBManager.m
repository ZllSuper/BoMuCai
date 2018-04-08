//
//  BXHAreaDBManager.m
//  BoMuCai
//
//  Created by 步晓虎 on 2017/3/24.
//  Copyright © 2017年 woshishui. All rights reserved.
//

#import "BXHAreaDBManager.h"
#import <sqlite3.h>

@interface BXHAreaDBManager()
{
    CFMutableDictionaryRef _dbStmtCache;
    sqlite3 *_db;
}

@property (nonatomic, copy) NSString *dbPath;

@end

@implementation BXHAreaDBManager

+ (BXHAreaDBManager *)defaultManeger
{
    static dispatch_once_t onceToken;
    static BXHAreaDBManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[BXHAreaDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.dbPath = [[NSBundle mainBundle] pathForResource:@"BXHArea" ofType:@"db"];
        [self dbOpen];
        if (![self dbOpen])
        {
            [self dbClose];
            if (![self dbOpen])
            {
                [self dbClose];
                return nil;
            }
        }
    }
    return self;
}

- (BOOL)dbOpen
{
    if (_db) return YES;
    int result = sqlite3_open(self.dbPath.UTF8String, &_db);
    if (result == SQLITE_OK)
    {
        CFDictionaryKeyCallBacks keyCallbacks = kCFCopyStringDictionaryKeyCallBacks;
        CFDictionaryValueCallBacks valueCallbacks = {0};
        _dbStmtCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &keyCallbacks, &valueCallbacks);
        return YES;
    } else {
        _db = NULL;
        if (_dbStmtCache) CFRelease(_dbStmtCache);
        _dbStmtCache = NULL;
        [self dbClose];
        NSLog(@"%s line:%d sqlite open failed (%d).", __FUNCTION__, __LINE__, result);
        return NO;
    }
}

- (BOOL)dbClose
{
    if (!_db) return YES;
    
    int  result = 0;
    BOOL retry = NO;
    BOOL stmtFinalized = NO;
    
    if (_dbStmtCache) CFRelease(_dbStmtCache);
    _dbStmtCache = NULL;
    
    do {
        retry = NO;
        result = sqlite3_close(_db);
        if (result == SQLITE_BUSY || result == SQLITE_LOCKED)
        {
            if (!stmtFinalized)
            {
                stmtFinalized = YES;
                sqlite3_stmt *stmt;
                while ((stmt = sqlite3_next_stmt(_db, nil)) != 0)
                {
                    sqlite3_finalize(stmt);
                    retry = YES;
                }
            }
        }
        else if (result != SQLITE_OK)
        {
            NSLog(@"%s line:%d sqlite close failed (%d).", __FUNCTION__, __LINE__, result);
        }
    } while (retry);
    _db = NULL;
    return YES;
}

- (sqlite3_stmt *)dbPrepareStmt:(NSString *)sql
{
    if (![self dbOpen] || sql.length == 0 || !_dbStmtCache) return NULL;
    sqlite3_stmt *stmt = (sqlite3_stmt *)CFDictionaryGetValue(_dbStmtCache, (__bridge const void *)(sql));
    if (!stmt)
    {
        int result = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
        if (result != SQLITE_OK)
        {
            NSLog(@"%s line:%d sqlite stmt prepare error (%d): %s", __FUNCTION__, __LINE__, result, sqlite3_errmsg(_db));
            return NULL;
        }
        CFDictionarySetValue(_dbStmtCache, (__bridge const void *)(sql), stmt);
    }
    else
    {
        sqlite3_reset(stmt);
    }
    return stmt;
}


- (NSArray *)getProList
{
    NSString *sql = @"select area_id, area_name from t_sse_param_area where area_level = ?1;";
    sqlite3_stmt *stmt = [self dbPrepareStmt:sql];
    if (!stmt) return nil;
    sqlite3_bind_text(stmt, 1, [@"0" UTF8String], -1, NULL);
    
    NSMutableArray *items = [NSMutableArray new];
    do {
        int result = sqlite3_step(stmt);
        if (result == SQLITE_ROW)
        {
            char *areaId = (char *)sqlite3_column_text(stmt, 0);
            char *areaName = (char *)sqlite3_column_text(stmt, 1);

            BXHProModel *proModel = [[BXHProModel alloc] init];
            if(areaId) proModel.provId = [NSString stringWithUTF8String:areaId];
            if (areaName) proModel.provName = [NSString stringWithUTF8String:areaName];
            [items addObject:proModel];
        }
        else if (result == SQLITE_DONE)
        {
            break;
        }
        else
        {
            NSLog(@"%s line:%d sqlite query error (%d): %s", __FUNCTION__, __LINE__, result, sqlite3_errmsg(_db));
            break;
        }
    } while (1);
    return items;
}

- (NSArray *)getCityListWithProId:(NSString *)proId
{
    NSString *sql = @"select area_id, area_name from t_sse_param_area where parent_id = ?1;";
    sqlite3_stmt *stmt = [self dbPrepareStmt:sql];
    if (!stmt) return nil;
    sqlite3_bind_text(stmt, 1, proId.UTF8String, -1, NULL);
    NSMutableArray *items = [NSMutableArray new];
    do {
        int result = sqlite3_step(stmt);
        if (result == SQLITE_ROW)
        {
            char *areaId = (char *)sqlite3_column_text(stmt, 0);
            char *areaName = (char *)sqlite3_column_text(stmt, 1);
            
            BXHCityModel *cityModel = [[BXHCityModel alloc] init];
            if(areaId) cityModel.cityId = [NSString stringWithUTF8String:areaId];
            if (areaName) cityModel.cityName = [NSString stringWithUTF8String:areaName];
            [items addObject:cityModel];
        }
        else if (result == SQLITE_DONE)
        {
            break;
        }
        else
        {
            NSLog(@"%s line:%d sqlite query error (%d): %s", __FUNCTION__, __LINE__, result, sqlite3_errmsg(_db));
            break;
        }
    } while (1);
    return items;
}

- (NSArray *)getAreaListWithCityId:(NSString *)cityId
{
    NSString *sql = @"select area_id, area_name from t_sse_param_area where parent_id = ?1;";
    sqlite3_stmt *stmt = [self dbPrepareStmt:sql];
    if (!stmt) return nil;
    sqlite3_bind_text(stmt, 1, cityId.UTF8String, -1, NULL);
    NSMutableArray *items = [NSMutableArray new];
    do {
        int result = sqlite3_step(stmt);
        if (result == SQLITE_ROW)
        {
            char *areaId = (char *)sqlite3_column_text(stmt, 0);
            char *areaName = (char *)sqlite3_column_text(stmt, 1);
            
            BXHAreaModel *areaModel = [[BXHAreaModel alloc] init];
            if(areaId) areaModel.areaId = [NSString stringWithUTF8String:areaId];
            if (areaName) areaModel.areaName = [NSString stringWithUTF8String:areaName];
            [items addObject:areaModel];
        }
        else if (result == SQLITE_DONE)
        {
            break;
        }
        else
        {
            NSLog(@"%s line:%d sqlite query error (%d): %s", __FUNCTION__, __LINE__, result, sqlite3_errmsg(_db));
            break;
        }
    } while (1);
    return items;
}

@end
