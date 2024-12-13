//
//  ContentView.swift
//  Icon
//
//  Created by Maxim Frolov on 12/12/24.
//

import SwiftUI

struct RenderView: View {
    static var size: CGFloat = 1024
    
    var body: some View {
        ZStack {
            Color.black
//            RoundedRectangle(cornerRadius: 200, style: .continuous)
//                .strokeBorder(lineWidth: Self.size / 60)
//                .foregroundStyle(.white)
//                .padding(Self.size / 18)
            Circle()
                .strokeBorder(lineWidth: Self.size / 35)
                .foregroundStyle(.white)
                .frame(width: Self.size / 2, height: Self.size / 2)
            Circle()
                .stroke(.white, style: StrokeStyle(
                    lineWidth: Self.size / 30,
                    lineCap: .round,
                    dashPhase: 0
                ))
                .rotationEffect(.radians(.pi / 3))
                .frame(width: Self.size / 30, height: Self.size / 30)
        }
        .frame(width: Self.size, height: Self.size)
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
