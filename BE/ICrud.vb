Public Interface ICrud(Of T)

    Function Add(objAdd As T) As Boolean
    Function Delete(objDel As T) As Boolean
    Function Update(objUpd As T) As Boolean
    Function ListAll() As List(Of T)
    Function ListById(objId As T) As T



End Interface
