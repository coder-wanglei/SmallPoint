//
//  LandScreenViewController.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/6.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "LandScreenViewController.h"


@interface LandScreenViewController ()

@property (nonatomic,assign) BOOL  isNormalOrientation;
@property (nonatomic,assign) CGRect  originRect;
@property (nonatomic,strong) UITextField  *txt;
@property (nonatomic,strong) UIView  *bgViewWhenKeyBoardShow;

@end

@implementation LandScreenViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad frame:%@",NSStringFromCGRect(self.view.frame));

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
    
    UIView *vTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenHeight, 44)];
    vTitle.backgroundColor = [UIColor grayColor];
    [self.view addSubview:vTitle];
 
    UIView *vBody = [[UIView alloc] initWithFrame:CGRectMake(0, 44, KScreenHeight, KScreenWidth - 44 - 44)];
    vBody.backgroundColor = [UIColor redColor];
    [self.view addSubview:vBody];
    
    UIView *vBottom = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenWidth - 44, KScreenHeight, 44)];
    vBottom.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:vBottom];
    
    UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(KScreenHeight - 100, KScreenWidth - 37, 60, 30)];
    btnComment.backgroundColor = [UIColor redColor];
    [btnComment setTitle:@"评论" forState:UIControlStateNormal];
    [btnComment addTarget:self action:@selector(beginComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnComment];
    
    self.txt = [[UITextField alloc] initWithFrame:CGRectMake(0, KScreenWidth, KScreenHeight - 44, 25)];
    _txt.backgroundColor = [UIColor blueColor];
    self.txt.placeholder = @"输入评论";
    [self.view addSubview:self.txt];
    
    _bgViewWhenKeyBoardShow = [UIView new];
    [self.view addSubview:_bgViewWhenKeyBoardShow];

}

-(void)beginComment{
    [_txt becomeFirstResponder];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear frame:%@",NSStringFromCGRect(self.view.frame));
}

-(void)keyboardWillShow:(NSNotification *)notification{
    NSLog(@"keyboardWillShow");
    CGSize keySize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.txt.frame = CGRectMake(0, KScreenHeight - keySize.height - 25, KScreenWidth - 44, 25);
        
    }];
    
    
    
}

-(void)keyboardWillHide:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.txt.frame = CGRectMake(0, KScreenHeight, KScreenWidth - 44, 25);
        
    }];
    
}

-(void)dealloc{
    NSLog(@"dealloc frame:%@",NSStringFromCGRect(self.view.frame));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 强制横屏(针对present方式)
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationLandscapeLeft);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
}

//必须有
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
