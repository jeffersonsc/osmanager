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

 get "logradouros/novo"
 get "logradouros/listar"
 get "logradouros/exibir"
 get "logradouros/editar"

 get "servicos/novo"
 get "servicos/listar"
 get "servicos/exibir"
 get "servicos/editar"

 get "ordem_servicos/novo"
 get "ordem_servicos/listar"

 resources :clientes
 resources :funcionarios
 resources :menu
 resources :logradouros
 resources :servicos
 resources :ordem_servicos
 

end
