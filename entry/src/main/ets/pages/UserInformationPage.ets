import { UserInformationView } from '../view/UserInformationView'

@Component
@Entry
struct UserInformationPage{

  build(){
    Column(){
      UserInformationView()
    }
  }
}