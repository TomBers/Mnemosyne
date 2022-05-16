defmodule MnemosyneWeb.SourceView do
  use MnemosyneWeb, :view

  import MnemosyneWeb.InputHelpers


  def get_page_elements(nil) do
    []
  end

  def get_page_elements(elements) do
    elements
  end

end
