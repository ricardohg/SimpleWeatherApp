//
//  CitiesViewController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesCollectionViewCell.h"
#import "City.h"

static NSString * const CELL_ID = @"CitiesCollectionViewCell";

@interface CitiesViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *citiesCollectionView;
@property (nonatomic, strong) NSArray * citiesArray;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Cities", nil);
    self.citiesCollectionView.dataSource = self;
    self.citiesCollectionView.delegate = self;
    self.citiesArray = [City getCities];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.citiesCollectionView registerNib:[UINib nibWithNibName:CELL_ID bundle:nil] forCellWithReuseIdentifier:CELL_ID];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.citiesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CitiesCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    City *city = self.citiesArray[indexPath.row];
    [cell setCellDataWithCity:city];
    
    return cell;
}

#pragma mark - UICollectionViewLayOutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2, CGRectGetWidth(collectionView.frame)/2);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    City * city = self.citiesArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectCity:)]) {
        [self.delegate didSelectCity:city];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
