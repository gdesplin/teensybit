class FormField < ApplicationRecord
  belongs_to :form
  acts_as_list scope: :form, add_new_at: nil
  has_many :form_field_options, -> { order(position: :asc) },  dependent: :destroy
  accepts_nested_attributes_for :form_field_options, reject_if: :all_blank, allow_destroy: true

  enum field_kind: { 
    string: 'string',
    text: 'text',
    check_boxes: 'check_boxes',
    radio_buttons: 'radio_buttons',
    select_box: 'select_box',
    file: 'file',
    datetime: 'datetime',
    date: 'date',
    time: 'time'
  }

  validates :field_kind, inclusion: { in: field_kinds.keys }
  validates :question, presence: true, uniqueness: { scope: :form_id }

  def self.field_kind_attributes_for_select
    field_kinds.map do |field_kind, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}/field_kind.#{field_kind}"), field_kind]
    end
  end

  def field_kind_group
    if %w[string text file datetime date time].include?(field_kind)
      "simple_fields"
    elsif %w[check_boxes radio_buttons select_box].include?(field_kind)
      "with_options_fields"
    end
  end
end
