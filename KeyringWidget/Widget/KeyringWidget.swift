//
//  KeyringWidget.swift
//  KeyringWidgetExtension
//
//  Created by 길지훈 on 2026-02-24.
//

import SwiftUI
import UIKit
import WidgetKit

// MARK: - Entry

struct KeyringEntry: TimelineEntry {
    let date: Date
    let customFrames: [UIImage]?
}

// MARK: - Provider

struct KeyringProvider: TimelineProvider {

    func placeholder(in context: Context) -> KeyringEntry {
        KeyringEntry(date: .now, customFrames: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (KeyringEntry) -> Void) {
        completion(KeyringEntry(date: .now, customFrames: loadFrames()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<KeyringEntry>) -> Void) {
        let entry = KeyringEntry(date: .now, customFrames: loadFrames())
        // .never — only updates when the app calls reloadAllTimelines()
        completion(Timeline(entries: [entry], policy: .never))
    }

    private func loadFrames() -> [UIImage]? {
        let frames = (0..<FrameStorage.frameCount).compactMap {
            FrameStorage.loadFrameImage(index: $0)
        }
        return frames.count == FrameStorage.frameCount ? frames : nil
    }
}

// MARK: - Entry View

struct KeyringWidgetView: View {
    var entry: KeyringEntry

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)

            if let frames = entry.customFrames {
                AnimatedFrameView(frames: frames, size: size, cycleDuration: 2.0)
                    .frame(width: geo.size.width, height: geo.size.height)
            } else {
                placeholderView
            }
        }
    }

    private var placeholderView: some View {
        VStack(spacing: 8) {
            Image(systemName: "photo.badge.plus")
                .font(.title)
                .foregroundStyle(.secondary)
            Text("Select an image\nin the app")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Widget

struct KeyringWidget: Widget {
    let kind = "KeyringWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: KeyringProvider()) { entry in
            KeyringWidgetView(entry: entry)
                .containerBackground(.clear, for: .widget)
        }
        .configurationDisplayName("Keyring")
        .description("A swinging keyring with your photo")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Bundle

@main
struct KeyringWidgetBundle: WidgetBundle {
    var body: some Widget {
        KeyringWidget()
    }
}
