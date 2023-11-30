require 'open-uri'

class Document < ApplicationRecord
    has_one_attached :file

    def url
        Rails.application.routes.url_helpers.rails_blob_url(file.blob, only_path: true) if file.attached?
    end

    def file_name
        file.blob.filename if file.attached?
    end

    def parse!
        reader = PDF::Reader.new(URI.open(file.url))

        prompt = <<-EOS
You are good at parsing invoice PDF data into a predetermined JSON format. This data comes in two form: One is raw data from PDF. The other is text parsed out of the PDF file using some library. 

Please use both data, cross-reference and decide on the most reliable value. Pay special attention to punctuation marks and different brackets. Please do not miss any characters.

The line items are likely inside a table so please align columns well in the table to interpret things fully and correctly. 

Here is the pre-determined JSON format: 

{
  "document_type": <invoice or purchase_order>
  "document_number": "string",
  "document_date": "YYYY-MM-DD", 
  "seller": {
    "company_name": "string",
    "contact_name": "string",
    "address": "string",
    "phone": "string",
    "email": "string"
  },
  "buyer": {
    "company_name": "string",
    "contact_name": "string", 
    "address": "string",
    "phone": "string",
    "email": "string"
  },
  "bank_details": {
    "account_name": "string",
    "account_number": "string",
    "swift_code": "string",
    "bank_name":"string"
  },
  "line_items": [
    {
      "sku": "string",
      "msku": "string",
      "description": "string",
      "quantity": "number",
      "unit": "string",
      "unit_price": "number",
      "amount": "number",
      "currency": <RMB or USD>,
      "remark": "string"
    }
  ],
  "subtotal": {"amount": "number", currency: "string"},
  "shipping": {"amount": "number", currency: "string"},
  "other_fees": [{"fee_name":"string", "amount": "number", currency: "string"}],  
  "total": [{"amount": "number", currency: "string"}], #if there are total in multiple currencies, include them all.
  "exchange_rate": "number",
  "payment_terms": "string",
  "estimated_date_of_arrival": "string", #Only include this key if document is purchase_order.
  "uncertainties": [
     "field_name": "string",
     "reason": "string"
  ]
}

Please only respond with a JSON object without backticks!!! When unsure, leave the field blank.

PDF Raw Data:
#{reader.pages.first.raw_content if ENV['USE_RAW_DATA']}

Text parsed from the PDF:
#{reader.pages.first.text}
        EOS

        client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_api_key)
        response = client.chat(
            parameters: {
                model: ENV['USE_GPT_4'] == 'true' ? "gpt-4-1106-preview" : "gpt-3.5-turbo-1106", # Required.
                messages: [{ role: "system", content: prompt}], # Required.
                temperature: 0,
            })
        puts response
        puts result = JSON.parse(response.dig("choices", 0, "message", "content"))
        self.update!(document_type: result['document_type'], data: result)
    end
end


