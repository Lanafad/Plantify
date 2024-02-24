//
//  PlantifyWidget.swift
//  PlantifyWidget
//
//  Created by lana alfaadhel on 24/02/2024.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), checkCards: getChecCards())
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), checkCards: getChecCards())
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        let timeline = Timeline(entries: [SimpleEntry(date: .now, checkCards: getChecCards())], policy: .after(.now.advanced(by: 60 * 5)))
        completion(timeline)
    }
    
    @MainActor private func getChecCards() -> [CheckCard]{
        guard let modelContainer = try? ModelContainer(for: CheckCard.self) else {
            return []
        }
        
        let descriptor = FetchDescriptor<CheckCard>()
        let checkCards = try? modelContainer.mainContext.fetch(descriptor)
        
        return checkCards ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let checkCards : [CheckCard]
}

struct PlantifyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack{
                Text("Today")
                    .font(.system(.title2, design: .rounded) )
                    .foregroundStyle(.titleText)
                    .bold()
                
                Spacer()
                
                Text("\(entry.checkCards.count)")
                    .font(.system(.title2, design: .rounded) )
                    .bold()
                    .foregroundColor(.icons)
            }
            
                        if (entry.checkCards.isEmpty) {
            
                            VStack{
                                Text("no watering today")
                                    .font(.system(.title2, design: .rounded) )
                                    .foregroundStyle(.titleText)

                            }
                            .frame(width: 120, height: 70)
                        } else{
                            
                            
                            ForEach(entry.checkCards) { checkCard in
                                
                                VStack{
                                    HStack{
                                        Button {} label: {
                                            Circle()
                                                .stroke(
                                                    Color.icons,
                                                    style: StrokeStyle(lineWidth: 2)
                                                )
                                                .frame(width: 12)
                                        }
                                        
                                        Text(checkCard.plantName)
                                            .font(.system(size: 15))

                                    }
                                    .frame(width: 100, alignment: .leading)
                                    
                                    Line()
                                        .stroke(style: .init(dash: [1]))
                                        .frame(width: 90)
                                        .opacity(0.5)
                                        .frame(width: 100, alignment: .trailing)

                                }
                                
                            }
                        }
                }
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct PlantifyWidget: Widget {
    let kind: String = "PlantifyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PlantifyWidgetEntryView(entry: entry)
                    .containerBackground(.screenBackground, for: .widget)
            } else {
                PlantifyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    PlantifyWidget()
} timeline: {
    SimpleEntry(date: .now, checkCards : [] )
//    SimpleEntry(date: .now, checkCards : [] )
}
