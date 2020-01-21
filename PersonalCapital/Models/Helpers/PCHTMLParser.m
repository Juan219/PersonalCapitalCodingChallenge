//
//  PCHTMLParser.m
//  PersonalCapital
//
//  Created by Juan Balderas on 16/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCHTMLParser.h"
#import "PCXMLParserConstants.h"

@interface PCHTMLParser() <NSXMLParserDelegate>

@property (nonatomic, copy) NSArray *nodeNames;

@property (nonatomic, strong) NSXMLParser *xmlParser;

@property (nonatomic, copy) NSMutableArray *nodes;

@property (nonatomic, strong) NSMutableDictionary *node;
@property (nonatomic, strong) NSMutableArray *propertyNode;
@property (nonatomic, strong) NSDictionary *attributes;

@property (nonatomic, copy) NSString *nodeKey;
@property (nonatomic, copy) NSString *nodeValue;

@property (nonatomic, strong) HTMLParserCompletionBlock completionBlock;

@end

@implementation PCHTMLParser

- (instancetype)initWithNodeNames:(NSArray *)nodeNames
{
    self = [super init];
    if (self) {
        self.nodeNames = nodeNames;
    }
    return self;
}

//Lazy load
-(NSMutableArray *)nodes {
    if (_nodes == nil) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return _nodes;
}

-(void)parseFromData:(NSData *)data completionBlock:(HTMLParserCompletionBlock)completion {
    self.completionBlock = completion;
    self.xmlParser = [[NSXMLParser alloc] initWithData:data];
    self.xmlParser.delegate = self;
    [self.xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([_nodeNames containsObject:elementName]) {
        //Create node
        self.node = [NSMutableDictionary new];
    } else if (self.node != nil) {
        self.nodeKey    = elementName;
        self.nodeValue  = nil;
        self.attributes = attributeDict != nil ? attributeDict : [NSDictionary new];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([_nodeNames containsObject:elementName]) {
        //Add node to the array
        [self.nodes addObject:self.node];
        self.nodeKey = nil;
        self.nodeValue = nil;
        self.node = nil;
    } else if (self.nodeKey != nil && self.node != nil) {

        NSMutableDictionary *iProperty = [NSMutableDictionary new];

        if (self.nodeValue != nil) {
            [iProperty setObject:self.nodeValue forKey:node_value];
        }

        if (self.attributes != nil) {
            [iProperty setObject:self.attributes forKey:node_attributes];
        }

        [self.node setObject:iProperty forKey:self.nodeKey];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completionBlock) {
        self.completionBlock(true, [self.nodes copy]);
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    //Handle parsing error.
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *iString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    iString = [iString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if (self.nodeValue == nil) {
        self.nodeValue = @"";
    }
    self.nodeValue = [self.nodeValue stringByAppendingString:iString];
}

@end
