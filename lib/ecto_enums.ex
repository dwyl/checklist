import EctoEnum
defenum StatusEnum,
  # unassigned: 0,
  # assigned: 1,
  # in_progress: 2,
  # awaiting_review: 3,
  # in_review: 4,
  # dependent: 5,
  # blocked: 6,
  # complete: 7
Enum.with_index(App.StatusList.statuslist)
