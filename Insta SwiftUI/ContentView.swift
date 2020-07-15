//
//  ContentView.swift
//  Insta SwiftUI
//
//  Created by Uske on 2020/07/11.
//  Copyright © 2020 Uske. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            TabView()
        }
    }
}

struct TabView: View {
    
    @State var index = 0
    @Environment(\.colorScheme) var scheme
    var colors = [Color("Color"), Color("Color-1")]
    
    var body: some View {
        
        // tabView with navigation bar...
        ZStack(alignment: .bottom) {
            
            // change view based on index
            
            if self.index == 0 {
                Home()
            } else if self.index == 1 {
                Search()
                    // hideing navigation bar for ramaining tabs..
                    .navigationBarHidden(true)
            } else if self.index == 2 {
                Notification()
                    .navigationBarHidden(true)
            } else {
                Profile()
                    .navigationBarHidden(true)
            }
            
            
            // TabView
            ZStack(alignment: .top) {
                HStack(spacing: 0){
                    
                    Button(action: {
                        self.index = 0
                    }, label: {
                        
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundColor(self.index == 0 ? Color.primary : Color.primary.opacity(0.25))
                            .padding(.horizontal)
                    })
                        .padding(.trailing, 30)
                    
                    Button(action: {
                        self.index = 1
                        
                    }, label: {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                            .foregroundColor(self.index == 1 ? Color.primary : Color.primary.opacity(0.25))
                            .padding(.horizontal)
                    })
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        self.index = 2
                        
                    }, label: {
                        
                        Image(systemName: "suit.heart.fill")
                            .font(.system(size: 24))
                            .foregroundColor(self.index == 2 ? Color.primary : Color.primary.opacity(0.25))
                            .padding(.horizontal)
                    })
                        .padding(.trailing, 30)
                    
                    Button(action: {
                        self.index = 3
                        
                    }, label: {
                        
                        Image(systemName: "person.crop.circle")
                            //                            .renderingMode(.original)
                            .font(.system(size: 24))
                            .foregroundColor(self.index == 3 ? Color.primary : Color.primary.opacity(0.25))
                            .padding(.horizontal)
                    })
                    
                }
                .padding(.horizontal)
                .padding(.top)
                    // because bottom edge is ignore
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(self.scheme == .dark ? Color.black : Color.white)
                    .clipShape(CShape())
                    .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: -5)
                
                // Button
                Button(action: {
                    // Do something
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding()
                        .background(LinearGradient(gradient: .init(colors: self.colors), startPoint: .topTrailing, endPoint: .bottomLeading))
                        .clipShape(Circle())
                        .shadow(radius: 1)
                })
                    
                    // Movining View up
                    .offset(y: -24)
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Search: View {
    
    var body: some View {
        // to occupie available remainig spaces..
        GeometryReader {_ in
            VStack {
                Text("Serach")
                
            }
        }
        
    }
    
}

struct Notification: View {
    
    var body: some View {
        // to occupie available remainig spaces..
        GeometryReader {_ in
            VStack {
                Text("Notification")
                
            }
        }
        
    }
    
}

struct Profile: View {
    
    var body: some View {
        // to occupie available remainig spaces..
        GeometryReader {_ in
            VStack {
                Text("Profile")
                
            }
        }
        
    }
    
}

struct CShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        // center curve...
        
        return Path{ path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // center curve
            path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
            
            
        }
    }
    
}

struct Home: View {
    
    var colors = [Color("Color"), Color("Color-1")]
    // to identify dark mode...
    @Environment(\.colorScheme) var schem
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ZStack(alignment: .bottomTrailing) {
                            
                            Image("allen_iverson")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18))
                                // for dark mode adoptin
                                .foregroundColor(.primary)
                            
                        }
                        
                        ForEach(2...8, id: \.self) { i in
                            
                            ZStack {
                                Image("p\(i)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                
                                // Ring....
                                Circle()
                                    .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center), lineWidth: 3)
                                    .frame(width: 68, height: 68)
                            }
                        }
                    }
                    .padding()
                }
                .background(self.schem == .dark ? Color.black : Color.white)
                .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: 5)
                
                // PostView
                ForEach(data) { i in
                    PostView(postData: i)
                }
            }
        }
        .padding(.bottom, 110)
            
        .navigationBarTitle("Instagram", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            
        }, label: {
            Image(systemName: "camera")
                .font(.system(size: 24))
                .foregroundColor(.gray)
        }), trailing:
            NavigationLink(destination: Text("Send Message"), label: {
                
                Image(systemName: "paperplane")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            })
            
        )
    }
}

struct PostView: View {
    
    var postData: Post
    @State var comment = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(spacing: 12) {
                
                Image(self.postData.profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(self.postData.user)
                    
                    Text(self.postData.time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "contextualmenu.and.cursorarrow")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                })
                
            }
            
            Image(self.postData.postImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 280)
                .cornerRadius(10)
                .padding(.vertical, 10)
            
            HStack(spacing: 20) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 24))
                        .foregroundColor(self.postData.liked ? .red : .gray)
                    
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                })
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                })
                
                
            }
            
            Text(self.postData.likes + " likes")
            
            Text(self.postData.postTitle)
                .padding(.top, 5)
            
            Button(action: {
                
            }, label: {
                Text("view all 133 comments")
                    .foregroundColor(.gray)
            })
                .padding(.vertical, 10)
            
            HStack(spacing: 15) {
                TextField("Add a comment", text: self.$comment)
                    .font(.system(size: 12))
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                })
                
            }
            .padding(.horizontal)
            .padding(.vertical,6)
            .background(Capsule().stroke(Color.gray, lineWidth: 1))
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

// Post View
struct Post: Identifiable {
    
    var id: Int
    var user: String
    var profile: String
    var postImage: String
    var postTitle: String
    var time: String
    var likes: String
    var liked: Bool
    
}

var data = [
    
    Post(id: 0, user: "Capcom", profile: "p2", postImage: "p5", postTitle: "New Resident Evil Village...", time: "24 min ago", likes: "1111", liked: true),
    
    Post(id: 1, user: "Capcom", profile: "p2", postImage: "p2", postTitle: "New Resident Evil Village...", time: "24 min ago", likes: "1111", liked: true),
    
    Post(id: 2, user: "Capcom", profile: "p2", postImage: "p3", postTitle: "New Resident Evil Village...", time: "24 min ago", likes: "1111", liked: true),
    
    Post(id: 3, user: "Capcom", profile: "p2", postImage: "p4", postTitle: "New Resident Evil Village...", time: "24 min ago", likes: "1111", liked: true)
    
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
