//
//  EntregaViewController.h
//  iosfinal
//
//  Created by Helton Shinhei Uema on 27/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Entrega.h"

@interface EntregaViewController : UIViewController

@property Entrega * entrega;
@property double latitude;
@property double longitude;
@property CLPlacemark * placemarkEntrega;

-(void)setContatoManagedObject:(NSManagedObject *)managedObject;
-(void)setManagedObjectContext:(NSManagedObjectContext *)context andEntityDescription:(NSEntityDescription *)entityDescription;


@end
