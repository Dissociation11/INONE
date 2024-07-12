import { LoginView } from '../view/LoginView'

@Entry
@Component
struct LoginPage{

  build() {
    Column(){
      LoginView()
    }.size({ height: "100%", width: "100%"})
  }
}