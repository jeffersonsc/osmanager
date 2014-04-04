OsmanagerApp::Application.routes.draw do
 
 get "clientes/novo"
 get "clientes/listar"
 get "clientes/editar"
 get "clientes/exibir"
 get "clientes/deletar"

 get "funcionarios/novo"
 get "funcionarios/listar"
 get "funcionarios/exibir"
 get "funcionarios/editar"
 get "funcionarios/deletar"

 resources :clientes
 resources :funcionarios

end
