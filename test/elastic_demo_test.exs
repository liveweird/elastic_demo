defmodule ElasticDemoTest do
  use ExUnit.Case
  doctest ElasticDemo

  @test_url Elastix.config(:test_url)
  @test_index Elastix.config(:test_index)
  @data %{
    name: "Something",
    surname: "And something more"
  }

  setup do
    Elastix.Index.delete(@test_url, @test_index)
    :ok
  end

  test "write and read" do
    {:ok, response} = Elastix.Document.index @test_url, @test_index, "message", 1, @data, [refresh: true]

    assert response.status_code == 201
    assert response.body[:_id] == "1"
    assert response.body[:_index] == @test_index
    assert response.body[:_type] == "message"
    assert response.body[:created] == true
  end
end
