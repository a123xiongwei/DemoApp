//
//  Settings.m
//  VTScaleDemo
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+ (instancetype)sharedSettings
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _gender = [userDefaults integerForKey:@"gender"];
        _age = [userDefaults integerForKey:@"age"];
        
        if (0 == _age)
        {
            _age = 20;
            [userDefaults setInteger:_age forKey:@"age"];
        }

        _height = [userDefaults integerForKey:@"height"];
        
        if (0 == _height)
        {
            _height = 170;
            [userDefaults setInteger:_height forKey:@"height"];
        }
    }
    
    return self;
}

- (void)setGender:(NSUInteger)gender
{
    _gender = gender;
    [self save];
}

- (void)setAge:(NSUInteger)age
{
    _age = age;
    [self save];
}

- (void)setHeight:(NSUInteger)height
{
    _height = height;
    [self save];
}

- (void)save
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.gender forKey:@"gender"];
    [userDefaults setInteger:self.age forKey:@"age"];
    [userDefaults setInteger:self.height forKey:@"height"];
}

@end
