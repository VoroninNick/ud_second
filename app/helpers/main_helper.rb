module MainHelper
  # =====================================
  # -------------------------------------
  # settings
  # -------------------------------------
  # -------------------------------------

  def panel_with_header name, options = {}, &block
    raise Exception("please provide block") unless block_given?

    #content_tag(name, options, nil, true, &block)
    render("partials/panel_with_header.html.slim", { name: name, block: block }, &block)
  end
end
