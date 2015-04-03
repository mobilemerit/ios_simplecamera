//
//  ViewController.h
//  ios_simplecamera
//
//  Created by Pankaj on 03/04/15.
//  Copyright (c) 2015 Mobilemerit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface ViewController : UIViewController {
    GPUImageStillCamera *stillCamera;
    GPUImageFilter *filter;
    NSArray *cameraFlashStates;
    int activeState;
    UIImagePickerController *imagePickerC;
    BOOL cameraFront;
}

@property (strong, nonatomic) IBOutlet GPUImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *flashButton;

- (IBAction)toggleFlash:(id)sender;
- (IBAction)capture:(id)sender;
- (IBAction)goToCameraRoll:(id)sender;
- (IBAction)switchCameraSource:(id)sender;

@end

