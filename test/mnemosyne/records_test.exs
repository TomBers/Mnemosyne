defmodule Mnemosyne.RecordsTest do
  use Mnemosyne.DataCase

  alias Mnemosyne.Records

  describe "snapshots" do
    alias Mnemosyne.Records.Snapshot

    import Mnemosyne.RecordsFixtures

    @invalid_attrs %{response: nil, type: nil, url: nil}

    test "list_snapshots/0 returns all snapshots" do
      snapshot = snapshot_fixture()
      assert Records.list_snapshots() == [snapshot]
    end

    test "get_snapshot!/1 returns the snapshot with given id" do
      snapshot = snapshot_fixture()
      assert Records.get_snapshot!(snapshot.id) == snapshot
    end

    test "create_snapshot/1 with valid data creates a snapshot" do
      valid_attrs = %{response: %{}, type: "some type", url: "some url"}

      assert {:ok, %Snapshot{} = snapshot} = Records.create_snapshot(valid_attrs)
      assert snapshot.response == %{}
      assert snapshot.type == "some type"
      assert snapshot.url == "some url"
    end

    test "create_snapshot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_snapshot(@invalid_attrs)
    end

    test "update_snapshot/2 with valid data updates the snapshot" do
      snapshot = snapshot_fixture()
      update_attrs = %{response: %{}, type: "some updated type", url: "some updated url"}

      assert {:ok, %Snapshot{} = snapshot} = Records.update_snapshot(snapshot, update_attrs)
      assert snapshot.response == %{}
      assert snapshot.type == "some updated type"
      assert snapshot.url == "some updated url"
    end

    test "update_snapshot/2 with invalid data returns error changeset" do
      snapshot = snapshot_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_snapshot(snapshot, @invalid_attrs)
      assert snapshot == Records.get_snapshot!(snapshot.id)
    end

    test "delete_snapshot/1 deletes the snapshot" do
      snapshot = snapshot_fixture()
      assert {:ok, %Snapshot{}} = Records.delete_snapshot(snapshot)
      assert_raise Ecto.NoResultsError, fn -> Records.get_snapshot!(snapshot.id) end
    end

    test "change_snapshot/1 returns a snapshot changeset" do
      snapshot = snapshot_fixture()
      assert %Ecto.Changeset{} = Records.change_snapshot(snapshot)
    end
  end

  describe "sources" do
    alias Mnemosyne.Records.Source

    import Mnemosyne.RecordsFixtures

    @invalid_attrs %{active: nil, page_elements: nil, type: nil, url: nil}

    test "list_sources/0 returns all sources" do
      source = source_fixture()
      assert Records.list_sources() == [source]
    end

    test "get_source!/1 returns the source with given id" do
      source = source_fixture()
      assert Records.get_source!(source.id) == source
    end

    test "create_source/1 with valid data creates a source" do
      valid_attrs = %{active: true, page_elements: [], type: "some type", url: "some url"}

      assert {:ok, %Source{} = source} = Records.create_source(valid_attrs)
      assert source.active == true
      assert source.page_elements == []
      assert source.type == "some type"
      assert source.url == "some url"
    end

    test "create_source/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_source(@invalid_attrs)
    end

    test "update_source/2 with valid data updates the source" do
      source = source_fixture()
      update_attrs = %{active: false, page_elements: [], type: "some updated type", url: "some updated url"}

      assert {:ok, %Source{} = source} = Records.update_source(source, update_attrs)
      assert source.active == false
      assert source.page_elements == []
      assert source.type == "some updated type"
      assert source.url == "some updated url"
    end

    test "update_source/2 with invalid data returns error changeset" do
      source = source_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_source(source, @invalid_attrs)
      assert source == Records.get_source!(source.id)
    end

    test "delete_source/1 deletes the source" do
      source = source_fixture()
      assert {:ok, %Source{}} = Records.delete_source(source)
      assert_raise Ecto.NoResultsError, fn -> Records.get_source!(source.id) end
    end

    test "change_source/1 returns a source changeset" do
      source = source_fixture()
      assert %Ecto.Changeset{} = Records.change_source(source)
    end
  end
end
