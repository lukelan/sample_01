//
//  NSString+trimSpecialCharacter.m
//  ADN
//
//  Created by Le Ngoc Duy on 12/2/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import "NSString+trimSpecialCharacter.h"

@implementation NSString (trimSpecialCharacter)
-(NSString *)trimSpecialCharacter
{
    NSMutableString *asciiCharacters = [NSMutableString string];
    for (NSInteger i = 32; i < 127; i++)  {
        [asciiCharacters appendFormat:@"%c", i];
    }
    NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:asciiCharacters] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:nonAsciiCharacterSet] componentsJoinedByString:@""];
}
@end