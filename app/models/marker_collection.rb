
class MarkerCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  attr_accessor :collection


    def initialize(attributes = [])
        if attributes.present?
          self.collection = attributes.map do |value|
          Marker.new(
              color: value['color'],
              field: value['field'],
              user_id: value['user_id']
            )
          end
        else
          self.collection = [ Marker.new(color:"Red"),
                              Marker.new(color:"Yellow"),
                              Marker.new(color:"Blue"),
                              Marker.new(color:"Light-Blue"),
                              Marker.new(color:"Green"),
                              Marker.new(color:"Yellow-green") ]

        end
    end

    def save
        is_success = true
        ActiveRecord::Base.transaction do
          self.collection.each do |result|
            is_success = false unless result.save
          end
          raise ActiveRecord::RecordInvalid unless is_success
        end
        rescue
          p '正しい情報を入力してください'
          例外の有無に関わらず実行
          ensure
            return is_success
    end




  def persisted?
    false
  end


end
