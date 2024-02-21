//
//  PlantifyWidget.swift
//  PlantifyWidget
//
//  Created by lana alfaadhel on 20/02/2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct PlantifyWidgetEntryView : View {
    
    
    var entry: Provider.Entry

    var body: some View {
        
        VStack {
            HStack{
                Text("Today")
                    .font(.system(.title2, design: .rounded) )
                    .bold()
                
                Spacer()
                
                Text("0")
                    .font(.system(.title2, design: .rounded) )
                    .bold()
                    .foregroundColor(.icons)
                
                

                    
            }
            
//            if viewModelsCoordinator.checkCards.isEmpty {
//                
//                VStack{
//                    
//                }
//                .frame(width: 120, height: 70)
//            } else{
                
                
                
//                ForEach(viewModelsCoordinator.checkCards, id: \.self){
//                    checkcard in
                    
                    VStack{
                        
                        HStack{
                            
                            
                            Button(action: {
//                                viewModelsCoordinator.wateringDone(checkCard: checkcard, WateringPerWeek: checkcard.watering)
                            }, label: {
                                Circle()
                                    .stroke(
                                        Color.icons,
                                        style: StrokeStyle(lineWidth: 2)
                                    )
                                    .frame(width: 12)
                                
                            })
  
                            
                            
//                            Text("\(checkcard.plantName)")
//                                .font(.system(size: 15))
                            
                            
                            
                            
                            
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
//    }
//}

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
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PlantifyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    PlantifyWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
