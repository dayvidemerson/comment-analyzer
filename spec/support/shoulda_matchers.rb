Shoulda::Matchers.configure do |shoulda_matchers_config|
  shoulda_matchers_config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
