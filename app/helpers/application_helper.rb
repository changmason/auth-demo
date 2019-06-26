module ApplicationHelper
  def flash_warning(message)
    %Q{
      <div class="alert alert-warning" role="alert">
        #{message}
      </div>
    }.html_safe
  end
end
