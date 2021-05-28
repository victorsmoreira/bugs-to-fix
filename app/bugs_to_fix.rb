# frozen_string_literal: true

# bug record class
class BugRecord
  attr_accessor :id, :title, :age, :priority, :priority_code, :age_limit

  def priority_level(priority)
    case priority
    when 'Critical'
      0
    when 'Regular'
      1
    end
  end

  def find_limit_age(priority)
    case priority
    when 'Critical'
      1
    when 'Regular'
      3
    end
  end

  def initialize(id, title, age, priority)
    @id = id
    @title = title
    @age = age
    @priority = priority
    @priority_code = priority_level(priority)
    @age_limit = find_limit_age(priority)
  end
end

# Bug sorter by priority asc; age desc
def sort_bugs(bugs_array)
  if bugs_array.any?
    bugs_array.sort_by { |bug| [bug.priority_code, -bug.age] }
  else
    []
  end
end

def print_bugs_id(bug_array, key)
  bug_array[key].each do |b|
    puts ">>> #{b.id}"
  end
end

# Main method
def bugs_to_fix(array_bugs)
  bugs_fix_today = []
  expired_bugs = []

  if array_bugs.any?
    array_bugs.each do |bug|
      bug = BugRecord.new(bug['id'], bug['title'], bug['age'], bug['priority'])
      if bug.age > bug.age_limit
        expired_bugs.append(bug)
      elsif bug.age == bug.age_limit
        bugs_fix_today.append(bug)
      end
    end
  end

  # Sorted and selected bugs
  {
    expired: sort_bugs(expired_bugs),
    fix_today: sort_bugs(bugs_fix_today)
  }
end
