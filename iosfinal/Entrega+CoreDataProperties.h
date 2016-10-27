//
//  Entrega+CoreDataProperties.h
//  iosfinal
//
//  Created by Francisco Vieira on 27/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import "Entrega.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entrega (CoreDataProperties)

+ (NSFetchRequest<Entrega *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *destinatario;
@property (nullable, nonatomic, copy) NSString *endereco;

@end

NS_ASSUME_NONNULL_END
