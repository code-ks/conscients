# frozen_string_literal: true

# To run in production once --> should import all the customers of the existing site
# (cf customer_export.csv) and invite them to the new app
task import_existing_customers: :environment do
  CSV.foreach('lib/assets/customers_export.csv', headers: true, col_sep: ';') do |row|
    newsletter_subscriber = row['newsletter_date_add'].blank? ? false : true
    Client.invite!(first_name: row['firstname'], last_name: row['lastname'],
                   email: row['email'], newsletter_subscriber: newsletter_subscriber)
  end
end
