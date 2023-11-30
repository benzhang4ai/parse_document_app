json.extract! document, :id, :file_name, :document_type, :data, :created_at, :updated_at
json.url document_url(document, format: :json)
