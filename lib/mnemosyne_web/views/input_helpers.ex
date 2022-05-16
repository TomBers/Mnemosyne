defmodule MnemosyneWeb.InputHelpers do
  use Phoenix.HTML
  def array_input(form, field) do
    values = Phoenix.HTML.Form.input_value(form, field) || [""]
    id = Phoenix.HTML.Form.input_id(form,field)
    type = Phoenix.HTML.Form.input_type(form, field)
    content_tag :ol, id: container_id(id), class: "input_container", data: [index: Enum.count(values) ] do
      values
      |> Enum.with_index()
      |> Enum.map(fn {%{"name" => name, "element" => element}, index} ->

        form_elements(form, field, [name, element], index)

      end)
    end
  end

  defp form_elements(form, field, values, index) do
    type = Phoenix.HTML.Form.input_type(form, field)
    id = Phoenix.HTML.Form.input_id(form,field)

    input_opts =
      values
      |> Enum.map(fn value -> [
        name: new_field_name(form, field, value),
        value: value,
        id: id <> "_#{index}_#{value}",
        class: "form-control"
      ]  end)

    content_tag :li do
      input_opts
      |> Enum.map(fn input_opt -> apply(Phoenix.HTML.Form, type, [form, field, input_opt]) end)

    end
  end

  defp container_id(id), do: id <> "_container"

  defp new_field_name(form, field, val) do
    Phoenix.HTML.Form.input_name(form, field) <> "[#{val}]"
  end
end