map_for(:log_buddy) do |wizard|
  
  wizard.keep_a_watchful_eye_for 'lib', 'examples'

  wizard.prepare_spell_for %r%examples/(.*)_example\.rb% do |spell_component|
    ["examples/#{spell_component[1]}_example.rb"]
  end
  
  wizard.prepare_spell_for %r%examples/example_helper\.rb% do |spell_component|
    Dir["examples/**/*_example.rb"]
  end
 
  wizard.prepare_spell_for %r%lib/(.*)\.rb% do |spell_component|
    ["examples/#{spell_component[1]}_example.rb"]
  end
  
end