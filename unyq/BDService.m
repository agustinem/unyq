//
//  BDService.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "BDService.h"
#import "AppDelegate.h"
#import "Order.h"
#import "User.h"
#import "Photo.h"
#import "SDZOrderrWS.h"
#import "SDZUserWS.h"

#define RENDERS @[@"ak_aa-PERFORMANCE Armour.jpg",@"ak_aa-PERFORMANCE Armour_black.jpg",@"ak_aa-PERFORMANCE Flyer.jpg",@"ak_aa-PERFORMANCE Flyer_black.jpg",@"ak_aa-PERFORMANCE Herringbone.jpg",@"ak_aa-PERFORMANCE Herringbone_black.jpg",@"ak_ab-STYLE Alzette.jpg",@"ak_ab-STYLE Alzette_brownie.jpg",@"ak_ab-STYLE Alzette_custom.jpg",@"ak_ab-STYLE Alzette_ivory_dark brown.jpg",@"ak_ab-STYLE Alzette_silver_black.jpg",@"ak_ab-STYLE Alzette_silver_red.jpg",@"ak_ab-STYLE Alzette_white_dark blue.jpg",@"ak_ab-STYLE Alzette_white_red.jpg",@"ak_ab-STYLE Carena.jpg",@"ak_ab-STYLE Carena_black_gold.jpg",@"ak_ab-STYLE Carena_black_red.jpg",@"ak_ab-STYLE Carena_custom.jpg",@"ak_ab-STYLE Carena_titanium_black.jpg",@"ak_ab-STYLE Carena_white_gold.jpg",@"ak_ab-STYLE Carena_yellow_black.jpg",@"ak_ab-STYLE Catwalk.jpg",@"ak_ab-STYLE Catwalk_black_gold.jpg",@"ak_ab-STYLE Catwalk_black_silver.jpg",@"ak_ab-STYLE Catwalk_custom.jpg",@"ak_ab-STYLE Catwalk_white_gold.jpg",@"ak_ab-STYLE Cycle.jpg",@"ak_ab-STYLE Cycle_black.jpg",@"ak_ab-STYLE Cycle_corinto.jpg",@"ak_ab-STYLE Cycle_custom.jpg",@"ak_ab-STYLE Cycle_dark blue.jpg",@"ak_ab-STYLE Cycle_orange.jpg",@"ak_ab-STYLE Galaxy.jpg",@"ak_ab-STYLE Galaxy_black_silver.jpg",@"ak_ab-STYLE Galaxy_custom.jpg",@"ak_ab-STYLE Galaxy_dark blue_silver.jpg",@"ak_ab-STYLE Galaxy_gold_black.jpg",@"ak_ab-STYLE Galaxy_gold_red.jpg",@"ak_ab-STYLE Galaxy_silver_black.jpg",@"ak_ab-STYLE Galaxy_silver_red.jpg",@"ak_ab-STYLE Ranger.jpg",@"ak_ab-STYLE Ranger_black.jpg",@"ak_ab-STYLE Ranger_custom.jpg",@"ak_ab-STYLE Ranger_dark blue.jpg",@"ak_ab-STYLE Ranger_red.jpg",@"ak_ab-STYLE Ranger_white.jpg",@"ak_ab-STYLE Ranger_yellow.jpg",@"ak_ab-STYLE Ribbons.jpg",@"ak_ab-STYLE Ribbons_black_dark copper.jpg",@"ak_ab-STYLE Ribbons_black_gold.jpg",@"ak_ab-STYLE Ribbons_custom.jpg",@"ak_ab-STYLE Ribbons_hemlock.jpg",@"ak_ab-STYLE Ribbons_red_white.jpg",@"ak_ab-STYLE Rivet.jpg",@"ak_ab-STYLE Rivet_custom.jpg",@"ak_ab-STYLE Rivet_titanium_Walnut.jpg",@"ak_ab-STYLE Roadster.jpg",@"ak_ab-STYLE Roadster_black.jpg",@"ak_ab-STYLE Roadster_custom.jpg",@"ak_ab-STYLE Roadster_red.jpg",@"ak_ab-STYLE Roadster_silver.jpg",@"ak_ab-STYLE Roadster_white.jpg",@"ak_ab-STYLE Styilis.jpg",@"ak_ab-STYLE Styilis_custom.jpg",@"ak_ab-STYLE Styilis_dark copper_black.jpg",@"ak_ab-STYLE Styilis_orange_silver_black.jpg",@"ak_ab-STYLE Styilis_pink_black.jpg",@"ak_ab-STYLE Trooper.jpg",@"ak_ab-STYLE Trooper_black_gold.jpg",@"ak_ab-STYLE Trooper_black_red.jpg",@"ak_ab-STYLE Trooper_black_silver.jpg",@"ak_ab-STYLE Trooper_custom.jpg",@"ak_ab-STYLE Trooper_white_black.jpg",@"ak_ab-STYLE Trooper_white_gold.jpg",@"ak_ab-STYLE U Cam.jpg",@"ak_ab-STYLE U Cam_custom.jpg",@"ak_ab-STYLE U Cam_digital woodland.jpg",@"ak_ab-STYLE U Cam_forest.jpg",@"ak_ab-STYLE U Cam_snow.jpg",@"ak_ab-STYLE U Carbon.jpg",@"ak_ab-STYLE U Carbon_Carbon.jpg",@"ak_ab-STYLE U Carbon_custom.jpg",@"ak_ab-STYLE U Carbon_gold.jpg",@"ak_ab-STYLE U Carbon_light copper.jpg",@"ak_ab-STYLE U Carbon_silver.jpg",@"ak_ab-STYLE U Carbon_Walnut.jpg",@"ak_ab-STYLE U Walnut.jpg",@"ak_ab-STYLE U Walnut_black.jpg",@"ak_ab-STYLE U Walnut_custom.jpg",@"ak_ab-STYLE U Walnut_gold.jpg",@"ak_ab-STYLE U Walnut_silver.jpg",@"ak_ab-STYLE U Walnut_Walnut.jpg",@"ak_ab-STYLE U Walnut_white.jpg",@"ak_ab-STYLE U.jpg",@"ak_ab-STYLE Ukit.jpg",@"ak_ab-STYLE Ukit_biker.jpg",@"ak_ab-STYLE Ukit_custom.jpg",@"ak_ab-STYLE Ukit_midcentury.jpg",@"ak_ab-STYLE Ukit_summertime.jpg",@"ak_ab-STYLE Ukit_tango.jpg",@"ak_ab-STYLE U_black.jpg",@"ak_ab-STYLE U_blue.jpg",@"ak_ab-STYLE U_coral.jpg",@"ak_ab-STYLE U_custom.jpg",@"ak_ab-STYLE U_hemlock.jpg",@"ak_ab-STYLE U_orchid.jpg",@"ak_ab-STYLE U_silver.jpg",@"ak_ab-STYLE U_white.jpg",@"ak_ab-STYLE U_yellow.jpg",@"ak_ab-STYLE Venus.jpg",@"ak_ab-STYLE Venus_black_gold.jpg",@"ak_ab-STYLE Venus_chocolate.jpg",@"ak_ab-STYLE Venus_custom.jpg",@"ak_ab-STYLE Venus_ocean.jpg",@"ak_ab-STYLE Venus_racing.jpg",@"ak_ab-STYLE Vittra.jpg",@"ak_ab-STYLE Vittra_black.jpg",@"ak_ab-STYLE Vittra_blue.jpg",@"ak_ab-STYLE Vittra_coral.jpg",@"ak_ab-STYLE Vittra_corinto.jpg",@"ak_ab-STYLE Vittra_custom.jpg",@"ak_ab-STYLE Vittra_dark copper.jpg",@"ak_ab-STYLE Vittra_gold.jpg",@"ak_ab-STYLE Vittra_light copper.jpg",@"ak_ab-STYLE Vittra_orchid.jpg",@"ak_ab-STYLE Vittra_red.jpg",@"ak_ab-STYLE Vittra_silver.jpg",@"ak_ab-STYLE Vittra_white.jpg",@"ak_ab-STYLE Xtreme.jpg",@"ak_ab-STYLE Xtreme_black.jpg",@"ak_ab-STYLE Xtreme_custom.jpg",@"ak_ab-STYLE Xtreme_dark blue.jpg",@"ak_ab-STYLE Xtreme_gold.jpg",@"ak_ab-STYLE Xtreme_orange.jpg",@"ak_ab-STYLE Xtreme_red.jpg",@"ak_ab-STYLE Xtreme_white.jpg",@"ak_ab-STYLE Xtreme_yellow.jpg",@"ak_ac-OTTOBOCK Camellia.jpg",@"ak_ac-OTTOBOCK Camellia_corinto.jpg",@"ak_ac-OTTOBOCK Camellia_ivory.jpg",@"ak_ac-OTTOBOCK Camellia_lavender.jpg",@"ak_ac-OTTOBOCK Camellia_white.jpg",@"ak_ac-OTTOBOCK Coral.jpg",@"ak_ac-OTTOBOCK Coral_camouflage.jpg",@"ak_ac-OTTOBOCK Coral_blue.jpg",@"ak_ac-OTTOBOCK Coral_carbon.jpg",@"ak_ac-OTTOBOCK Coral_dark blue.jpg",@"ak_ac-OTTOBOCK Coral_walnut.jpg",@"ak_ac-OTTOBOCK Coral_water blue.jpg",@"ak_ac-OTTOBOCK Reed.jpg",@"ak_ac-OTTOBOCK Reed_camouflage.jpg",@"ak_ac-OTTOBOCK Reed_carbon.jpg",@"ak_ac-OTTOBOCK Reed_green.jpg",@"ak_ac-OTTOBOCK Reed_pastel green.jpg",@"ak_ac-OTTOBOCK Reed_silver.jpg",@"ak_ac-OTTOBOCK Reed_titanium.jpg",@"ak_ac-OTTOBOCK Reed_walnut.jpg",@"ak_ac-OTTOBOCK Reed_white.jpg",@"bkmini_aa-PERFORMANCE Armour.jpg",@"bkmini_aa-PERFORMANCE Armour_black.jpg",@"bkmini_aa-PERFORMANCE Flyer.jpg",@"bkmini_aa-PERFORMANCE Flyer_black.jpg",@"bkmini_ab-STYLE Alzette.jpg",@"bkmini_ab-STYLE Alzette_brownie.jpg",@"bkmini_ab-STYLE Alzette_custom.jpg",@"bkmini_ab-STYLE Alzette_ivory_dark brown.jpg",@"bkmini_ab-STYLE Alzette_silver_black.jpg",@"bkmini_ab-STYLE Alzette_silver_red.jpg",@"bkmini_ab-STYLE Alzette_white_dark blue.jpg",@"bkmini_ab-STYLE Alzette_white_red.jpg",@"bkmini_ab-STYLE Carena.jpg",@"bkmini_ab-STYLE Carena_black_gold.jpg",@"bkmini_ab-STYLE Carena_black_red.jpg",@"bkmini_ab-STYLE Carena_custom.jpg",@"bkmini_ab-STYLE Carena_white_gold.jpg",@"bkmini_ab-STYLE Carena_yellow_black.jpg",@"bkmini_ab-STYLE Catwalk.jpg",@"bkmini_ab-STYLE Catwalk_black_gold.jpg",@"bkmini_ab-STYLE Catwalk_black_silver.jpg",@"bkmini_ab-STYLE Catwalk_custom.jpg",@"bkmini_ab-STYLE Catwalk_white_gold.jpg",@"bkmini_ab-STYLE Cycle.jpg",@"bkmini_ab-STYLE Cycle_black.jpg",@"bkmini_ab-STYLE Cycle_corinto.jpg",@"bkmini_ab-STYLE Cycle_custom.jpg",@"bkmini_ab-STYLE Cycle_dark blue.jpg",@"bkmini_ab-STYLE Cycle_orange.jpg",@"bkmini_ab-STYLE Galaxy.jpg",@"bkmini_ab-STYLE Galaxy_black_silver.jpg",@"bkmini_ab-STYLE Galaxy_custom.jpg",@"bkmini_ab-STYLE Galaxy_dark blue_silver.jpg",@"bkmini_ab-STYLE Galaxy_gold_black.jpg",@"bkmini_ab-STYLE Galaxy_gold_red.jpg",@"bkmini_ab-STYLE Galaxy_silver_black.jpg",@"bkmini_ab-STYLE Galaxy_silver_red.jpg",@"bkmini_ab-STYLE Ribbons.jpg",@"bkmini_ab-STYLE Ribbons_black_dark copper.jpg",@"bkmini_ab-STYLE Ribbons_black_gold.jpg",@"bkmini_ab-STYLE Ribbons_black_hemlock.jpg",@"bkmini_ab-STYLE Ribbons_custom.jpg",@"bkmini_ab-STYLE Ribbons_red_white.jpg",@"bkmini_ab-STYLE Rivet.jpg",@"bkmini_ab-STYLE Rivet_custom.jpg",@"bkmini_ab-STYLE Rivet_titanium_Walnut.jpg",@"bkmini_ab-STYLE Roadster.jpg",@"bkmini_ab-STYLE Roadster_black.jpg",@"bkmini_ab-STYLE Roadster_custom.jpg",@"bkmini_ab-STYLE Roadster_red.jpg",@"bkmini_ab-STYLE Roadster_silver.jpg",@"bkmini_ab-STYLE Roadster_white.jpg",@"bkmini_ab-STYLE Styilis.jpg",@"bkmini_ab-STYLE Styilis_custom.jpg",@"bkmini_ab-STYLE Styilis_dark copper_black.jpg",@"bkmini_ab-STYLE Styilis_orange_silver_black.jpg",@"bkmini_ab-STYLE Styilis_pink_black.jpg",@"bkmini_ab-STYLE U Cam.jpg",@"bkmini_ab-STYLE U Cam_custom.jpg",@"bkmini_ab-STYLE U Cam_digital woodland.jpg",@"bkmini_ab-STYLE U Cam_forest.jpg",@"bkmini_ab-STYLE U Cam_snow.jpg",@"bkmini_ab-STYLE U Carbon.jpg",@"bkmini_ab-STYLE U Carbon_Carbon.jpg",@"bkmini_ab-STYLE U Carbon_custom.jpg",@"bkmini_ab-STYLE U Carbon_gold.jpg",@"bkmini_ab-STYLE U Carbon_light copper.jpg",@"bkmini_ab-STYLE U Carbon_silver.jpg",@"bkmini_ab-STYLE U Carbon_Walnut.jpg",@"bkmini_ab-STYLE U Walnut.jpg",@"bkmini_ab-STYLE U Walnut_black.jpg",@"bkmini_ab-STYLE U Walnut_custom.jpg",@"bkmini_ab-STYLE U Walnut_gold.jpg",@"bkmini_ab-STYLE U Walnut_silver.jpg",@"bkmini_ab-STYLE U Walnut_Walnut.jpg",@"bkmini_ab-STYLE U Walnut_white.jpg",@"bkmini_ab-STYLE U.jpg",@"bkmini_ab-STYLE Ukit.jpg",@"bkmini_ab-STYLE Ukit_biker.jpg",@"bkmini_ab-STYLE Ukit_custom.jpg",@"bkmini_ab-STYLE Ukit_midcentury.jpg",@"bkmini_ab-STYLE Ukit_summertime.jpg",@"bkmini_ab-STYLE Ukit_tango.jpg",@"bkmini_ab-STYLE U_black.jpg",@"bkmini_ab-STYLE U_blue.jpg",@"bkmini_ab-STYLE U_coral.jpg",@"bkmini_ab-STYLE U_custom.jpg",@"bkmini_ab-STYLE U_hemlock.jpg",@"bkmini_ab-STYLE U_orchid.jpg",@"bkmini_ab-STYLE U_silver.jpg",@"bkmini_ab-STYLE U_white.jpg",@"bkmini_ab-STYLE U_yellow.jpg",@"bkmini_ab-STYLE Venus.jpg",@"bkmini_ab-STYLE Venus_black_gold.jpg",@"bkmini_ab-STYLE Venus_chocolate.jpg",@"bkmini_ab-STYLE Venus_custom.jpg",@"bkmini_ab-STYLE Venus_ocean.jpg",@"bkmini_ab-STYLE Venus_racing.jpg",@"bkmini_ab-STYLE Vittra.jpg",@"bkmini_ab-STYLE Vittra_black.jpg",@"bkmini_ab-STYLE Vittra_blue.jpg",@"bkmini_ab-STYLE Vittra_coral.jpg",@"bkmini_ab-STYLE Vittra_corinto.jpg",@"bkmini_ab-STYLE Vittra_custom.jpg",@"bkmini_ab-STYLE Vittra_dark copper.jpg",@"bkmini_ab-STYLE Vittra_gold.jpg",@"bkmini_ab-STYLE Vittra_light copper.jpg",@"bkmini_ab-STYLE Vittra_orchid.jpg",@"bkmini_ab-STYLE Vittra_red.jpg",@"bkmini_ab-STYLE Vittra_silver.jpg",@"bkmini_ab-STYLE Vittra_white.jpg",@"bkmini_ab-STYLE Xtreme.jpg",@"bkmini_ab-STYLE Xtreme_black.jpg",@"bkmini_ab-STYLE Xtreme_custom.jpg",@"bkmini_ab-STYLE Xtreme_dark blue.jpg",@"bkmini_ab-STYLE Xtreme_gold.jpg",@"bkmini_ab-STYLE Xtreme_red.jpg",@"bkmini_ab-STYLE Xtreme_white.jpg",@"bkmini_ab-STYLE Xtreme_yellow.jpg",@"bkmini_ac-OTTOBOCK Camellia.jpg",@"bkmini_ac-OTTOBOCK Camellia_coral.jpg",@"bkmini_ac-OTTOBOCK Camellia_corinto.jpg",@"bkmini_ac-OTTOBOCK Camellia_ivory.jpg",@"bkmini_ac-OTTOBOCK Camellia_lavender.jpg",@"bkmini_ac-OTTOBOCK Camellia_white.jpg",@"bkmini_ac-OTTOBOCK Coral.jpg",@"bkmini_ac-OTTOBOCK Coral_blue.jpg",@"bkmini_ac-OTTOBOCK Coral_camouflage.jpg",@"bkmini_ac-OTTOBOCK Coral_carbon.jpg",@"bkmini_ac-OTTOBOCK Coral_dark blue.jpg",@"bkmini_ac-OTTOBOCK Coral_walnut.jpg",@"bkmini_ac-OTTOBOCK Coral_water blue.jpg",@"bkmini_ac-OTTOBOCK Reed.jpg",@"bkmini_ac-OTTOBOCK Reed_camouflage.jpg",@"bkmini_ac-OTTOBOCK Reed_carbon.jpg",@"bkmini_ac-OTTOBOCK Reed_green.jpg",@"bkmini_ac-OTTOBOCK Reed_pastel green.jpg",@"bkmini_ac-OTTOBOCK Reed_silver.jpg",@"bkmini_ac-OTTOBOCK Reed_titanium.jpg",@"bkmini_ac-OTTOBOCK Reed_walnut.jpg",@"bkmini_ac-OTTOBOCK Reed_white.jpg",@"bk_aa-PERFORMANCE Armour.jpg",@"bk_aa-PERFORMANCE Armour_black.jpg",@"bk_aa-PERFORMANCE Flyer.jpg",@"bk_aa-PERFORMANCE Flyer_black.jpg",@"bk_ab-STYLE Alzette.jpg",@"bk_ab-STYLE Alzette_brownie.jpg",@"bk_ab-STYLE Alzette_custom.jpg",@"bk_ab-STYLE Alzette_ivory_dark brown.jpg",@"bk_ab-STYLE Alzette_silver_black.jpg",@"bk_ab-STYLE Alzette_silver_red.jpg",@"bk_ab-STYLE Alzette_white_dark blue.jpg",@"bk_ab-STYLE Alzette_white_red.jpg",@"bk_ab-STYLE Carena.jpg",@"bk_ab-STYLE Carena_black_gold.jpg",@"bk_ab-STYLE Carena_black_red.jpg",@"bk_ab-STYLE Carena_custom.jpg",@"bk_ab-STYLE Carena_white_gold.jpg",@"bk_ab-STYLE Carena_yellow_black.jpg",@"bk_ab-STYLE Catwalk.jpg",@"bk_ab-STYLE Catwalk_black_gold.jpg",@"bk_ab-STYLE Catwalk_black_silver.jpg",@"bk_ab-STYLE Catwalk_custom.jpg",@"bk_ab-STYLE Catwalk_white_gold.jpg",@"bk_ab-STYLE Cycle.jpg",@"bk_ab-STYLE Cycle_black.jpg",@"bk_ab-STYLE Cycle_corinto.jpg",@"bk_ab-STYLE Cycle_custom.jpg",@"bk_ab-STYLE Cycle_dark blue.jpg",@"bk_ab-STYLE Cycle_orange.jpg",@"bk_ab-STYLE Galaxy.jpg",@"bk_ab-STYLE Galaxy_black_silver.jpg",@"bk_ab-STYLE Galaxy_custom.jpg",@"bk_ab-STYLE Galaxy_dark blue_silver.jpg",@"bk_ab-STYLE Galaxy_gold_black.jpg",@"bk_ab-STYLE Galaxy_gold_red.jpg",@"bk_ab-STYLE Galaxy_silver_black.jpg",@"bk_ab-STYLE Galaxy_silver_red.jpg",@"bk_ab-STYLE Ribbons.jpg",@"bk_ab-STYLE Ribbons_black_dark copper.jpg",@"bk_ab-STYLE Ribbons_black_gold.jpg",@"bk_ab-STYLE Ribbons_black_hemlock.jpg",@"bk_ab-STYLE Ribbons_custom.jpg",@"bk_ab-STYLE Ribbons_red_white.jpg",@"bk_ab-STYLE Rivet.jpg",@"bk_ab-STYLE Rivet_custom.jpg",@"bk_ab-STYLE Rivet_titanium_Walnut.jpg",@"bk_ab-STYLE Roadster.jpg",@"bk_ab-STYLE Roadster_black.jpg",@"bk_ab-STYLE Roadster_custom.jpg",@"bk_ab-STYLE Roadster_red.jpg",@"bk_ab-STYLE Roadster_silver.jpg",@"bk_ab-STYLE Roadster_white.jpg",@"bk_ab-STYLE Styilis.jpg",@"bk_ab-STYLE Styilis_custom.jpg",@"bk_ab-STYLE Styilis_dark copper_black.jpg",@"bk_ab-STYLE Styilis_orange_silver_black.jpg",@"bk_ab-STYLE Styilis_pink_black.jpg",@"bk_ab-STYLE U Cam.jpg",@"bk_ab-STYLE U Cam_custom.jpg",@"bk_ab-STYLE U Cam_digital woodland.jpg",@"bk_ab-STYLE U Cam_forest.jpg",@"bk_ab-STYLE U Cam_snow.jpg",@"bk_ab-STYLE U Carbon.jpg",@"bk_ab-STYLE U Carbon_Carbon.jpg",@"bk_ab-STYLE U Carbon_custom.jpg",@"bk_ab-STYLE U Carbon_gold.jpg",@"bk_ab-STYLE U Carbon_light copper.jpg",@"bk_ab-STYLE U Carbon_silver.jpg",@"bk_ab-STYLE U Carbon_Walnut.jpg",@"bk_ab-STYLE U Walnut.jpg",@"bk_ab-STYLE U Walnut_black.jpg",@"bk_ab-STYLE U Walnut_custom.jpg",@"bk_ab-STYLE U Walnut_gold.jpg",@"bk_ab-STYLE U Walnut_silver.jpg",@"bk_ab-STYLE U Walnut_Walnut.jpg",@"bk_ab-STYLE U Walnut_white.jpg",@"bk_ab-STYLE U.jpg",@"bk_ab-STYLE Ukit.jpg",@"bk_ab-STYLE Ukit_biker.jpg",@"bk_ab-STYLE Ukit_custom.jpg",@"bk_ab-STYLE Ukit_midcentury.jpg",@"bk_ab-STYLE Ukit_summertime.jpg",@"bk_ab-STYLE Ukit_tango.jpg",@"bk_ab-STYLE U_black.jpg",@"bk_ab-STYLE U_blue.jpg",@"bk_ab-STYLE U_coral.jpg",@"bk_ab-STYLE U_custom.jpg",@"bk_ab-STYLE U_hemlock.jpg",@"bk_ab-STYLE U_orchid.jpg",@"bk_ab-STYLE U_silver.jpg",@"bk_ab-STYLE U_white.jpg",@"bk_ab-STYLE U_yellow.jpg",@"bk_ab-STYLE Venus.jpg",@"bk_ab-STYLE Venus_black_gold.jpg",@"bk_ab-STYLE Venus_chocolate.jpg",@"bk_ab-STYLE Venus_custom.jpg",@"bk_ab-STYLE Venus_ocean.jpg",@"bk_ab-STYLE Venus_racing.jpg",@"bk_ab-STYLE Vittra.jpg",@"bk_ab-STYLE Vittra_black.jpg",@"bk_ab-STYLE Vittra_blue.jpg",@"bk_ab-STYLE Vittra_coral.jpg",@"bk_ab-STYLE Vittra_corinto.jpg",@"bk_ab-STYLE Vittra_custom.jpg",@"bk_ab-STYLE Vittra_dark copper.jpg",@"bk_ab-STYLE Vittra_gold.jpg",@"bk_ab-STYLE Vittra_light copper.jpg",@"bk_ab-STYLE Vittra_orchid.jpg",@"bk_ab-STYLE Vittra_red.jpg",@"bk_ab-STYLE Vittra_silver.jpg",@"bk_ab-STYLE Vittra_white.jpg",@"bk_ab-STYLE Xtreme.jpg",@"bk_ab-STYLE Xtreme_black.jpg",@"bk_ab-STYLE Xtreme_custom.jpg",@"bk_ab-STYLE Xtreme_dark blue.jpg",@"bk_ab-STYLE Xtreme_gold.jpg",@"bk_ab-STYLE Xtreme_red.jpg",@"bk_ab-STYLE Xtreme_white.jpg",@"bk_ab-STYLE Xtreme_yellow.jpg",@"bk_ac-OTTOBOCK Camellia.jpg",@"bk_ac-OTTOBOCK Camellia_coral.jpg",@"bk_ac-OTTOBOCK Camellia_corinto.jpg",@"bk_ac-OTTOBOCK Camellia_ivory.jpg",@"bk_ac-OTTOBOCK Camellia_lavender.jpg",@"bk_ac-OTTOBOCK Camellia_white.jpg",@"bk_ac-OTTOBOCK Coral.jpg",@"bk_ac-OTTOBOCK Coral_blue.jpg",@"bk_ac-OTTOBOCK Coral_camouflage.jpg",@"bk_ac-OTTOBOCK Coral_carbon.jpg",@"bk_ac-OTTOBOCK Coral_dark blue.jpg",@"bk_ac-OTTOBOCK Coral_walnut.jpg",@"bk_ac-OTTOBOCK Coral_water blue.jpg",@"bk_ac-OTTOBOCK Reed.jpg",@"bk_ac-OTTOBOCK Reed_camouflage.jpg",@"bk_ac-OTTOBOCK Reed_carbon.jpg",@"bk_ac-OTTOBOCK Reed_green.jpg",@"bk_ac-OTTOBOCK Reed_pastel green.jpg",@"bk_ac-OTTOBOCK Reed_silver.jpg",@"bk_ac-OTTOBOCK Reed_titanium.jpg",@"bk_ac-OTTOBOCK Reed_walnut.jpg",@"bk_ac-OTTOBOCK Reed_white.jpg"]


@implementation BDService

+(BDService *)instance{
    static BDService * bdservice = nil;
    if(bdservice == nil){
        bdservice = [[BDService alloc] init];
        AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        bdservice.context = [appDelegate managedObjectContext];
    }
    return bdservice;
}

-(void)addPhotos{
    //obtengo los que hay en la bd local
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSArray *photosFetch = [self.context executeFetchRequest:fetchRequest error:&error];
    
    //los elimino
    for (Photo *photo in photosFetch) {
        [self.context deleteObject:photo];
        [self.context save:&error];
    }
    
    //inserto los nuevos
    NSArray *renders = RENDERS;
    for (NSString *photoString in renders) {
        
        NSArray *photo = [photoString componentsSeparatedByString:@"_"];
        Photo *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.context];
        newPhoto.section = photo[0];
        newPhoto.model = photo[1];
        newPhoto.name = photoString;
        if ([photo count] >= 3) {
            newPhoto.color1 = photo[2];
        }if ([photo count] >= 4){
            newPhoto.color2 = photo[3];
        }if ([photo count] >= 5){
            newPhoto.color3 = photo[4];
        }
        [self.context save:&error];
    }
}

-(NSArray *)getModelsBySection:(NSString *)section{
    NSMutableArray *array = [NSMutableArray new];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"section == %@", section];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted

    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:fetchRequest error:&error];
    for (Photo *photo in results) {
        if([photo.model containsString:@".jpg"]){
            [array addObject:photo];
        }
    }
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"model" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}

-(NSArray *)getColorsByModel:(NSString *)section model:(NSString *)model{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"section == %@ && model==%@", section,model];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;

    // Specify how the fetched objects should be sorted
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:fetchRequest error:&error]];

    Photo *custom = nil;
    for (Photo *photo in array) {
        if([photo.name containsString:@"custom"]){
            custom = photo;
            break;
        }        
    }
    
    if([array containsObject:custom]){
    [array removeObject:custom];
    [array insertObject:custom atIndex:0];
    }
    
    
    
    
    return array;
}

-(void)addOrders:(NSArray *)orders{
    //obtengo los que hay en la bd local
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSArray *ordersFetch = [self.context executeFetchRequest:fetchRequest error:&error];
    
    //los elimino
    for (Order *order in ordersFetch) {
        [self.context deleteObject:order];
        [self.context save:&error];
    }
    
    //inserto los nuevos
    for (SDZOrderrWS *orderWS in orders) {
        Order *newOrder = [NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:self.context];
        newOrder.idOrder = orderWS._id;
        newOrder.type = orderWS.type;
        newOrder.hub = orderWS.hub;
        newOrder.patient= orderWS.patient;
        newOrder.cpo_name= orderWS.cpo_name;
        newOrder.order_date= orderWS.order_date;
        newOrder.recept_date = orderWS.recept_date;
        newOrder.cover = orderWS.cover;
        newOrder.model=  orderWS.model;
        newOrder.colour1 = orderWS.colour1;
        newOrder.colour2 = orderWS.colour2;
        newOrder.colour3 = orderWS.colour3;
        newOrder.amp_side = orderWS.amp_side;
        newOrder.top_calf =  orderWS.top_calf;
        newOrder.max_calf= orderWS.max_calf;
        newOrder.mid_calf= orderWS.mid_calf;
        newOrder.low_calf= orderWS.low_calf;
        newOrder.knee_ankle_axis= orderWS.knee_ankle_axis;
        newOrder.serialnumber = orderWS.serial_number;
        newOrder.status = orderWS.status;
        newOrder.estimated_date = orderWS.estimated_date;
        [self.context save:&error];
    }
}


-(void)addUser:(SDZUserWS *)user{
    //obtengo los que hay en la bd local
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSArray *usersFetch = [self.context executeFetchRequest:fetchRequest error:&error];
    
    //los elimino
    for (User *user in usersFetch) {
        [self.context deleteObject:user];
        [self.context save:&error];
    }
    
    //inserto los nuevos
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    newUser.idUser= user._id;
    newUser.user= user.user;
    newUser.clinic_name= user.clinic_name;
    newUser.bill_street= user.bill_street;
    newUser.bill_city= user.bill_city;
    newUser.bill_country= user.bill_country;
    newUser.bill_zipcode= user.bill_zipcode;
    newUser.bill_contact= user.bill_contact;
    newUser.bill_phone= user.bill_phone;
    newUser.ship_street= user.ship_street;
    newUser.ship_city= user.ship_city;
    newUser.ship_country= user.ship_country;
    newUser.ship_zipcode= user.ship_zipcode;
    newUser.ship_contact= user.ship_contact;
    newUser.ship_phone= user.ship_phone;
    newUser.vat= user.vat;
    newUser.cpo_name= user.cpo_name;
    newUser.cpo_email= user.cpo_email;
    newUser.admin_name= user.admin_name;
    newUser.admin_email= user.admin_email;
    [self.context save:&error];
}

-(Order *)getOrder:(NSString *)idOrder{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idOrder == %@", idOrder];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    return ([fetchedObjects count]>0) ? [fetchedObjects objectAtIndex:0] : nil;
}

-(NSArray *)getOrders{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    return [self.context executeFetchRequest:fetchRequest error:&error];
}

-(User *)getUSer:(NSString *)idUser{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idUser == %@", idUser];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    return ([fetchedObjects count]>0) ? [fetchedObjects objectAtIndex:0] : nil;
}


@end
