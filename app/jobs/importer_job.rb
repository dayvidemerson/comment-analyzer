class ImporterJob < ApplicationJob
  queue_as :default

  def perform(id)
    importer = Importer.find(id)

    importer.run!
  end
end
