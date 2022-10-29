defmodule XmlUtils do
  import Record

  defrecord(:xmlElement, extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl"))
  defrecord(:xmlAttribute, extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl"))
  defrecord(:xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  def get_child_elements(element) do
    Enum.filter(XML.xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlElement)
    end)
  end

  def find_child(children, name) do
    Enum.find(children, fn child -> XML.xmlElement(child, :name) == name end)
  end

  def get_text(element) do
    Enum.find(XML.xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlText)
    end)
    |> XML.xmlText(:value)
  end
end
