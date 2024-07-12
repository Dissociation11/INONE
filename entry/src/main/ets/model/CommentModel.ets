export class CommentModel{
  private _userId: number

  public set userId(value: number) {
    this._userId = value
  }

  public get userId(): number {
    return this._userId
  }

  private _comment: string

  public set comment(value: string) {
    this._comment = value
  }

  public get comment(): string {
    return this._comment
  }

  constructor(userId: number, comment: string, videoId: number) {
    this._userId = userId
    this._comment = comment
    this._videoId = videoId
  }

  

  private _videoId: number

  public set videoId(value: number) {
    this._videoId = value
  }

  public get videoId(): number {
    return this._videoId
  }
  
}