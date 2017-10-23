def mergemeeting(meetings)
  meetings.sort!
  (0...(meetings.length - 1)).each do |idx|
    if meetings[idx+1][0] <= meetings[idx][1]
      meetings[idx+1][0] = [meetings[idx][0], meetings[idx][0]].min
      meetings[idx+1][1] = [meetings[idx][1], meetings[idx][1]].max
      meetings[idx] = nil
    end
  end


  return meetings.compact
end


p mergemeeting([[6,8],[1,2],[7,8],[0,1],[3,4], [10,11],[9,12]]) ## [[0,2],[3,4],[6,8]]
