defmodule MnemosyneWeb.SourceView do
  use MnemosyneWeb, :view

  def get_page_elements(nil) do
    []
  end

  def get_page_elements(elements) do
    elements
  end

end
