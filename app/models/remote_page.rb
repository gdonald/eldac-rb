# frozen_string_literal: true

RemotePage = Struct.new(:title, :blurb, :content, :url) do
  def to_partial_path
    'pages/page'
  end
end
