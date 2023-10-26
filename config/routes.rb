Rails.application.routes.draw do
  resources :sections do
    resources :student_sections, only: :create, module: :sections do
      delete :destroy, on: :collection, action: :destroy
    end
  end
  resources :classrooms
  resources :students do
    member do
      post :log_as
    end

    collection do
      delete :log_out
    end
  end
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
