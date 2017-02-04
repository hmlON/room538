Action::DEFAULT_ACTIONS.each do |action_name|
  Action.create(name: action_name)
end
