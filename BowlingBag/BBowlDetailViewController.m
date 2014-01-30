//
//  BBowlDetailViewController.m
//  BowlingBag
//
//  Created by Won Kim on 1/21/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "BBowlDetailViewController.h"
#import "UIImage+ResizeAdditions.h"
#import <Parse/Parse.h>
#define  kViewDetailMoveDistance 180
@interface BBowlDetailViewController ()
{
    IBOutlet UIImageView *imageView;
    
    IBOutlet UIView *detailView;
    IBOutlet UITextView *ballName;
    IBOutlet UITextView *descriptionBallTextView;
    IBOutlet UIImageView *ballNameBGImage;
    IBOutlet UIImageView *descriptionBGImage;
    
    
    IBOutlet UIView *dropdownView;

    IBOutlet UIButton *typeButton1;
    IBOutlet UIButton *typeButton2;
    IBOutlet UIButton *typeButton3;
    IBOutlet UIButton *typeButton4;
 
    IBOutlet UIView *cameraPopup;
    IBOutlet UIButton *photoEdit;
    UITapGestureRecognizer  *tapRecognizer;
    
    IBOutlet UIButton *deleteBowlButton;
    
    BBAppState* appState;
  
    
}
@property BOOL newMedia;

@property (nonatomic, strong) PFFile *photoFile;
@property (nonatomic, strong) PFFile *thumbnailFile;
@property (nonatomic, assign) UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;
@property (nonatomic, assign) UIBackgroundTaskIdentifier photoPostBackgroundTaskId;

@end

@implementation BBowlDetailViewController
@synthesize bowl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
	// Do any additional setup after loading the view.
//    
//    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [rightbutton setTitle:@"Edit" forState:UIControlStateNormal];
//   // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
//    [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
//    rightbutton.frame=CGRectMake(50,50,50,50);
//    
//    UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
//    self.navigationItem.rightBarButtonItem=customrightBarItem;
// //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
    
    
    appState=[BBAppState getInstance];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    //Notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    

   
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_onlyEditMode)
    {
        deleteBowlButton.hidden=FALSE;
        [self setEditMode:TRUE];
    }
    else
    {
        deleteBowlButton.hidden=TRUE;
    [self setEditMode:FALSE];
    }
    
    cameraPopup.hidden=TRUE;
    dropdownView.hidden=TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  -mark TextView delegate

-(void)textViewDidChange:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewShouldBeginEditing : %d",textView.tag);
    
    if(textView.tag==2)
    {
        //move view to up
        [self moveView:detailView From:0 Distance:-kViewDetailMoveDistance Speed:0.5 AxisX:FALSE];
    }
    return TRUE;
}
#pragma  -mark keypad visible Notification

-(void) keyboardWillShow:(NSNotification *) note {
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    
}

-(void) keyboardWillHide:(NSNotification *) note
{
    
    NSLog(@"keyboardWillHide %f",detailView.frame.origin.y);
    if(detailView.frame.origin.y==-kViewDetailMoveDistance)
    {
        [self moveView:detailView From:-kViewDetailMoveDistance Distance:kViewDetailMoveDistance Speed:0.5 AxisX:FALSE];
    }

    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [ballName resignFirstResponder];

    [descriptionBallTextView resignFirstResponder];

}
-(void)setEditMode:(BOOL)editmode
{

    typeButton1.userInteractionEnabled=editmode;
    
    descriptionBallTextView.selectable=editmode;
    descriptionBallTextView.editable=editmode;
    
    ballName.selectable=editmode;
    ballName.editable=editmode;
    
    if(editmode)
    {

        [ballNameBGImage setImage:[UIImage imageNamed:@"edit_box.png"]];
        [descriptionBGImage setImage:[UIImage imageNamed:@"edit_box.png"]];
    }
    else
    {
  
        [ballNameBGImage setImage:[UIImage imageNamed:@"text_box.png"]];
        [descriptionBGImage setImage:[UIImage imageNamed:@"text_box.png"]];
        
    }


    
    photoEdit.hidden=!editmode;
    if(editmode)
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightbutton setTitle:@"Save" forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressSave) forControlEvents:UIControlEventTouchUpInside];
        rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    else
    {
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightbutton setTitle:@"Edit" forState:UIControlStateNormal];
        // [rightbutton setTitleColor:kLightBlueColor forState:UIControlStateNormal ];
        [rightbutton addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
        rightbutton.frame=CGRectMake(50,50,50,50);
        
        UIBarButtonItem *customrightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
        self.navigationItem.rightBarButtonItem=customrightBarItem;
        
    }
    
    
}



#pragma -mark Button Action
- (IBAction)pressDeleteBowl:(id)sender {
    [self. navigationController popViewControllerAnimated:TRUE];

    
}


- (IBAction)PressCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];

        
        imagePicker.allowsEditing = YES;
        
        NSString* fileName=@"cameraMask_iphone4.png";
        CGRect frame=[[UIScreen mainScreen] bounds];
        if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (frame.size.height == 568)
            {
                fileName=@"cameraMask_iphone4.png";
                
            }
            else
            {
                //iphone 3.5 inch screen
            }
        }
        else
        {
            //[ipad]
        }
        
        UIView *view2 = [[UIView alloc] init];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:fileName]];
        imageview.frame =frame;
        
        [view2 addSubview:imageview];
        [view2 bringSubviewToFront:imageview];
        
        
        imagePicker.cameraOverlayView = view2;
        
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        // _newMedia = YES;
    }

    
}
- (IBAction)pressCameraRoll:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
//        UIView *view2 = [[UIView alloc] init];
//        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cameraMask.png"]];
//        imageview.frame = CGRectMake(0, 0, 640, 640);
//        
//        [view2 addSubview:imageview];
//        [view2 bringSubviewToFront:imageview];
//        
//        
//        imagePicker.cameraOverlayView = view2;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        // _newMedia = YES;
    }

    
}
- (IBAction)pressClosePopup:(id)sender {
    cameraPopup.hidden=TRUE;
}

-(void)pressEdit
{
    
     // [self performSegueWithIdentifier:@"EditBowlSegue" sender:nil];
    
    //Edit mode
    
    [self setEditMode:TRUE];
    
}
-(void)pressSave
{
    
    // [self performSegueWithIdentifier:@"EditBowlSegue" sender:nil];
    
    //Edit mode
    
    if(_onlyEditMode)
    {
        //go back to table
        [self. navigationController popViewControllerAnimated:TRUE];
        
    }
    else
    {
        [self setEditMode:FALSE];
    }
    
}
- (IBAction)pressPictureEdit:(UIButton*)sender {
    
    cameraPopup.hidden=FALSE;
 /*   if (_menuPickerPopover == nil) {
        
        
        if (_menuPicker == nil) {
            //Create the ColorPickerViewController.
            _menuPicker = [[BBPopoverMenuViewController alloc] initWithStyle:UITableViewStylePlain];
            
            //Set this VC as the delegate.
            _menuPicker.delegate = self;
        }
        
        _menuPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_menuPicker];
        
    }
    
    if(_menuPickerPopover.popoverVisible)
    {
        [_menuPickerPopover dismissPopoverAnimated:YES];
        _menuPickerPopover=nil;
    }
    else
        [_menuPickerPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
*/
    
}

- (IBAction)pressTypeButton:(UIButton *)sender {
    
    int index=[self getTypeInt:sender.titleLabel.text];

    [self showDropDown:dropdownView.hidden withType:index];
    
    
}




#pragma mark - Popover methods
-(void)menuItemSelected:(int)menuItem   {
    
    //Dismiss the popover if it's showing.
    if (_menuPickerPopover) {
        [_menuPickerPopover dismissPopoverAnimated:YES];
        _menuPickerPopover = nil;
        //   _menuPicker=nil;
    }
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        
      //   CGRect frame=[[UIScreen mainScreen] bounds];
        if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
//            if (frame.size.height == 568)
//            {
//                UIImage* maskImage = [self maskImage:image withMask:[UIImage imageNamed:@"imageMask.png"]];
//                
//                imageView.image=[self scaleAndRotateImage:maskImage];
//                
//            }
//            else
//            {
//                //iphone 3.5 inch screen
//                
//                 UIImage* maskImage = [self resizeImage:image toSize:CGSizeMake(247, 247)];
//                
//                imageView.image=[self maskImage:maskImage withMask:[UIImage imageNamed:@"imageMask_iphone4.png"]];
//            }
//            
            UIImage* maskImage = [self resizeImage:image toSize:CGSizeMake(247, 247)];
            
            imageView.image=[self maskImage:maskImage withMask:[UIImage imageNamed:@"imageMask_iphone4.png"]];
        }
        else
        {
            //[ipad]
        }
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
	CGImageRef maskRef = maskImage.CGImage;
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	return [UIImage imageWithCGImage:masked];
    
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)destSize{
    float currentHeight = image.size.height;
    float currentWidth = image.size.width;
    float liChange ;
    CGSize newSize ;
    if(currentWidth == currentHeight) // image is square
    {
        liChange = destSize.height / currentHeight;
        newSize.height = currentHeight * liChange;
        newSize.width = currentWidth * liChange;
    }
    else if(currentHeight > currentWidth) // image is landscape
    {
        liChange  = destSize.width / currentWidth;
        newSize.height = currentHeight * liChange;
        newSize.width = destSize.width;
    }
    else                                // image is Portrait
    {
        liChange = destSize.height / currentHeight;
        newSize.height= destSize.height;
        newSize.width = currentWidth * liChange;
    }
    
    
    UIGraphicsBeginImageContext( newSize );
    CGContextRef                context;
    UIImage                     *outputImage = nil;
    
    context = UIGraphicsGetCurrentContext();
    [image drawInRect:CGRectMake( 0, 0, newSize.width, newSize.height )];
    outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef;
    int x = (newSize.width == destSize.width) ? 0 : (newSize.width - destSize.width)/2;
    int y = (newSize.height == destSize.height) ? 0 : (newSize.height - destSize.height )/2;
    if ( ( imageRef = CGImageCreateWithImageInRect( outputImage.CGImage, CGRectMake(x, y, destSize.width, destSize.height) ) ) ) {
        outputImage = [[UIImage alloc] initWithCGImage: imageRef] ;
    }
    CGImageRelease(imageRef);
    return  outputImage;
}
#pragma mark - transition functions
-(void)moveView:(id)aView From:(float)from Distance:(float)dist Speed:(float)speed AxisX:(BOOL)axisX
{
    if(![aView isKindOfClass:[UIView class]])
        return;
    
    UIView* view=(UIView*)aView;
    
    CGRect frame=view.frame;
    if(axisX)
    {
        frame.origin.x=from;
        view.frame=frame;
        frame.origin.x=from+dist;
    }
    else
    {
        frame.origin.y=from;
        view.frame=frame;
        frame.origin.y=from+dist;
    }
    
    [UIView animateWithDuration:speed animations:^{
        view.frame = frame;
    }];
    
}


#pragma mark -Parse 

- (BOOL)uploadImage:(UIImage *)anImage {
    // Resize the image to be square (what is shown in the preview)
    UIImage *resizedImage = [anImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit
                                                          bounds:CGSizeMake(560.0f, 560.0f)
                                            interpolationQuality:kCGInterpolationHigh];
    // Create a thumbnail and add a corner radius for use in table views
    UIImage *thumbnailImage = [anImage thumbnailImage:86.0f
                                    transparentBorder:0.0f
                                         cornerRadius:10.0f
                                 interpolationQuality:kCGInterpolationDefault];
    
    // Get an NSData representation of our images. We use JPEG for the larger image
    // for better compression and PNG for the thumbnail to keep the corner radius transparency
    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
    NSData *thumbnailImageData = UIImageJPEGRepresentation(thumbnailImage, 0.8f);
    
    if (!imageData || !thumbnailImageData) {
        return NO;
    }
    
    self.photoFile = [PFFile fileWithData:imageData];
    self.thumbnailFile = [PFFile fileWithData:thumbnailImageData];
    
    // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
    self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];
    
    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
            }];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
        }
    }];
    
    return YES;


}

#pragma mark -DropDownList

-(void)setDropDownList:(int)type
{
    [typeButton1 setTitle:appState.typeName[type] forState:UIControlStateNormal];
    [typeButton2 setTitle:appState.typeName[(type+1)%4] forState:UIControlStateNormal];
    [typeButton3 setTitle:appState.typeName[(type+2)%4]forState:UIControlStateNormal];
    [typeButton4 setTitle:appState.typeName[(type+3)%4] forState:UIControlStateNormal];
}

-(void)showDropDown:(BOOL)show withType:(int)type
{
    dropdownView.hidden=!show;
    if(show)
    {
        [typeButton1 setBackgroundImage:[UIImage imageNamed:@"edit_box.png"] forState:UIControlStateNormal];
        
    }
    else
    {
          [typeButton1 setBackgroundImage:[UIImage imageNamed:@"text_box.png"] forState:UIControlStateNormal];
    }
    [self setDropDownList:type];
}

-(int)getTypeInt:(NSString*)title
{
    
    for(int i=0;i<appState.typeName.count;i++)
    {
        if([title isEqualToString:appState.typeName[i]])
        {
            return i;
        }
    }
    
    return 0;
}



@end
