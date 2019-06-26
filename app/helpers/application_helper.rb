module ApplicationHelper
  def flash_warning(message)
    %Q{
      <div class="alert alert-warning" role="alert">
        #{message}
      </div>
    }.html_safe
  end

  def display_errors(model)
    messages = model.errors.full_messages.map { |msg| "<li>#{msg}</li>"}
    %Q{
      <div class="alert alert-danger" role="alert">
        <ul>
          #{messages.join}
        </ul>
      </div>
    }.html_safe
  end
end
