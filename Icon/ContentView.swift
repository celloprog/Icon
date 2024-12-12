//
//  ContentView.swift
//  Icon
//
//  Created by Maxim Frolov on 12/12/24.
//

import SwiftUI

struct RenderView: View {
    let size: CGFloat = 1024
    
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: size / 5.5, style: .continuous)
                .strokeBorder(lineWidth: size / 70)
                .foregroundStyle(.white.opacity(0.8))
                .padding(size / 19)
            Circle()
                .strokeBorder(lineWidth: size / 35)
                .foregroundStyle(.yellow)
                .frame(width: size / 2, height: size / 2)
            Image(systemName: "control")
                .font(.system(size: size / 5, weight: .heavy))
                .foregroundStyle(.orange)
            
        }
        .frame(width: size, height: size)
    }
}

struct ContentView: View {
    @State private var renderedImage = Image(systemName: "photo")

    var body: some View {
        VStack {
            Spacer()
            renderedImage
                .resizable()
                .frame(width: 200, height: 200)
            Spacer()
            ShareLink("Export", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))
        }
        .background(Color.white)
        .onAppear { render() }
    }

    @MainActor func render() {
        let renderer = ImageRenderer(content: RenderView())

        // make sure and use the correct display scale for this device
        renderer.scale = 1

        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    ContentView().background(.gray)
}
