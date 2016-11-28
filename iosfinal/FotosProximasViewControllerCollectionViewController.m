//
//  FotosProximasViewControllerCollectionViewController.m
//  iosfinal
//
//  Created by Helton Shinhei Uema on 27/11/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import "FotosProximasViewControllerCollectionViewController.h"

@interface FotosProximasViewControllerCollectionViewController ()

@property (nonatomic) NSMutableArray * urlDasFotos;

@end

@implementation FotosProximasViewControllerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSLog(@"Latitude: %f, Longitude: %f", _placemarkEntrega.location.coordinate.latitude, _placemarkEntrega.location.coordinate.longitude);
    NSMutableArray *idsFotos = self.buscaIdsDasFotos;
    
    NSLog(@"%@", idsFotos);
    
    _urlDasFotos = [self buscaUrlDasFotos:idsFotos];
    
    for(NSString * idFotos in _urlDasFotos){
        NSLog(@"%@", idFotos);
    }
        
        // Do any additional setup after loading the view.
}

- (NSMutableArray *)buscaIdsDasFotos{
    
    NSString * latLonParameters = [NSString stringWithFormat:@"&lat=%f&lon=%f", _placemarkEntrega.location.coordinate.latitude, _placemarkEntrega.location.coordinate.longitude];
    NSString * urlPesquisa = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d4c48d2b3d5f7b92df46fd3c03a7ff49&license=7&accuracy=16%@&per_page=12&page=1&format=json&nojsoncallback=1", latLonParameters];
    
    NSURL * url = [NSURL URLWithString:urlPesquisa];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray * photos = [[json valueForKey:@"photos"] valueForKey:@"photo"];
    
    NSMutableArray * idsFotos = [[NSMutableArray alloc]init];
    
    for(NSMutableDictionary * photo in photos){
        [idsFotos addObject:[photo valueForKey:@"id"]];
    }
    
    return idsFotos;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *) buscaUrlDasFotos: (NSMutableArray *) idsFotos{
    
    NSMutableArray * urlDasFotos = [[NSMutableArray alloc]init];
    for(NSString * idFoto in idsFotos){
        NSString * urlFoto = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=d4c48d2b3d5f7b92df46fd3c03a7ff49&photo_id=%@&format=json&nojsoncallback=1", idFoto];
        
        NSURL * url = [NSURL URLWithString:urlFoto];
        NSData * data = [NSData dataWithContentsOfURL:url];
        NSError * error;
        NSMutableDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSMutableArray * arraySizes = [[json valueForKey:@"sizes"] valueForKey:@"size"];
        
        
        
        for(NSMutableDictionary * src in arraySizes){
            if([[src valueForKey:@"label"] isEqualToString:@"Square"]){
                [urlDasFotos addObject: [src valueForKey:@"source"]];
                break;
            }
            
        }
        
    }
    return urlDasFotos;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
