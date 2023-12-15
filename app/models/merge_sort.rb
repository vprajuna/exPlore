class MergeSort

  def self.merge_sort_by_user_votes(places)
    if places.length <= 1
      return places
    end

    middle = (places.length / 2).floor
    left = merge_sort_by_user_votes(places[0..middle - 1])
    right = merge_sort_by_user_votes(places[middle..places.length - 1])

    return merge_by_user_votes(left, right)
  end

  def self.merge_by_user_votes(left, right)
    if left.empty?
      return right
    elsif right.empty?
      return left
    end

    if left[0].user_votes <= right[0].user_votes
      return [left[0]] + merge_by_user_votes(left[1..left.length], right)
    else
      return [right[0]] + merge_by_user_votes(left, right[1..right.length])
    end
  end

end