defmodule XmlPoc do


  @moduledoc """
  Documentation for `XmlPoc`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> XmlPoc.hello()
      :world

  """
  def hello do
    :world
  end


  def xmerl do
    {:ok, xmldoc} = File.read(Path.expand("ticket.xml", "lib"))
    {doc, []} = xmldoc |> to_char_list() |> :xmerl_scan.string()

  end


  def saxmerl do
    {:ok, xmldoc} = File.read(Path.expand("ticket.xml", "lib"))
    {:ok, doc} = xmldoc  |> Saxmerl.parse_string()
     doc

  end


  def saxy do

    {:ok, xmldoc} = File.read(Path.expand("ticket.xml", "lib"))
    {:ok, doc } = Saxy.SimpleForm.parse_string(to_string(xmldoc))

    document_body = elem(doc,2)
    document_body

  end




  def search_node(document_body ,name) do

    indexed_document =  Enum.with_index(document_body, fn element, index -> {index, element} end)

    indexed_document
    |> Enum.find(fn node  ->
      #los espacios generan tuplas de esta forma  {1, "    "},
      if is_tuple(elem(node,1)) do
        {index, {name_node, _, _ }} = node
        if name_node == name do
          {index, node}
        end
      end
      end)
  end





end
