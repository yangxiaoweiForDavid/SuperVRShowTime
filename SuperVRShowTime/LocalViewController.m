//
//  LocalViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/8/25.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "LocalViewController.h"
#import "LocalVideoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "BackUpAndRestoreViewController.h"
#import "ItunesViewController.h"

@interface LocalViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger segmentIndex;
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *itunesCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *wifiCell;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.navigationItem.title = @"播本地";
    self.itunesCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.wifiCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSetDataStly) name:WifiInputNotifaction object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    segmentIndex = 0;
    dataArray = [[NSMutableArray alloc] init];
    _groups = [[NSMutableArray alloc] init];
    [self doSetDataStly];
}

- (IBAction)clickSegment:(UISegmentedControl *)sender {
    segmentIndex = sender.selectedSegmentIndex;
    [self doSetDataStly];
}

-(void)doSetDataStly{
    [dataArray removeAllObjects];
    [self.myTableView reloadData];
    if (segmentIndex == 0) {
        [self getLocalVideo];
    }else{
        [self getSystemVideo];
    }
}

-(void)getLocalVideo{
    [[ToolOprationer sharedInstance] showRefreshIndactor];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *childerFiles=[fileManager subpathsAtPath:SuperVR_DocumentPath];
    for (NSString *fileName in childerFiles) {
        if ([fileName containsString:@".sqlite"]) {
            continue;
        }
        NSString *url = [SuperVR_DocumentPath stringByAppendingPathComponent:fileName];
        UIImage *image = [self getImage:url];
        if (!image) {
            image = [UIImage imageNamed:@""];
        }
        NSString *time = [self getTimeStr:[self durationWithVideo:url]];
        NSString *tittle = fileName;
        float fileMB = [FileManagerUtils fileSizeAtPath:url];
        fileMB = fileMB<0.01?0.01:fileMB;
        NSString *size = [NSString stringWithFormat:@"%0.2fM", fileMB];
        LocalVideoData *data = [LocalVideoData initWithDic:@{@"url":url,@"image":image,@"tittle":tittle,@"time":time,@"size":size,@"type":LocalAppVideo}];
        [dataArray addObject:data];
    }
    [self.myTableView reloadData];
    [[ToolOprationer sharedInstance] hideRefreshIndactor];
}

- (NSUInteger)durationWithVideo:(NSString *)videoURL{
    NSURL *videoUrl = [NSURL fileURLWithPath:videoURL];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts];
    NSUInteger second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale;
    return second;
}

-(UIImage *)getImage:(NSString *)videoURL{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

- (ALAssetsLibrary *)assetsLibrary{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
    unsigned int unitFlags =
    NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit |
    NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    return [calendar components:unitFlags
                       fromDate:date1
                         toDate:date2
                        options:0];
}

- (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval{
    NSDateComponents *components = [self componetsWithTimeInterval:timeInterval];
    NSInteger roundedSeconds = lround(timeInterval - (components.hour * 60) - (components.minute * 60 * 60));
    if (components.hour > 0){
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", (long)components.hour, (long)components.minute, (long)roundedSeconds];
    }else{
        return [NSString stringWithFormat:@"%ld:%02ld", (long)components.minute, (long)roundedSeconds];
    }
}

-(NSString *)getTimeStr:(NSInteger)seconds{
    NSInteger hour = seconds/3600;
    NSInteger minu = (seconds%3600)/60;
    NSInteger sec = seconds%60;
    if (hour > 0){
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", hour, minu, sec];
    }else{
        return [NSString stringWithFormat:@"%ld:%02ld", minu, sec];
    }
}

-(void)getSystemVideo{
    [self.groups removeAllObjects];
    [[ToolOprationer sharedInstance] showRefreshIndactor];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allVideos];
            [group setAssetsFilter:onlyPhotosFilter];
            if ([group numberOfAssets] > 0){
                [self.groups addObject:group];
            }
        }else{
            NSMutableArray *dataArray2 = [[NSMutableArray alloc] init];
            if (self.groups.count > 0) {
                [self.groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    BOOL isLast = NO;
                    if (idx == self.groups.count-1) {
                        isLast = YES;
                    }
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        if (result){
                            [dataArray2 addObject:result];
                        }else{
                            if (isLast) {
                                for (ALAsset *result in dataArray2) {
                                    NSString *time = [self getTimeStr:[[result valueForProperty:ALAssetPropertyDuration] integerValue]];
                                    UIImage *image = [UIImage imageWithCGImage:result.thumbnail];
                                    ALAssetRepresentation *representation = [result defaultRepresentation];
                                    NSString *tittle = representation.filename;
                                    NSString *url = representation.url.absoluteString;
                                    float fileMB = (float)([representation size]/(1024*1024));
                                    fileMB = fileMB<0.01?0.01:fileMB;
                                    NSString *size = [NSString stringWithFormat:@"%0.2fM", fileMB];
                                    LocalVideoData *data = [LocalVideoData initWithDic:@{@"url":url,@"image":image,@"tittle":tittle,@"time":time,@"size":size,@"type":LocalSystemVideo}];
                                    [dataArray addObject:data];
                                }
                                [self.myTableView reloadData];
                                [[ToolOprationer sharedInstance] hideRefreshIndactor];
                            }
                        }
                    }];
                }];
            }else{
                [self.myTableView reloadData];
                [[ToolOprationer sharedInstance] hideRefreshIndactor];
            }
        }
    };
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        [self.myTableView reloadData];
        [[ToolOprationer sharedInstance] showTip2:@"获取视频失败!" timeConut:1];
    };
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (segmentIndex == 0 && section == 1) {
        return 10;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (segmentIndex == 1 || (segmentIndex == 0 && section == 1)) {
        return 5;
    }else{
        return 0.1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (segmentIndex == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (segmentIndex == 0 && section == 0) {
        return 2;
    }else{
        return dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isIndex0 = YES;
    if (segmentIndex == 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return self.itunesCell;
            }else{
                return self.wifiCell;
            }
        }
    }else{
        isIndex0 = NO;
    }
    NSString* identifier = @"LocalVideoCell";
    LocalVideoCell *dataCell = (LocalVideoCell*)[[ToolOprationer sharedInstance] getTableViewCellForTableview:tableView className:identifier nibName:identifier identifier:identifier];
    LocalVideoData *data = dataArray[indexPath.row];
    [dataCell initDataWith:data];
    return  dataCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (segmentIndex == 0 && indexPath.section == 0) {
        return 50;
    }else{
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LocalVideoData *data = nil;
    if (segmentIndex == 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                BackUpAndRestoreViewController *backContor = [[BackUpAndRestoreViewController alloc] initWithNibName:@"BackUpAndRestoreViewController" bundle:nil];
                [self.navigationController pushViewController:backContor animated:YES];
            }else{
                ItunesViewController *itunesContor = [[ItunesViewController alloc] initWithNibName:@"ItunesViewController" bundle:nil];
                [self.navigationController pushViewController:itunesContor animated:YES];
            }
        }else{
            data = dataArray[indexPath.row];
        }
    }else{
        data = dataArray[indexPath.row];
    }
    if (data) {
        NSString *path = data.url;
        UVPlayerItemType type;
        if ([data.type isEqualToString:LocalSystemVideo]) {
            type = UVPlayerItemTypeOnline;
        }else{
            type = UVPlayerItemTypeLocalVideo;
        }
        [[ToolOprationer sharedInstance] showVRviewToWindow:@[path] type:type];
        
//        if ([data.type isEqualToString:LocalSystemVideo]) {
//            [self createAndShowLocalTmpVideoWithUrl:path];
//        }else{
//            UVPlayerItemType type = UVPlayerItemTypeLocalVideo;
//            [[ToolOprationer sharedInstance] showVRviewToWindow:@[path] type:type];
//        }
    }
}

- (void)createAndShowLocalTmpVideoWithUrl:(NSString *)path{
    [[ToolOprationer sharedInstance] showRefreshIndactor];
    NSURL *url = [NSURL URLWithString:path];
    NSString *videoPath = [SuperVR_TmpPath stringByAppendingPathComponent:LocalTmpVideoFileName];
    [FileManagerUtils deleteFolderAndSubFile:videoPath];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            NSLog(@"-----1----");
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
            NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
            NSLog(@"-----2----");
            NSData *videoData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
            NSLog(@"-----3----");
            [[NSFileManager defaultManager] createFileAtPath:videoPath contents:videoData attributes:nil];
            NSLog(@"-----4----");
            [GCDQueue executeInMainQueue:^{
                [[ToolOprationer sharedInstance] hideRefreshIndactor];
                UVPlayerItemType type = UVPlayerItemTypeLocalVideo;
                [[ToolOprationer sharedInstance] showVRviewToWindow:@[videoPath] type:type];
            }];
        } failureBlock:^(NSError *error) {
            [GCDQueue executeInMainQueue:^{
                [[ToolOprationer sharedInstance] showTip2:@"播放失败!" timeConut:1];
            }];
        }];
    });
    
    //分段
//    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
//            ALAssetRepresentation *rep = [asset defaultRepresentation];
//            char const *cvideoPath = [videoPath UTF8String];
//            FILE *file = fopen(cvideoPath, "a+");
//            if (file) {
//                const int bufferSize = 1024 * 1024;
//                Byte *buffer = (Byte*)malloc(bufferSize);
//                NSUInteger read = 0, offset = 0, written = 0;
//                NSError* err = nil;
//                if (rep.size != 0){
//                    do {
//                        read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
//                        written = fwrite(buffer, sizeof(char), read, file);
//                        offset += read;
//                    } while (read != 0 && !err);
//                }
//                free(buffer);
//                buffer = NULL;
//                fclose(file);
//                file = NULL;
//            }
//            [GCDQueue executeInMainQueue:^{
//                [[ToolOprationer sharedInstance] hideRefreshIndactor];
//                UVPlayerItemType type = UVPlayerItemTypeLocalVideo;
//                [[ToolOprationer sharedInstance] showVRviewToWindow:@[videoPath] type:type];
//            }];
//        } failureBlock:^(NSError *error) {
//            [GCDQueue executeInMainQueue:^{
//                [[ToolOprationer sharedInstance] showTip2:@"播放失败!" timeConut:1];
//            }];
//        }];
//    });
}

@end


