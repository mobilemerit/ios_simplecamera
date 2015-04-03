//
//  ViewController.m
//  ios_simplecamera
//
//  Created by Pankaj on 03/04/15.
//  Copyright (c) 2015 Mobilemerit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cameraFlashStates = @[@"auto", @"on", @"off"];
    activeState = 0;
    [self setAutoFlashMode];
    
    cameraFront = NO;
    
    imagePickerC = [[UIImagePickerController alloc] init];
    [imagePickerC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    filter = [[GPUImageGammaFilter alloc] init];
    [stillCamera addTarget:filter];
    GPUImageView *filterView = _imageView;
    [filter addTarget:filterView];
    
    [stillCamera startCameraCapture];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAutoFlashMode {
    NSError *error = nil;
    if (![stillCamera.inputCamera lockForConfiguration:&error])
    {
        NSLog(@"Error locking for configuration: %@", error);
    }
    [stillCamera.inputCamera setFlashMode:AVCaptureFlashModeAuto];
    [stillCamera.inputCamera unlockForConfiguration];
    [_flashButton setImage:[UIImage imageNamed:@"flashauto"] forState:UIControlStateNormal];
}

-(void)setOnFlashMode {
    NSError *error = nil;
    if (![stillCamera.inputCamera lockForConfiguration:&error])
    {
        NSLog(@"Error locking for configuration: %@", error);
    }
    [stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
    [stillCamera.inputCamera unlockForConfiguration];
    [_flashButton setImage:[UIImage imageNamed:@"flashon"] forState:UIControlStateNormal];
}

-(void)setOffFlashMode {
    NSError *error = nil;
    if (![stillCamera.inputCamera lockForConfiguration:&error])
    {
        NSLog(@"Error locking for configuration: %@", error);
    }
    [stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOff];
    [stillCamera.inputCamera unlockForConfiguration];
    [_flashButton setImage:[UIImage imageNamed:@"flashoff"] forState:UIControlStateNormal];
}

- (IBAction)toggleFlash:(id)sender {
    activeState = (activeState+1)%cameraFlashStates.count;
    if ([cameraFlashStates[activeState] isEqualToString:@"auto"]) {
        [self setAutoFlashMode];
    } else if([cameraFlashStates[activeState] isEqualToString:@"on"]) {
        [self setOnFlashMode];
    } else if([cameraFlashStates[activeState] isEqualToString:@"off"]) {
        [self setOffFlashMode];
    }
    
}

- (IBAction)capture:(id)sender {
    [stillCamera capturePhotoAsImageProcessedUpToFilter:filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);

        UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForJPEGFile], nil, nil, nil);
        return ;
    }];
}

- (IBAction)goToCameraRoll:(id)sender {
    [self presentViewController:imagePickerC animated:YES completion:nil];
}

- (IBAction)switchCameraSource:(id)sender {
    [stillCamera rotateCamera];
    cameraFront = !cameraFront;
    if (cameraFront) {
        _flashButton.hidden = YES;
    } else {
        _flashButton.hidden = NO;
    }
}
@end
