defmodule App.StatusList do
  def statuslist do
    [
      :unassigned,
      :assigned,
      :in_progress,
      :awaiting_review,
      :in_review,
      :dependent,
      :blocked,
      :complete
    ]
  end
end
