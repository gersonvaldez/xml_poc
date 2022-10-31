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

  def saxy_handler do
    {:ok, xmldoc} = File.read(Path.expand("ticket.xml", "lib"))
    {:ok,parsed_doc }= Saxy.parse_string(xmldoc, EventHandler, [])
    parsed_doc
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

    doc_sanitized = xmldoc
    |> String.replace("\n", "")
    |> String.replace(~r/\n/, "")
    |> String.replace(~r/>\s{1,}</, "><")


    {:ok, doc } = Saxy.SimpleForm.parse_string(to_string(doc_sanitized))

    doc



    #document_body = elem(doc,2)
    #document_body

  end

  def map_saxy do
    {:ok, xmldoc} = File.read(Path.expand("ticket.xml", "lib"))
    {:ok, doc} = Saxy.MapForm.parse_string(xmldoc)
  end




  def search_node(document_body ,name) do

    indexed_document =  Enum.with_index(elem(document_body,2), fn element, index -> {index, element} end)

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



  def delete_element(document_body, index) do
    {tag_name, attr, childs} = document_body

    updated_list = childs
    |> List.to_tuple
    |> Tuple.delete_at(index)
    |> Tuple.to_list

    {tag_name, attr , updated_list}
  end








end
