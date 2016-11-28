//
//  FotosProximasViewControllerCollectionViewController.h
//  iosfinal
//
//  Created by Helton Shinhei Uema on 27/11/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FotosProximasViewControllerCollectionViewController : UICollectionViewController

@property CLPlacemark * placemarkEntrega;

-(NSMutableArray *)buscaIdsDasFotos;

@end
