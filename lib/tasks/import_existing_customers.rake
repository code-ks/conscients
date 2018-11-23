# frozen_string_literal: true

task import_existing_customers: :environment do
  CSV.foreach('lib/assets/customers_export.csv', headers: true, col_sep: ';') do |row|
    newsletter_subscriber = row['newsletter_date_add'].blank? ? false : true
    Client.invite!(first_name: row['firstname'], last_name: row['lastname'],
                   email: row['email'], newsletter_subscriber: newsletter_subscriber)
  end
end
