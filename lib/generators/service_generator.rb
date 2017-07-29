# ServiceGenerator is generator for serice objects
class ServiceGenerator < Rails::Generators::NamedBase
  def create_service_file
    create_file "app/services/#{file_name}.rb", <<-FILE.strip_heredoc
      # #{class_name}.()
      class #{class_name} < ApplicationService
        def perform

        end
      end
    FILE
  end
end
