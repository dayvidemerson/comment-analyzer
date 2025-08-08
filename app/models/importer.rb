class Importer < ApplicationRecord
  enum :state, { pending: 0, processing: 1, completed: 2, error: 3 }, default: :pending

  after_create :schedule_import

  def run!
    return unless pending?

    processing!
    process!
  rescue StandardError => e
    error!
  ensure
    completed! if processing?
  end

  def process!
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  protected

  def schedule_import
    ImporterJob.perform_later(id)
  end
end
