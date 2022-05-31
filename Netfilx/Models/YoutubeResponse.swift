//
//  YoutubeResponse.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 31/05/2022.
//

import Foundation
/*
 items =     (
             {
         etag = eFcHWsmBfp9jlj7SZcHtaNAk9Rk;
         id =             {
             kind = "youtube#video";
             videoId = "drtIAeuyq_E";
         };
 */

struct YoutubeResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideoElement
}
struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}
