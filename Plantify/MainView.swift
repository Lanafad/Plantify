//
//  MainView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//


import SwiftUI
import SwiftData
import WidgetKit

struct MainView: View {
    
    
    @State private var PickerSelection = 0
    
    @Query var PlantCards : [PlantCard]
    @Query var checkCards: [CheckCard]
    @Query var Plants : [Plant]

    @State var isShowingSheet = false

    @State var progress : CGFloat = 0
    @State var checkWatering = 0
    
    @Environment(\.modelContext) var context

    
    // The View
    var body: some View {
        
        
        NavigationStack{
            
            ZStack{
                VStack{
                    
                    HStack{
                        Text("Watering")
                            .font(Font.title2.bold())
                            .foregroundColor(.titleText)
                        
                        Spacer()
                        
                        
                        NavigationLink(destination: SeeAllView(checkCards: checkCards), label:
                                        {
                            Text("See All")
                                .font(.system(size: 12,weight: .light))
                            .foregroundColor(.buttonsBackground)})
                        
                    }
                    
                    Picker("Watering", selection: $PickerSelection){
                        Text("Today")
                            .tag(0)
                        Text("Next Week")
                            .tag(1)
                        Text("Overdue")
                            .tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)
                    
                    
                    
                    if (checkCards.isEmpty){
                        
                        VStack{
                            
                            
                            Image(systemName: "zzz")
                                .font(.system(size: 32))
                                .foregroundColor(.icons)
                                .padding()
                            
                            Text("You don't have any plants that need watering!")
                                .font(.caption)
                                .foregroundColor(.subtitleText)
                        }
                        .frame(width: 350, height: 270, alignment: .center)
                        
                        
                    } else {
                        
                        ScrollView{
                        VStack{
                            
                            ForEach(checkCards , id: \.self){
                                CheckCard in
                                ZStack{
                                    
                                    RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                                        .fill(Color(.cardBackground))
                                        .frame(width: 350, height: 66)
                                    
                                    HStack{
                                        
                                        Button(action: {
                                            wateringDone(checkCard: CheckCard, WateringPerWeek: CheckCard.watering)
                                            
                                            WidgetCenter.shared.reloadTimelines(ofKind: "PlantifyWidget")

                                            
                                        }, label: {
                                            
                                            Circle()
                                                .stroke(
                                                    Color.icons,
                                                    style: StrokeStyle(lineWidth: 2))
                                                .frame(width: 24,height: 24)
                                                .padding()
                                        })
                                        
                                        
                                        
                                        VStack(alignment: .leading){
                                            Text("\(CheckCard.plantName)")
                                                .font(.title3)
                                                .foregroundColor(.bodyText)
                                            
                                            Text("\(CheckCard.plantType.rawValue)")
                                                .font(.caption)
                                                .foregroundColor(.subtitleText)
                                        }
                                        
                                    }
                                    .frame(width: 350, height: 66, alignment: .leading)
                                    
                                }
                            }
                            
                        }
                        
                    }
                        .frame(width: 350, height: 270, alignment: .top)

                        
                    }
                    
                    
                    
                    
                    HStack{
                        Text("Office Plants")
                            .font(Font.title2.bold())
                            .foregroundColor(.titleText)
                        
                        Spacer()
                        
                        Button(action: {
                            isShowingSheet.toggle()

                            
                            print("Is Showing Sheet: \(isShowingSheet)")
                            
                        },label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.buttonsBackground)
                        })
                        .sheet(isPresented: $isShowingSheet, content: {
                            PlantSheet(isShowingSheet: isShowingSheet)
                        })
                        
                        
                    }
                    
                    
                    
                    if (PlantCards.isEmpty){
                        
                        VStack{
                            
                            Image(systemName: "leaf")
                                .font(.system(size: 32))
                                .foregroundColor(.icons)
                                .padding()
                            
                            Text("Tap  ")
                                .font(.system(size: 17))
                                .foregroundColor(.subtitleText)
                            + Text(Image(systemName: "plus"))
                                .font(.system(size: 22))
                                .foregroundColor(.buttonsBackground)
                            + Text(" to add one")
                                .font(.system(size: 17))
                                .foregroundColor(.subtitleText)
                            
                            Text("You can add all plants you have in your office!")
                                .font(.caption)
                                .foregroundColor(.subtitleText)
                            
                            
                        }
                        .frame(height: 270)
                    } else {
                        
                        ScrollView{
                            
                            
                            ForEach(PlantCards, id: \.self){
                                PlantCard in
                                
                                NavigationLink(destination: EditPlantView(plantCard: PlantCard), label:{
                                    ZStack{
                                        RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                                            .fill(.cardBackground)
                                            .frame(width: 350, height: 128)
                                        
                                        HStack{
                                            ZStack{
                                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                                    .fill(.screenBackground)
                                                    .frame(width: 112, height: 112)
                                                
                                                Image(systemName: "camera.macro")
                                                    .font(.system(size: 32))
                                                    .foregroundColor(.primaryGreen)
                                                
                                            }
                                            
                                            VStack(alignment: .leading){
                                                Text("\(PlantCard.PlantName)")
                                                    .font(.title3)
                                                    .foregroundColor(.bodyText)
                                                
                                                RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                                                    .fill(.tagsBackground)
                                                    .frame(height: 21)
                                                    .overlay(
                                                        HStack{
                                                            Image(systemName: "leaf")
                                                                .font(.system(size: 11))
                                                                .foregroundColor(.icons)
                                                            
                                                            Text("\(PlantCard.PlantType.rawValue)")
                                                                .font(.caption2)
                                                                .foregroundColor(.bodyText)
                                                        }
                                                    )
                                                RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                                                    .fill(.tagsBackground)
                                                    .frame(width: 95, height: 21)
                                                    .overlay(
                                                        HStack{
                                                            Image(systemName: "hourglass.bottomhalf.filled")
                                                                .font(.system(size: 11))
                                                                .foregroundColor(.icons)
                                                            
                                                            Text("0 weeks old")
                                                                .font(.caption2)
                                                                .foregroundColor(.bodyText)
                                                        }
                                                    )
                                            }
                                            .frame(width: 95)
                                            
                                            ZStack{
                                                Circle()
                                                    .fill(.tagsBackground)
                                                    .frame(width: 71)
                                                
                                                Circle()
                                                    .trim(from: 0, to: progress )
                                                    .stroke(
                                                        Color.buttonsBackground,
                                                        style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                                    .frame(width: 71)
                                                    .rotationEffect(.degrees(-90))
                                                
                                                
                                                VStack{
                                                    Image(systemName: "drop")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.icons)
                                                    
                                                    Text("\(PlantCard.Watering) / week")
                                                        .font(.caption2)
                                                        .foregroundColor(.subtitleText)
                                                }
                                            }
                                            .frame(width: 95)

                                        }
                                        .frame(width: 350, height: 128)

                                    }
                                        .contextMenu{
                                            Button("Delete"){
                                                context.delete(PlantCard)
                                            }
                                        }
                                })
                                
                                
                            }

                        }
                    }
                    
                    
                }
                
            }
            .padding()
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Plants")
                        .foregroundColor(.titleText)
                        .font(.headline)
                }
            }
            .toolbarBackground(Color(.screenBackground) , for: .navigationBar)
            .toolbarBackground(.visible)
            
            
        }
        .accentColor(.buttonsBackground)
        
    }
    
    // the functions
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .buttonsBackground
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.screenBackground], for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.bodyText], for: .normal)
    }
    
    
    enum PlantTypes : String, Hashable, Codable {
        case succulents = "Succulents"
        case ferns = "Ferns"
        case pothos = "Pothos"
        case peaceLilies = "Peace lilies"
        case ficus = "Ficus"
        case palm = "Palm"
        case none = ""
    }
    
    enum PotSize : String, Hashable, Codable  {
        case four = "4-6 inch"
        case six = "6-10 inch"
        case ten = "10-16 inch+"
        case none = ""
    }
    
    enum Lighting : String, Hashable, Codable  {
        case direct = "direct light"
        case partial = "partial light"
        case noLight = "no light"
        case none = ""
    }
    
    func wateringDone(checkCard : CheckCard, WateringPerWeek : Int){
        
            checkWatering += 1
            print("watering progress \(progress)")
            
            progress = CGFloat(checkWatering) / CGFloat(WateringPerWeek)
            
            print("watering progress updated \(progress)")
            
            
                    if (checkWatering == WateringPerWeek){
            
            
            if let index = checkCards.firstIndex(of: checkCard){
                context.delete(checkCards[index])
                print("card removed\(checkCards)")
            }
            
                    }
    }


    // the sheet
    
    struct PlantSheet : View {
        
        
        @State var selectedType : PlantTypes = .none
        @State var selectedPot : PotSize = .none
        @State var selectedLight : Lighting = .none
        @State var selectedName: String = ""
        @State var selectedWatering = 0
        
        @State var types : [PlantTypes] = [.succulents, .ferns, .pothos, .palm, .peaceLilies, .ficus]
        @State var pots : [PotSize] = [.four, .six, .ten]
        @State var lights : [Lighting] = [.direct, .partial, .noLight]
        
        @State var successfullyNavigation = false
        @State var isSelected = false
        @State var isShowingSheet : Bool
        
        @Environment(\.modelContext) var context
        @Environment (\.dismiss) var dismiss


        
        var body: some View {
            VStack {

                    NavigationStack {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 350,height: 46)
                                .foregroundColor(.cardBackground)
                            HStack{
                                Text("Name")
                                TextField("Coco “or app name!", text: $selectedName)
                            }
                            .padding()
                        }
                        
                        
                        Section(header: HStack { Text("Plant Type").frame(width: 350, alignment: .leading) }) {
                            LazyVGrid(columns: [
                            GridItem(),
                            GridItem(),
                            GridItem(),
                            GridItem()
                            
                        ] , spacing: 10, content: {
                            ForEach(types,id: \.self) { plant in
                                Button {
                                    selectedType = plant
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(selectedType == plant ? .buttonsBackground : .cardBackground)
                                            .frame(height: 46)
                                        
                                        Text(plant.rawValue)
                                            .font(.caption)
                                            .foregroundColor(selectedType == plant ? .screenBackground : .bodyText)
                                    }
                                }
                            }})}
                            .padding(8)
                        Section(header: HStack { Text("Pot Size") }.frame(width: 350, alignment: .leading)) {     LazyVGrid(columns: [
                            GridItem(),
                            GridItem(),
                            GridItem(),
                            GridItem()
                            
                        ] , spacing: 10, content: {
                            ForEach(pots,id: \.self) { pot in
                                Button {
                                    selectedPot = pot
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(selectedPot == pot ? .buttonsBackground : .cardBackground)
                                            .frame(height: 46)
                                        
                                        Text(pot.rawValue)
                                            .font(.caption)
                                            .foregroundColor(selectedPot == pot ? .screenBackground : .bodyText)
                                    }
                                }
                            }})}
                            .padding(8)
                        Section(header: HStack { Text("Light") }.frame(width: 350, alignment: .leading)) {
                            LazyVGrid(columns: [
                            GridItem(),
                            GridItem(),
                            GridItem(),
                            GridItem()
                            
                        ] , spacing: 10, content: {
                            ForEach(lights,id: \.self) { light in
                                Button {
                                    selectedLight = light
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(selectedLight == light ? .buttonsBackground : .cardBackground)
                                            .frame(height: 46)
                                        
                                        Text(light.rawValue)
                                            .font(.caption)
                                            .foregroundColor(selectedLight == light ? .screenBackground : .bodyText)
                                    }
                                }
                            }})}
                            .padding(8)
                        

                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 350,height: 46)
                                .foregroundColor(.cardBackground)
                            HStack{
                                Text("Watering")
                                    Spacer()
                                TextField("0", value: $selectedWatering, format: .number)
                                Text("/ week")
                            }
                            .padding()
                        }
                        
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                dismiss()
                            }.foregroundColor(.buttonsBackground),
                            
                            trailing:
                            HStack {
                                
                                    Button("Add") {
                                        
                                        
                                        
                                        context.insert(CreatePlant(PlantName: selectedName, PlantType: selectedType, PlantSize: selectedPot, PlantLight: selectedLight, Watering: selectedWatering))
                                        
                                        
                                        try! context.save()

                                        successfullyNavigation.toggle()
                                        
                                        WidgetCenter.shared.reloadTimelines(ofKind: "PlantifyWidget")
                                        }
                                    .foregroundColor(.buttonsBackground)

                                
        

                            }
                                .fullScreenCover(isPresented: $successfullyNavigation) {
                                    VStack {
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 100))
                                            .foregroundColor(.icons)
                                            .padding()
                                        
                                        Text("Successfully Added!!")
                                            .font(.title)
                                            .foregroundColor(.primary)
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            dismiss()
                                        }, label: {
                                            ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 358, height: 50)
                                                    .foregroundColor(.buttonsBackground)
                                                    .padding()
                                                
                                                Text("Done")
                                                    .font(.headline)
                                                    .foregroundColor(.screenBackground)
                                                    .padding()
                                            }
                                        })
                                    }
                                }
                        )
                        .navigationBarTitle("Add Office Plant", displayMode: .inline)

                    }
                    .padding()
            }
        }
        
        // the sheet functions

        func CreatePlant(PlantName : String, PlantType : PlantTypes, PlantSize : PotSize, PlantLight : Lighting, Watering : Int) -> Plant {
            
            
            let newCheckCard = CheckCard(plantName: selectedName, plantType: selectedType, watering: selectedWatering)
            
            
            let newPlantCard = PlantCard(PlantName: selectedName, PlantType: selectedType, PotSize: selectedPot, Light: selectedLight, Watering: selectedWatering)
            
            let newPlant = Plant(PlantName: selectedName, PlantType: selectedType, PotSize: selectedPot, Light: selectedLight, Watering: selectedWatering, PlantCard: newPlantCard, CheckCards: CreateCheckArray(CheckCard: newCheckCard, Watering))
            
            return newPlant

        }
        
        func CreateCheckArray(CheckCard : CheckCard, _ watering : Int) -> [CheckCard]{
            var arr = [CheckCard]
            
            for _ in 0..<watering {
                arr.append(CheckCard)
            }
            
            return arr
        }
    }
    
    
}
#Preview {
    MainView()
}
