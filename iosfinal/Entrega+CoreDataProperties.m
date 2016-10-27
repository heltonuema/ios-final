//
//  Entrega+CoreDataProperties.m
//  iosfinal
//
//  Created by Francisco Vieira on 27/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import "Entrega+CoreDataProperties.h"

@implementation Entrega (CoreDataProperties)

+ (NSFetchRequest<Entrega *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Entrega"];
}

@dynamic destinatario;
@dynamic endereco;

@end
