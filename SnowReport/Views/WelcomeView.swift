import SwiftUI

struct WelcomeView: View {
  var body: some View {
    VStack(spacing: 24) {
      Image(systemName: "snow")
        .font(.system(size: 80))
        .foregroundStyle(
          LinearGradient(
            colors: [.blue, .blue.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .background(
          Circle()
            .fill(.white)
            .frame(width: 120, height: 120)
            .shadow(radius: 2)
        )
      
      VStack(spacing: 8) {
        Text("Snow Report")
          .font(.title)
          .bold()
        
        Text("Find snow conditions at your favorite resorts")
          .multilineTextAlignment(.center)
          .foregroundStyle(.secondary)
          .padding(.horizontal)
      }
      
      Image(systemName: "magnifyingglass.circle.fill")
        .font(.system(size: 40))
        .foregroundStyle(
          LinearGradient(
            colors: [.blue, .blue.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .padding(.top)
      
      Text("Tap the search icon above to get started")
        .font(.callout)
        .foregroundStyle(.secondary)
    }
    .padding()
  }
}

#Preview {
  WelcomeView()
} 
