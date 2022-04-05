require "json-schema"
class JsonSchemaValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # Looks for a JSON schema as a class constant
    c = "#{attribute.upcase}_SCHEMA"
    begin 
      schema = record.class.const_get(c)
    rescue NameError => e
      # re-raise exception with a more descriptive message
      raise( 
        $!, 
        "Expected #{record.class.name}::#{c} to declare a JSON Schema for #{attribute}", 
        $!.backtrace
      )
    end
    unless JSON::Validator.validate(schema, value)
      record.errors.add(attribute, 'needs to be present and right type.')
    end
  end
end
