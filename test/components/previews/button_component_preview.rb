# frozen_string_literal: true

class ButtonComponentPreview < ViewComponent::Preview
  # Button Component
  # ------------
  # A button for clicking.
  #
  # @param text text "The text to display on the button."
  # @param scheme select "A range of button schemes." [primary, warning, danger]
  def default(text: "Dynamic text", scheme: :primary)
    render(ButtonComponent.new(scheme: scheme)) do |component|
      component.text { text }
    end
  end
end
