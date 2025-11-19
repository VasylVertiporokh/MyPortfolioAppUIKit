//
//  RequestBody.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

// MARK: - RequestBody

/// Represents the body of an HTTP request.
/// Used to define how data should be encoded and sent.
enum RequestBody {

    /// Sends raw binary data directly in the body.
    case rawData(Data)

    /// Sends an `Encodable` object that will be converted into JSON.
    case encodable(Encodable)

    /// Sends multipart form-data consisting of multiple items.
    case multipartBody([MultipartItem])
}

// MARK: - MultipartBody

/// Represents a fully constructed multipart form-data body,
/// including its boundary and total length.
struct MultipartBody {

    /// The boundary string separating multipart sections.
    let boundary: String

    /// The encoded multipart body data.
    let multipartData: Data

    /// The total byte length of the multipart body.
    let length: Int
}

// MARK: - MultipartItem

/// Represents a single item that will be included in a multipart form-data request.
struct MultipartItem {

    /// The raw binary data of the item (e.g., image bytes).
    let data: Data

    /// The form-data key under which this item will be uploaded.
    var attachmentKey: String = ""

    /// The filename sent to the server.
    let fileName: String

    /// The MIME type describing the content format.
    var mimeType: MimeType = .defaultType
}

// MARK: - MimeType

/// Represents supported MIME types for multipart uploads.
enum MimeType: String {

    /// PNG image format.
    case imagePng = "image/png"

    /// JPEG image format.
    case imageJpeg = "image/jpeg"

    /// Plain text format.
    case textPlain = "text/plain"

    /// MP4 video format.
    case videoMp4 = "video/mp4"

    /// Default fallback type for unspecified files.
    case defaultType = "file"
}
