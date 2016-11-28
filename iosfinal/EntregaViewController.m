//
//  EntregaViewController.m
//  iosfinal
//
//  Created by Helton Shinhei Uema on 27/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import "EntregaViewController.h"

#import "Entrega.h"
#import "UIViewController+CoreData.h"
#import "Address.h"

@interface EntregaViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *destinatarioTextField;
@property (weak, nonatomic) IBOutlet UITextField *enderecoTextField;
@property (weak, nonatomic) IBOutlet MKMapView *map;

- (IBAction)salvar:(id)sender;

@property (weak, nonatomic) NSManagedObject *entregaManagedObject;
@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) NSEntityDescription *entityDescription;

@property CLGeocoder * geocoder;

@property NSMutableArray<Address *> * addresses;
@property NSMutableArray<MKPointAnnotation *> * points;
@property MKPolyline * line;

@end

@implementation EntregaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.entrega) {
        _destinatarioTextField.text = self.entrega.destinatario;
        _enderecoTextField.text = self.entrega.endereco;
    }
    [_enderecoTextField addTarget:self action:@selector(editouEndereco) forControlEvents:UIControlEventEditingChanged];
    _addresses = [NSMutableArray new];
    _points = [NSMutableArray new];
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    [_map setUserTrackingMode:MKUserTrackingModeFollow];
    
    // Do any additional setup after loading the view.
}

- (IBAction)gecode:(id)sender {
    [_map removeAnnotations:_addresses];
    [_addresses removeAllObjects];
    
    [self.geocoder geocodeAddressString:_enderecoTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"%@", error);
            return;
        }
        
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Address * addr = [[Address alloc] initWithPlacemark:obj withTitle:_enderecoTextField.text andWithSubtitle:[NSString stringWithFormat:@"%lu",(unsigned long)idx]];
            
            [_addresses addObject:addr];
            [self.map addAnnotation:addr];
            
        }];
        
    }];
}

- (IBAction)salvar:(id)sender {

    NSLog(@"%@", @"pressionou salvar");
    
    
    if(_destinatarioTextField.text.length && _enderecoTextField.text.length){
        
        
        if(_entregaManagedObject){
            [_entregaManagedObject setValue:_destinatarioTextField.text forKey:@"destinatario"];
            [_entregaManagedObject setValue:_enderecoTextField.text forKey:@"endereco"];
        }
        else{
            //            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
            //            NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
            NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[_entityDescription name] inManagedObjectContext:_managedObjectContext];
            
            // If appropriate, configure the new managed object.
            // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
            [newManagedObject setValue:_destinatarioTextField.text forKey:@"destinatario"];
            [newManagedObject setValue:_enderecoTextField.text forKey:@"endereco"];
            
        }
        
        NSError * error = nil;
        if (![_managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [self performSegueWithIdentifier:@"unwindToEntregas" sender:sender];
        
    }else{
        // TODO - UIAlertController
        UITextField * campoExigido = _destinatarioTextField;
        NSString * erro = @"Destinatario é obrigatório";
        if(!_destinatarioTextField.text.length){
            erro = @"Destinatário é obrigatorio";
        }else if(!_enderecoTextField.text.length){
            erro = @"Endereço é obrigatório";
            campoExigido = _enderecoTextField;
        }
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Info"
                                      message:erro
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [campoExigido becomeFirstResponder];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     [self performSegueWithIdentifier:@"unwindToEntregas" sender:sender];
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
//        if(_destinatarioTextField.text.length && _enderecoTextField.text.length) {
//            if(!self.entrega) {
//                
//                self.entrega = [NSEntityDescription insertNewObjectForEntityForName:@"Entrega" inManagedObjectContext:self.managedObjectContext];
//                
//            }
//            
//            self.entrega.destinatario = _destinatarioTextField.text;
//            self.entrega.endereco = _enderecoTextField.text;
//            
//            [self performSegueWithIdentifier:@"unwindToEntregas" sender:sender];
//            
//        } else {
//            // TODO - UIAlertController
//        }
    
    
//    if(_destinatarioTextField.text.length && _enderecoTextField.text.length) {
//        if(!self.entrega) {
//            
//            self.entrega = [NSEntityDescription insertNewObjectForEntityForName:@"Entrega" inManagedObjectContext:self.managedObjectContext];
//            
//        }
//        
//        self.entrega.destinatario = _destinatarioTextField.text;
//        self.entrega.endereco = _enderecoTextField.text;
//        
//        
//        [self performSegueWithIdentifier:@"unwindToMaster" sender:sender];
//        
//    } else {
//        // TODO - UIAlertController
//    }
    
}

-(void)setEntregaManagedObject:(NSManagedObject *)managedObject{
    _entregaManagedObject = managedObject;
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)context andEntityDescription:(NSEntityDescription *)entityDescription{
    _managedObjectContext = context;
    _entityDescription = entityDescription;
}

-(void)editouEndereco{
    NSLog(@"alterou texto");
    NSString *endereco = _enderecoTextField.text;
    [self.geocoder geocodeAddressString:endereco completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for(CLPlacemark * placemark in placemarks){
            NSLog(@"%@", [placemark postalCode]);
            self.longitude = placemark.location.coordinate.longitude;
            self.latitude = placemark.location.coordinate.latitude;
            self.placemarkEntrega = placemark;
            NSLog(@"Latitude: %f", _latitude);
            NSLog(@"Longitude: %f", _longitude);
            [self.map removeAnnotations:[self.map annotations]];
            [self.map addAnnotation:[[Address alloc]initWithPlacemark:placemark withTitle:@"Titulo" andWithSubtitle:@"Subtitulo"]];
            break;
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[Address class]]){
        MKPinAnnotationView * view = [[MKPinAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:@"Address"];
        [view setEnabled:YES];
        [view setAnimatesDrop:YES];
        [view setPinTintColor:[UIColor blueColor]];
        [view setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoLight]];
        [view setCanShowCallout:YES];
        
        return view;
    }
    
    return nil;
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    [_points addObject:point];
    
    // if(_line){
    [mapView removeOverlay:_line];
    // }
    
    CLLocationCoordinate2D * coords = malloc([_points count] * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < [_points count]; i++) {
        coords[i] = _points[i].coordinate;
    }
    
    _line = [MKPolyline polylineWithCoordinates:coords count:[_points count]];
    
    free(coords);
    
    [mapView addOverlay:_line];
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer * renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        [renderer setLineWidth:2];
        [renderer setStrokeColor:[UIColor greenColor]];
        
        return renderer;
    }
    
    return nil;
}




 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([[segue identifier] isEqualToString:@"segueToFotos"]){
         
         [[segue destinationViewController]setPlacemarkEntrega : _placemarkEntrega];
     }
 }

@end
