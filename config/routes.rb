OsmanagerApp::Application.routes.draw do
 
 get "clientes/novo"
 get "clientes/listar"
 get "clientes/editar"
 get "clientes/exibir"
 get "clientes/deletar"

 resources :clientes

end
