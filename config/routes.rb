OsmanagerApp::Application.routes.draw do
 
 get "clientes/novo"
 get "clientes/listar"
 get "clientes/editar"
 get "clientes/exibir"
 get "clientes/bloquear"
 get "clientes/desbloquear"

 get "funcionarios/novo"
 get "funcionarios/listar"
 get "funcionarios/exibir"
 get "funcionarios/editar"
 get "funcionarios/deletar"

 get "menu/index"

 resources :clientes
 resources :funcionarios
 resources :menu

end
