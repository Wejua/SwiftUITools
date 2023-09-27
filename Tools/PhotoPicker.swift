//
//  PhotoPicker.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/17.
//

import SwiftUI
import PhotosUI

public struct PickOneImage<T: View>: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    public var label: () -> T
    public var completion: (UIImage) -> Void
    
    public init(label: @escaping ()->T, completion:@escaping (UIImage)->Void) {
        self.label = label
        self.completion = completion
    }
    
    public var body: some View {
        
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                label()
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            completion(uiImage)
                        }
                    }
                }
            }
    }
}

public struct PickImage<T: View>: View {
    var maxImageCount: Int
    var label: () -> T
    var completion: ([Image]) -> Void
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    public init(maxImageCount: Int, label: @escaping () -> T, completion: @escaping ([Image]) -> Void) {
        self.maxImageCount = maxImageCount
        self.label = label
        self.completion = completion
    }

    public var body: some View {
        PhotosPicker(selection: $selectedItems, maxSelectionCount: maxImageCount, label: label)
        .onChange(of: selectedItems) { newValue in
            Task {
                selectedImages.removeAll()
                
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            let image = Image(uiImage: uiImage)
                            selectedImages.append(image)
                        }
                    }
                }
                completion(selectedImages)
            }
        }
    }
}
