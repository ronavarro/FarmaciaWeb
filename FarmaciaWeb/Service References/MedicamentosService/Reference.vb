﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.42000
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Namespace MedicamentosService
    
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ServiceModel.ServiceContractAttribute(ConfigurationName:="MedicamentosService.MedicamentosServiceSoap")>  _
    Public Interface MedicamentosServiceSoap
        
        'CODEGEN: Generating message contract since element name pMedicamento from namespace http://tempuri.org/ is not marked nillable
        <System.ServiceModel.OperationContractAttribute(Action:="http://tempuri.org/CalcularPrecioVenta", ReplyAction:="*")>  _
        Function CalcularPrecioVenta(ByVal request As MedicamentosService.CalcularPrecioVentaRequest) As MedicamentosService.CalcularPrecioVentaResponse
        
        <System.ServiceModel.OperationContractAttribute(Action:="http://tempuri.org/CalcularPrecioVenta", ReplyAction:="*")>  _
        Function CalcularPrecioVentaAsync(ByVal request As MedicamentosService.CalcularPrecioVentaRequest) As System.Threading.Tasks.Task(Of MedicamentosService.CalcularPrecioVentaResponse)
        
        'CODEGEN: Generating message contract since element name pMedicamento from namespace http://tempuri.org/ is not marked nillable
        <System.ServiceModel.OperationContractAttribute(Action:="http://tempuri.org/ObtenerPrecioUnitario", ReplyAction:="*")>  _
        Function ObtenerPrecioUnitario(ByVal request As MedicamentosService.ObtenerPrecioUnitarioRequest) As MedicamentosService.ObtenerPrecioUnitarioResponse
        
        <System.ServiceModel.OperationContractAttribute(Action:="http://tempuri.org/ObtenerPrecioUnitario", ReplyAction:="*")>  _
        Function ObtenerPrecioUnitarioAsync(ByVal request As MedicamentosService.ObtenerPrecioUnitarioRequest) As System.Threading.Tasks.Task(Of MedicamentosService.ObtenerPrecioUnitarioResponse)
    End Interface
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.ServiceModel.MessageContractAttribute(IsWrapped:=false)>  _
    Partial Public Class CalcularPrecioVentaRequest
        
        <System.ServiceModel.MessageBodyMemberAttribute(Name:="CalcularPrecioVenta", [Namespace]:="http://tempuri.org/", Order:=0)>  _
        Public Body As MedicamentosService.CalcularPrecioVentaRequestBody
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal Body As MedicamentosService.CalcularPrecioVentaRequestBody)
            MyBase.New
            Me.Body = Body
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.Runtime.Serialization.DataContractAttribute([Namespace]:="http://tempuri.org/")>  _
    Partial Public Class CalcularPrecioVentaRequestBody
        
        <System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue:=false, Order:=0)>  _
        Public pMedicamento As String
        
        <System.Runtime.Serialization.DataMemberAttribute(Order:=1)>  _
        Public pCantidad As Integer
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal pMedicamento As String, ByVal pCantidad As Integer)
            MyBase.New
            Me.pMedicamento = pMedicamento
            Me.pCantidad = pCantidad
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.ServiceModel.MessageContractAttribute(IsWrapped:=false)>  _
    Partial Public Class CalcularPrecioVentaResponse
        
        <System.ServiceModel.MessageBodyMemberAttribute(Name:="CalcularPrecioVentaResponse", [Namespace]:="http://tempuri.org/", Order:=0)>  _
        Public Body As MedicamentosService.CalcularPrecioVentaResponseBody
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal Body As MedicamentosService.CalcularPrecioVentaResponseBody)
            MyBase.New
            Me.Body = Body
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.Runtime.Serialization.DataContractAttribute([Namespace]:="http://tempuri.org/")>  _
    Partial Public Class CalcularPrecioVentaResponseBody
        
        <System.Runtime.Serialization.DataMemberAttribute(Order:=0)>  _
        Public CalcularPrecioVentaResult As Double
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal CalcularPrecioVentaResult As Double)
            MyBase.New
            Me.CalcularPrecioVentaResult = CalcularPrecioVentaResult
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.ServiceModel.MessageContractAttribute(IsWrapped:=false)>  _
    Partial Public Class ObtenerPrecioUnitarioRequest
        
        <System.ServiceModel.MessageBodyMemberAttribute(Name:="ObtenerPrecioUnitario", [Namespace]:="http://tempuri.org/", Order:=0)>  _
        Public Body As MedicamentosService.ObtenerPrecioUnitarioRequestBody
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal Body As MedicamentosService.ObtenerPrecioUnitarioRequestBody)
            MyBase.New
            Me.Body = Body
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.Runtime.Serialization.DataContractAttribute([Namespace]:="http://tempuri.org/")>  _
    Partial Public Class ObtenerPrecioUnitarioRequestBody
        
        <System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue:=false, Order:=0)>  _
        Public pMedicamento As String
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal pMedicamento As String)
            MyBase.New
            Me.pMedicamento = pMedicamento
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.ServiceModel.MessageContractAttribute(IsWrapped:=false)>  _
    Partial Public Class ObtenerPrecioUnitarioResponse
        
        <System.ServiceModel.MessageBodyMemberAttribute(Name:="ObtenerPrecioUnitarioResponse", [Namespace]:="http://tempuri.org/", Order:=0)>  _
        Public Body As MedicamentosService.ObtenerPrecioUnitarioResponseBody
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal Body As MedicamentosService.ObtenerPrecioUnitarioResponseBody)
            MyBase.New
            Me.Body = Body
        End Sub
    End Class
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0"),  _
     System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced),  _
     System.Runtime.Serialization.DataContractAttribute([Namespace]:="http://tempuri.org/")>  _
    Partial Public Class ObtenerPrecioUnitarioResponseBody
        
        <System.Runtime.Serialization.DataMemberAttribute(Order:=0)>  _
        Public ObtenerPrecioUnitarioResult As Double
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal ObtenerPrecioUnitarioResult As Double)
            MyBase.New
            Me.ObtenerPrecioUnitarioResult = ObtenerPrecioUnitarioResult
        End Sub
    End Class
    
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")>  _
    Public Interface MedicamentosServiceSoapChannel
        Inherits MedicamentosService.MedicamentosServiceSoap, System.ServiceModel.IClientChannel
    End Interface
    
    <System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")>  _
    Partial Public Class MedicamentosServiceSoapClient
        Inherits System.ServiceModel.ClientBase(Of MedicamentosService.MedicamentosServiceSoap)
        Implements MedicamentosService.MedicamentosServiceSoap
        
        Public Sub New()
            MyBase.New
        End Sub
        
        Public Sub New(ByVal endpointConfigurationName As String)
            MyBase.New(endpointConfigurationName)
        End Sub
        
        Public Sub New(ByVal endpointConfigurationName As String, ByVal remoteAddress As String)
            MyBase.New(endpointConfigurationName, remoteAddress)
        End Sub
        
        Public Sub New(ByVal endpointConfigurationName As String, ByVal remoteAddress As System.ServiceModel.EndpointAddress)
            MyBase.New(endpointConfigurationName, remoteAddress)
        End Sub
        
        Public Sub New(ByVal binding As System.ServiceModel.Channels.Binding, ByVal remoteAddress As System.ServiceModel.EndpointAddress)
            MyBase.New(binding, remoteAddress)
        End Sub
        
        <System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Function MedicamentosService_MedicamentosServiceSoap_CalcularPrecioVenta(ByVal request As MedicamentosService.CalcularPrecioVentaRequest) As MedicamentosService.CalcularPrecioVentaResponse Implements MedicamentosService.MedicamentosServiceSoap.CalcularPrecioVenta
            Return MyBase.Channel.CalcularPrecioVenta(request)
        End Function
        
        Public Function CalcularPrecioVenta(ByVal pMedicamento As String, ByVal pCantidad As Integer) As Double
            Dim inValue As MedicamentosService.CalcularPrecioVentaRequest = New MedicamentosService.CalcularPrecioVentaRequest()
            inValue.Body = New MedicamentosService.CalcularPrecioVentaRequestBody()
            inValue.Body.pMedicamento = pMedicamento
            inValue.Body.pCantidad = pCantidad
            Dim retVal As MedicamentosService.CalcularPrecioVentaResponse = CType(Me,MedicamentosService.MedicamentosServiceSoap).CalcularPrecioVenta(inValue)
            Return retVal.Body.CalcularPrecioVentaResult
        End Function
        
        <System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Function MedicamentosService_MedicamentosServiceSoap_CalcularPrecioVentaAsync(ByVal request As MedicamentosService.CalcularPrecioVentaRequest) As System.Threading.Tasks.Task(Of MedicamentosService.CalcularPrecioVentaResponse) Implements MedicamentosService.MedicamentosServiceSoap.CalcularPrecioVentaAsync
            Return MyBase.Channel.CalcularPrecioVentaAsync(request)
        End Function
        
        Public Function CalcularPrecioVentaAsync(ByVal pMedicamento As String, ByVal pCantidad As Integer) As System.Threading.Tasks.Task(Of MedicamentosService.CalcularPrecioVentaResponse)
            Dim inValue As MedicamentosService.CalcularPrecioVentaRequest = New MedicamentosService.CalcularPrecioVentaRequest()
            inValue.Body = New MedicamentosService.CalcularPrecioVentaRequestBody()
            inValue.Body.pMedicamento = pMedicamento
            inValue.Body.pCantidad = pCantidad
            Return CType(Me,MedicamentosService.MedicamentosServiceSoap).CalcularPrecioVentaAsync(inValue)
        End Function
        
        <System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Function MedicamentosService_MedicamentosServiceSoap_ObtenerPrecioUnitario(ByVal request As MedicamentosService.ObtenerPrecioUnitarioRequest) As MedicamentosService.ObtenerPrecioUnitarioResponse Implements MedicamentosService.MedicamentosServiceSoap.ObtenerPrecioUnitario
            Return MyBase.Channel.ObtenerPrecioUnitario(request)
        End Function
        
        Public Function ObtenerPrecioUnitario(ByVal pMedicamento As String) As Double
            Dim inValue As MedicamentosService.ObtenerPrecioUnitarioRequest = New MedicamentosService.ObtenerPrecioUnitarioRequest()
            inValue.Body = New MedicamentosService.ObtenerPrecioUnitarioRequestBody()
            inValue.Body.pMedicamento = pMedicamento
            Dim retVal As MedicamentosService.ObtenerPrecioUnitarioResponse = CType(Me,MedicamentosService.MedicamentosServiceSoap).ObtenerPrecioUnitario(inValue)
            Return retVal.Body.ObtenerPrecioUnitarioResult
        End Function
        
        <System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Function MedicamentosService_MedicamentosServiceSoap_ObtenerPrecioUnitarioAsync(ByVal request As MedicamentosService.ObtenerPrecioUnitarioRequest) As System.Threading.Tasks.Task(Of MedicamentosService.ObtenerPrecioUnitarioResponse) Implements MedicamentosService.MedicamentosServiceSoap.ObtenerPrecioUnitarioAsync
            Return MyBase.Channel.ObtenerPrecioUnitarioAsync(request)
        End Function
        
        Public Function ObtenerPrecioUnitarioAsync(ByVal pMedicamento As String) As System.Threading.Tasks.Task(Of MedicamentosService.ObtenerPrecioUnitarioResponse)
            Dim inValue As MedicamentosService.ObtenerPrecioUnitarioRequest = New MedicamentosService.ObtenerPrecioUnitarioRequest()
            inValue.Body = New MedicamentosService.ObtenerPrecioUnitarioRequestBody()
            inValue.Body.pMedicamento = pMedicamento
            Return CType(Me,MedicamentosService.MedicamentosServiceSoap).ObtenerPrecioUnitarioAsync(inValue)
        End Function
    End Class
End Namespace
