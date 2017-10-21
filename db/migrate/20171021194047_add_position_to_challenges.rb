class AddPositionToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :position, :integer

    Challenge.reset_column_information
    RecordBook.includes(:challenges).find_each do |record_book|
      record_book.challenges.each_with_index do |challenge, index|
        challenge.update_attribute :position, index + 1 # rubocop:disable Rails/SkipsModelValidations
      end
    end

    change_column_null :challenges, :position, false
  end
end
