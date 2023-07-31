require 'httparty'

class InvoiceValidator
  MOCK_API_URL = 'https://my.api.mockaroo.com/invoices.json'.freeze

  def self.validate(invoice_number)
    # Make the API request to the mock system
    response = HTTParty.post(MOCK_API_URL, body: { invoice_id: invoice_number.to_i }.to_json, headers: { 'X-API-Key' => 'b490bb80', 'Content-Type' => 'application/json' })

    puts "API Request Body: #{invoice_number}"
    puts "API Response Body: #{response.body}"

    # Parse the response and return true if the invoice is valid, false otherwise
    return JSON.parse(response.body)['status']
  end
end