// AFOwnerHTTPSessionManager.m
//
//  Created by lxb on 15/8/30.
//  Copyright (c) 2015年 lxb. All rights reserved.
//

#import "AFOwnerHTTPSessionManager.h"

//static NSString * const AFOwnerHTTPSessionManagerBaseURLString = @"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx?";

static NSString * const AFOwnerHTTPSessionManagerBaseURLString = @"http://api2.pianke.me/";


@implementation AFOwnerHTTPSessionManager

+ (instancetype)shareManager
{
    static AFOwnerHTTPSessionManager *ownerManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        ownerManager = [[AFOwnerHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AFOwnerHTTPSessionManagerBaseURLString]];
        ownerManager.responseSerializer = [AFJSONResponseSerializer serializer];
        ownerManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif", nil];
        ownerManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        //设置请求超时的时间
        ownerManager.requestSerializer.timeoutInterval = 30;
        
    });
    
    return ownerManager;
}

+ (void)getParameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    [[AFOwnerHTTPSessionManager shareManager] GET:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //block传递参数，类似代理传值
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //block传递参数，类似代理传值
        failure(task, error);
        
    }];
}

+ (void)postParameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    [[AFOwnerHTTPSessionManager shareManager] POST:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //block传递参数，类似代理传值
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //block传递参数，类似代理传值
        failure(task, error);
        
    }];
}


+ (void)uploadFileParameters:(id)parameters
   constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                progress:(void (^)(NSProgress *))progress
                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager POST:@"http://www.dcjyxwzx.cn/upload/change_avatar" parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * uploadProgress) {
        
        //block传递参数，类似代理传值
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask *task, id  responseObject) {
        
        //block传递参数，类似代理传值
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        
        //block传递参数，类似代理传值
        failure(task, error);
        
    }];
}

- (void)postURL:(NSString *)str
            Parameters:(id)parameters
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    [[AFOwnerHTTPSessionManager shareManager] POST:str parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //block传递参数，类似代理传值
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //block传递参数，类似代理传值
        failure(task, error);
        
    }];
}


- (void)getURL:(NSString *)str
           Parameters:(id)parameters
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure
{
    [[AFOwnerHTTPSessionManager shareManager] GET:str parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //block传递参数，类似代理传值
        success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //block传递参数，类似代理传值
        failure(task, error);
        
    }];
}

//懒加载生成下载管理对象
-(AFURLSessionManager *)urlSessionManager
{
    if (!_urlSessionManager)
    {
        _urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _urlSessionManager;
}

//外面指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
           filesavePath:(NSString *)path
               fileName:(NSString *)sourceName
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [self.urlSessionManager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        //block传递参数，类似代理传值
        downloadProgressBlock(downloadProgress);
        
    } destination:^NSURL * (NSURL *targetPath, NSURLResponse *response) {
        
        //返回文件的下载路径
        return [NSURL fileURLWithPath:[path stringByAppendingPathComponent:sourceName ]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError * error) {
        
        //block传递参数，类似代理传值
        completionHandler(response, filePath, error);
        
    }];
    
    //开始下载
    [downloadTask resume];
}


//默认指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [self.urlSessionManager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        //block传递参数，类似代理传值
        downloadProgressBlock(downloadProgress);
        
    } destination:^NSURL * (NSURL *targetPath, NSURLResponse *response) {
        
        //返回文件的下载路径
        NSString *filePath = [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), response.suggestedFilename];
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError * error) {
        
        //block传递参数，类似代理传值
        completionHandler(response, filePath, error);
        
    }];
    
    //开始下载
    [downloadTask resume];
}

//暂停当前正在下载的任务
- (void)suspendAllDownload
{
    if (_urlSessionManager)
    {
        for (NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task suspend];
        }
    }
}

//继续下载暂停过的任务
- (void)startAllDownload
{
    if (_urlSessionManager)
    {
        for (NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task resume];
        }
    }
}


//取消掉所有的当前下载任务
- (void)cancelAllDownloads
{
    if (_urlSessionManager)
    {
        for (NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task cancel];
        }
    }
}


@end
