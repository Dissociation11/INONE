import { LongFormModel, LongFormModelList } from '../model/LongFormModel'

export class LongFormViewModel{
  private formList : LongFormModel[] = LongFormModelList

  getLongFormList() : LongFormModel[] {
    return this.formList
  }

}

export default new LongFormViewModel()