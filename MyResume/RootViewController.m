//
//  ViewController.m
//  MyResume
//
//  Created by 韩威 on 16/7/20.
//  Copyright © 2016年 韩威. All rights reserved.
//

#import "RootViewController.h"
#import "CollectionViewCircleLayout.h"
#import "CollectionViewCell.h"



static NSString * const reuseIdentifier = @"Cell";

@interface RootViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) CollectionViewCircleLayout *collectionCircleLayout;

@property (nonatomic, strong) UITextView *infoLabel;

@property (nonatomic, strong) NSArray *categoryList;

@property (nonatomic) NSInteger lastPage;

@property (nonatomic, strong) NSArray *detailInfoList;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = self.collectionCircleLayout;
    
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-dark.jpg"]];
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.collectionView.backgroundView = nil;//bgImgView;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
//    NSMutableArray *arr = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Images"].mutableCopy;
    
    //    [arr addObjectsFromArray:arr.copy];
    //    [arr addObjectsFromArray:arr.copy];
    //    [arr addObjectsFromArray:arr.copy];
    
//    self.images = arr.copy;
    
    
    
    self.detailInfoList = @[Personal_Information, Skills, Work_Experience,
                            Project_QuanWang, Project_JinKaixun, Project_YanShu,
                            Project_DaDaJipei, Project_YiMer,Personal_valuation];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categoryList" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    __autoreleasing NSError *error = nil;
    self.categoryList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error = %@", error);
    }
    
    
    UITextView *label = [UITextView new];
    label.linkTextAttributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName : [UIColor redColor],
                                 //NSUnderlineColorAttributeName : [UIColor blueColor],
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
                                 };
    label.editable = NO;
    label.delegate = self;
    label.layer.anchorPoint = CGPointMake(0, 0);
    label.frame = CGRectMake(20, 64 + 20, kScreenWidth - 40, kScreenHeight - 20 - 60 - 60 - 64);
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    _infoLabel = label;
    
    [self changeLableTextWithPage:0];
}

#pragma mark - Private

- (void)changeLableTextWithPage:(NSInteger)pageIndex
{
    if (pageIndex >= self.detailInfoList.count) return;
    
    
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    base.fromValue = @1.0;
    base.toValue = @0.1;
    base.duration = 0.25;
    base.autoreverses = YES;
    [self.infoLabel.layer addAnimation:base forKey:@"base"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       self.infoLabel.attributedText = [self buildAttributedStrinWithText:self.detailInfoList[pageIndex]];
    });

    
//    self.infoLabel.transform = CGAffineTransformMakeScale(1, 1);
//    
//    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
//        
//        self.infoLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        
//    } completion:^(BOOL finished) {
//        
//        self.infoLabel.transform = CGAffineTransformIdentity;
//        self.infoLabel.attributedText = [self buildAttributedStrinWithText:self.detailInfoList[pageIndex]];
//    }];
}

- (NSMutableAttributedString *)buildAttributedStrinWithText:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:17],
                                 NSForegroundColorAttributeName : [UIColor blackColor],
                                 NSParagraphStyleAttributeName : paragraphStyle,
                                 };
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    
    NSRegularExpression *URLregex = [NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:kNilOptions error:NULL];
    
    NSArray *URLResults = [URLregex matchesInString:text options:kNilOptions range:NSMakeRange(0, text.length)];
    
    
    for (NSTextCheckingResult *url in URLResults) {
        if (url.range.location == NSNotFound && url.range.length <= 1) continue;
        
        NSString *urlStr = [text substringWithRange:url.range];
        
        //NSLog(@"urlStr = %@", urlStr);
        
        
        [mutableAttributedString addAttribute:NSLinkAttributeName value:urlStr range:url.range];
        
    }

    return mutableAttributedString;
}

- (void)setCollectionViewScroll
{
    CGFloat offestX = [self.collectionCircleLayout collectionViewContentSize].width - kScreenWidth;
    
    CGFloat perOffestX = offestX / (CGFloat)(self.categoryList.count - 1);
    
    NSInteger page = self.collectionView.contentOffset.x / perOffestX;
    
    [self.collectionView setContentOffset:CGPointMake(page * perOffestX, 0) animated:YES];
    
    //NSLog(@"page = %ld", page);
    
    if (self.lastPage != page)
    {
        //TODO:切换内容
        [self changeLableTextWithPage:page];
    }
    
    self.lastPage = page;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.categoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    NSDictionary *dic = self.categoryList[indexPath.row];
    NSString *title = dic[@"title"];
    NSString *img = dic[@"img"];
    
    cell.titleLabel.text = title;
    
    cell.imgView.image = [UIImage imageNamed:img];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"index = %ld", (long)indexPath.row);
    
    CGFloat offestX = [self.collectionCircleLayout collectionViewContentSize].width - kScreenWidth;
    
    CGFloat perOffestX = offestX / (CGFloat)(self.categoryList.count - 1);
    
//    NSInteger page = self.collectionView.contentOffset.x / perOffestX;

    
    [collectionView setContentOffset:CGPointMake((indexPath.row * perOffestX), 0) animated:YES];
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != self.collectionView) return;
    
    CGFloat anglePreItem = self.collectionCircleLayout.anglePreItem;
    
    CGFloat a = atan((self.collectionView.contentOffset.x / self.collectionCircleLayout.radius));
    
    NSInteger page = self.collectionCircleLayout.angle / self.collectionCircleLayout.anglePreItem;
    NSLog(@"page = %ld", page);
    
//    NSLog(@"anglePreItem = %f", anglePreItem);
//    NSLog(@"self.collectionCircleLayout.angle) == %f", self.collectionCircleLayout.angle);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        [self setCollectionViewScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        if (scrollView == self.collectionView) {
            [self setCollectionViewScroll];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        [self setCollectionViewScroll];
    }
}


#pragma mark - Rotate

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
//    [self.collectionView setNeedsLayout];
//    [self.collectionView layoutIfNeeded];
}



#pragma mark - Getter

- (CollectionViewCircleLayout *)collectionCircleLayout
{
    if (!_collectionCircleLayout) {
        _collectionCircleLayout = [CollectionViewCircleLayout new];
    }
    return _collectionCircleLayout;
}


@end
