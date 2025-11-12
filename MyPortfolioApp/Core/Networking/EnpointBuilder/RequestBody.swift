//
//  RequestBody.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

// MARK: - RequestBody
enum RequestBody {
    case rawData(Data)
    case encodable(Encodable)
    case multipartBody([MultipartItem])
}

// MARK: - MultipartBody
struct MultipartBody {
    let boundary: String
    let multipartData: Data
    let length: Int
}

// MARK: - MultipartItem
struct MultipartItem {
    let data: Data
    var attachmentKey: String = ""
    let fileName: String
    var mimeType: MimeType = .defaultType
}

// MARK: - MimeType
enum MimeType: String {
    case imagePng = "image/png"
    case imageJpeg = "image/jpeg"
    case textPlain = "text/plain"
    case videoMp4 = "video/mp4"
    case defaultType = "file"
}
