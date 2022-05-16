defmodule MnemosyneWeb.InputHelpers do
  use Phoenix.HTML
  def array_input(form, field) do
    values = Phoenix.HTML.Form.input_value(form, field) || [""]
    values = values ++ [%{"element" => "", "name" => ""}]
    id = Phoenix.HTML.Form.input_id(form,field)
    type = Phoenix.HTML.Form.input_type(form, field)
    content_tag :ol, id: container_id(id), class: "input_container", data: [index: Enum.count(values) ] do
      values
      |> Enum.with_index()
      |> Enum.map(fn {vals, index} ->
        form_elements(form, field, vals, index)
      end)
    end
  end

  defp form_elements(form, field, %{"name" => name, "element" => element}, index) do
    type = Phoenix.HTML.Form.input_type(form, field)
    id = Phoenix.HTML.Form.input_id(form,field)

    input_opts = [
      [
        name: new_field_name(form, field, index, "name"),
        value: name,
        id: id <> "_#{index}_name",
        class: "form-control"
        ],
      [
        name: new_field_name(form, field, index, "element"),
        value: element,
        id: id <> "_#{index}_element",
        class: "form-control"
      ]
      ]

    content_tag :li do
      input_opts
      |> Enum.map(fn input_opt -> apply(Phoenix.HTML.Form, type, [form, field, input_opt]) end)

    end
  end

  defp container_id(id), do: id <> "_container"

  defp new_field_name(form, field, id, val) do
    Phoenix.HTML.Form.input_name(form, field) <> "[#{id}]" <> "[#{val}]"
  end
end