# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Html do
  preserve_default_filters!
  remove_filter :page
  filter :aasm_state, as: :select, collection: -> { Html.aasm.states.map(&:name) }

  permit_params :aasm_state, :value, :error

  index do
    selectable_column
    id_column
    column :page
    column('Content') do |html|
      html.content[0..127]
    end
    column :aasm_state
    column :error
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :aasm_state, as: :select, collection: Html.aasm.states.map(&:name)
      f.input :content
      f.input :error
    end
    f.actions
  end
end
# :nocov:
