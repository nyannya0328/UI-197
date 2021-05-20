//
//  Home.swift
//  UI-197
//
//  Created by にゃんにゃん丸 on 2021/05/20.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    @Environment(\.colorScheme) var scheme
    
    @State var selected = "Tweet"
    @Namespace var animation
    
    @State var tabBaroffset : CGFloat = 0
    
    @State var titleOffset : CGFloat = 0
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing:15){
                
                
                GeometryReader{proxy -> AnyView in
                    
                    let minY = proxy.frame(in:.global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    
                    
                    
                    return AnyView(
                    
                        
                        ZStack{
                            Image("p1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180)
                                .cornerRadius(0)
                                BlurView()
                                    .opacity(blueViewOpacity())
                            
                            VStack(spacing:5){
                                
                                Text("KING")
                                    .fontWeight(.bold)
                                
                                Text("200 TWEETS")
                                
                                
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0  : -gettitleOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                            
                            
                            
                            
                        }
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    
                    
                    )
                    
                    
                }
                .frame(height: 180)
                .zIndex(1)
                
                
                VStack{
                    
                    HStack{
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .background(Color("c"))
                            .clipShape(Circle())
                            .padding(8)
                            .background(scheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                            .offset(y: offset < 0 ? getOffset()-20 : -20)
                            .scaleEffect(getScale())
                        
                        
                        Spacer(minLength: 0)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Edite Profile")
                                .foregroundColor(.blue)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(
                                
                                Capsule()
                                    .stroke(Color.blue,lineWidth: 3)
                                
                                )
                        })
                        
                        
                        
                        
                        
                        
                    }
                    .padding(.top,-25)
                    .padding(.bottom,10)
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        Text("Lion King")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        
                        Text("@King")
                            .foregroundColor(.gray)
                        
                        Text("The lion is a species in the family Felidae and a member of the genus Panthera. It has a muscular, deep-chested body, short, rounded head, round ears, and a hairy tuft at the end of its tail. It is sexually dimorphic; adult male lions have a prominent mane.")
                            .font(.footnote)
                            
                        
                        HStack{
                            
                            
                            Text("16")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            
                            Text("Followers")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Text("15")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.leading,10)
                            
                            
                            Text("Following")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                        }
                        .padding(.top,8)
                        
                        
                    })
                    .overlay(
                    
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in:.global).minY
                            
                            
                            DispatchQueue.main.async {
                                
                                self.titleOffset = minY
                                
                            }
                            
                            
                            return Color.clear
                            
                            
                        }
                        .frame(width: 0, height: 0)
                    
                    )
                    
                    VStack(spacing:0){
                        
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            
                            HStack(spacing:0){
                                
                                
                                TabButton(title: "Tweet", selected: $selected, animation: animation)
                                
                                
                                TabButton(title: "Tweets & Likes", selected: $selected, animation: animation)
                                
                                
                                TabButton(title: "Likes", selected: $selected, animation: animation)
                                
                                
                                TabButton(title: "Media", selected: $selected, animation: animation)
                                
                                
                            }
                            
                            
                        })
                        
                        Divider()
                    }
                    .padding(.top,30)
                    .background(scheme == .dark ? Color.black : Color.white)
                    .offset(y: tabBaroffset < 120 ? -tabBaroffset + 120 : 0)
                    .overlay(
                    
                        
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in:.global).minY
                            
                            DispatchQueue.main.async {
                                
                                self.tabBaroffset = minY
                                
                            }
                            
                            
                            return Color.clear
                            
                            
                            
                        }
                        .frame(width: 0, height: 0)
                    
                    
                    )
                    .zIndex(1)
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        
                        
                        TweetView(tweet: "The Beautifull Women , I got lucky", tweetImage: "p2")
                        
                        
                        Divider()
                        
                        ForEach(1...20,id:\.self){_ in
                            
                            TweetView(tweet: sampleText)
                            
                            Divider()
                            
                            
                        }
                        
                        
                    })
                    .padding(.top)
                    .zIndex(0)
                    
                    
                    
                    
                    
                }
                .padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
                
              
                
            }
        })
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func gettitleOffset() -> CGFloat{
        
        let progress = 20 / titleOffset
        
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        
        return offset
        
        
    }
    
    
    func getOffset()->CGFloat{
        
         let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
        
        
        
    }
    
    
    func getScale()->CGFloat{
        
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
        
        
    }
    
    func blueViewOpacity()->Double{
        
        
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

struct TabButton : View {
    var title : String
    @Binding var selected : String
    var animation : Namespace.ID
    var body: some View{
        
        Button(action: {
            
            withAnimation{
                
                
                selected = title
            }
            
        }, label: {
            LazyVStack(spacing:10){
                
               Text(title)
                .fontWeight(.semibold)
                .foregroundColor(selected == title ? .blue : .gray)
                .padding(.horizontal)
                
                
                if selected == title{
                    
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                    
                    
                }
                else{
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                    
                }
                
                
                
                
                
            }
        })
        
        
        
    }
}

struct TweetView: View {
    
    var tweet : String
    var tweetImage : String?
    var body: some View {
        HStack(alignment: .top, spacing: 10, content: {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .background(Color("c"))
                .clipShape(Circle())
            
            
            
            VStack(alignment: .leading, spacing: 15, content: {
                
                
                (
                    
                    
                    Text("Lion King  ")
                        .fontWeight(.bold)
                        
                        +
                        
                        Text("@_King")
                        .foregroundColor(.gray)
                    
                )
                
                
                Text(tweet)
                    .frame(maxHeight: 100)
                
                
                
                if let tweetImage = tweetImage{
                    
                    
                    GeometryReader{proxy in
                        
                        
                        let width = proxy.frame(in:.global).width
                        
                        Image(tweetImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: 250)
                            .cornerRadius(15)
                        
                        
                        
                        
                    }
                    .frame(height: 250)
                    
                    
                }
                
                
                
            })
            
            
            
            
        })
    }
}

var sampleText = "The New York Mets will not have right-handed starter Jacob deGrom toeing the rubber for them when they continue their four-game series on Tuesday against the St. Louis Cardinals. Rather, the Mets scratched deGrom hours before first pitch because of right side tightness according to Anthony DiComo of MLB.com. Reliever Miguel Castro is expected to open the game for the Mets.The Mets later announced an MRI revealed inflammation in deGroms right lat, and he will not throw the next few days. He will not be placed on the injured list, however.Through deGroms first five starts this season, he had been in the midst of a historic run. He'd accumulated a 0.51 ERA (758 ERA+) and a 14.75 strikeout-to-walk ratio while averaging seven innings per outing. Put another way, deGrom had struck out 59 batters in 35 innings, all the while permitting 20 combined hits and walks. The Mets are, remarkably, just 2-3 in his starts because of their inability to provide him with any kind of meaningful run support. (Theyve been shut out in two of those contests.)It's unclear if deGrom's condition will necessitate a stay on the injured list, though Deesha Thosar of the New York Daily News reports that the Mets are hopeful he'll miss just the one start. The Mets did scratch Jordan Yamamoto from his scheduled start with their Triple-A affiliate on Tuesday, but according to Tim Britton of The Athletic manager Luis Rojas says the club may not activate him ahead of Tuesday's contest. Yamamoto could, conceivably, hang around for a few days to see if the Mets need additional length out of the bullpen."

