defmodule HelloContextWeb.CMS.PageView do
  use HelloContextWeb, :view
  alias HelloContext.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end

end
