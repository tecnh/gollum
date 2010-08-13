require File.join(File.dirname(__FILE__), *%w[helper])

context "File" do
  setup do
    @wiki = Gollum::Wiki.new(testpath("examples/lotr.git"))
    @path = testpath("examples/test_empty.git")
    FileUtils.rm_rf(@path)
    Grit::Repo.init_bare(@path)
    @wiki_empty = Gollum::Wiki.new(@path)
  end

  test "search file on empty git repo" do
    assert_nothing_raised do
      file_not_exist = @wiki_empty.file("not_exist.md")
      assert_nil file_not_exist
    end
  end

  test "new file" do
    file = Gollum::File.new(@wiki)
    assert_nil file.raw_data
  end

  test "existing file" do
    file = @wiki.file("Mordor/todo.txt")
    assert_equal "[ ] Write section on Ents\n", file.raw_data
    assert_equal @wiki.repo.commits.first.id, file.version.id
  end

  teardown do
    FileUtils.rm_r(File.join(File.dirname(__FILE__), *%w[examples test_empty.git]))
  end
end