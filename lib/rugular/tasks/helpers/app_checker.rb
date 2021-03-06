module Rugular
  class AppChecker
    include Thor::Shell

    def self.check_for_rugular_directory(task_name:, root_directory:)
      new(
        task_name: task_name,
        root_directory: root_directory
      ).check_for_rugular_directory
    end

    def initialize(task_name:, root_directory:)
      @task_name = task_name
      @root_directory = root_directory
    end

    def check_for_rugular_directory
      fail(rugular_app_message) unless rugular_app?

      return true
    end

    private

    attr_reader :task_name, :root_directory

    def rugular_app_message
      "#{task_name} can only be ran in the root folder of a Rugular app"
    end

    def rugular_app?
      [
        'bower.json',
        'package.json',
        'Gemfile',
        'src/index.haml'
      ].each do |file_name|
        destination_file_name = root_directory + '/' + file_name

        return false unless File.exists?(destination_file_name)
      end
    end

  end
end
