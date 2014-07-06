OsmanagerApp::Application.routes.draw do
 
 get ':controller(/:action(/:id(.:format)))'
 post ':controller(/:action(/:id(.:format)))'


 root :to => "menu#index"

end
