defmodule MnemosyneWeb.SnapshotControllerTest do
  use MnemosyneWeb.ConnCase

  import Mnemosyne.RecordsFixtures

  @create_attrs %{response: %{}, type: "some type", url: "some url"}
  @update_attrs %{response: %{}, type: "some updated type", url: "some updated url"}
  @invalid_attrs %{response: nil, type: nil, url: nil}

  describe "index" do
    test "lists all snapshots", %{conn: conn} do
      conn = get(conn, Routes.snapshot_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Snapshots"
    end
  end

  describe "new snapshot" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.snapshot_path(conn, :new))
      assert html_response(conn, 200) =~ "New Snapshot"
    end
  end

  describe "create snapshot" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.snapshot_path(conn, :create), snapshot: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.snapshot_path(conn, :show, id)

      conn = get(conn, Routes.snapshot_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Snapshot"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.snapshot_path(conn, :create), snapshot: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Snapshot"
    end
  end

  describe "edit snapshot" do
    setup [:create_snapshot]

    test "renders form for editing chosen snapshot", %{conn: conn, snapshot: snapshot} do
      conn = get(conn, Routes.snapshot_path(conn, :edit, snapshot))
      assert html_response(conn, 200) =~ "Edit Snapshot"
    end
  end

  describe "update snapshot" do
    setup [:create_snapshot]

    test "redirects when data is valid", %{conn: conn, snapshot: snapshot} do
      conn = put(conn, Routes.snapshot_path(conn, :update, snapshot), snapshot: @update_attrs)
      assert redirected_to(conn) == Routes.snapshot_path(conn, :show, snapshot)

      conn = get(conn, Routes.snapshot_path(conn, :show, snapshot))
      assert html_response(conn, 200) =~ "some updated type"
    end

    test "renders errors when data is invalid", %{conn: conn, snapshot: snapshot} do
      conn = put(conn, Routes.snapshot_path(conn, :update, snapshot), snapshot: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Snapshot"
    end
  end

  describe "delete snapshot" do
    setup [:create_snapshot]

    test "deletes chosen snapshot", %{conn: conn, snapshot: snapshot} do
      conn = delete(conn, Routes.snapshot_path(conn, :delete, snapshot))
      assert redirected_to(conn) == Routes.snapshot_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.snapshot_path(conn, :show, snapshot))
      end
    end
  end

  defp create_snapshot(_) do
    snapshot = snapshot_fixture()
    %{snapshot: snapshot}
  end
end
