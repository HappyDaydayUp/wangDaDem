//
//  ZZLoginViewController.m
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/5/8.
//  Copyright © 2020 oldliu. All rights reserved.
//

#import "ZZLoginViewController.h"
#import "LoginViewModel.h"
@interface ZZLoginViewController ()<ZZBaseViewControllerProtocol>

@property(nonatomic ,strong)UITextField *accountTF;

@property(nonatomic ,strong)UITextField *passwordTF;

@property(nonatomic ,strong)UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;


@property(nonatomic ,strong)RACDisposable *disposable;


@end

@implementation ZZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"登录";
    
    
    
    
    // RAC监听按钮的点击事件
}

- (void)zz_addSubviews{
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(50);
        make.top.mas_offset(70);
    }];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(50);
        make.top.mas_offset(70*2);
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(50);
        make.top.mas_offset(70*3);
    }];
    
        [self setup];
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//          NSLog(@"创建信号量");
//        [subscriber sendNext:@"I'm send next data"];
//
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"销毁了");
//        }];;
//    }];
//
//   //2、订阅信号量
//    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    //主动触发取消订阅
//    [disposable dispose];
    
    //1创建信号，
//       RACSubject * subject = [RACSubject subject];
//
//       //2订阅信号
//       [subject subscribeNext:^(id  _Nullable x) {
//           NSLog(@"%@",x);
//       }];
//
//       //3发送数据
//       [subject sendNext:@"发送数据"];
   
//
//    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
//         NSLog(@"3 - %@",x);
//    }];
//
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.view.frame = CGRectMake(50, 60, 200, 200);
}
-(void)setup{
    
    RAC(self.loginVM,account) = _accountTF.rac_textSignal;
    RAC(self.loginVM,password) = _passwordTF.rac_textSignal;
    RAC(_loginBtn,enabled) = self.loginVM.btnEnableSignal;
    
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击按钮...");
        //        [self.loginVM.loginCommand execute:@{@"account":_accountTF.text,@"password":_passwordTF.text}];
        [self.loginVM.loginCommand execute:nil];
        
        self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            
        }];
    }];
    
    
//    [_accountTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
////           NSLog(@"%@",x);
//       }];
    
//
//    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//           NSLog(@"发送网络请求");
//
//           [subscriber sendNext:@"得到网络请求数据"];
//
//           return nil;
//       }];
       
//    RACMulticastConnection *connect = [signal publish];
//
//
//      [connect.signal subscribeNext:^(id x) {
//           NSLog(@"1 - %@",x);
//       }];
//
//       [connect.signal subscribeNext:^(id x) {
//           NSLog(@"2 - %@",x);
//       }];
//
//       [connect.signal subscribeNext:^(id x) {
//           NSLog(@"3 - %@",x);
//       }];
//
//       [connect connect];
//    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        NSLog(@"%@",input);
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//             [subscriber sendNext:@"大佬大佬放过我"];
//            return nil;
//        }];
//    }];
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//         NSLog(@"接受数据executionSignals---%@",x);
//
//    }];
//    [[command execute:@"开始飞起来"] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"接受数据---%@",x);
//
//    }];
}



#pragma mark --- lazy ---


-(UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc]init];
        _accountTF.placeholder = @"请输入用户名";
    }
    return _accountTF;
}
-(UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc]init];
        _passwordTF.placeholder = @"请输入密码";
    }
    return _passwordTF;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        [_loginBtn setTitleColor:[UIColor systemTealColor] forState:(UIControlStateNormal)];
        _loginBtn.backgroundColor = [UIColor secondarySystemFillColor];
    }
    return _loginBtn;
}

-(LoginViewModel *)loginVM{
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc]init];
    }
    return _loginVM;
}
@end
