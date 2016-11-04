require "unicode/display_width"
class String
  def mb_ljust(width, pad_str = " ")
    return ljust(width, pad_str) if ascii_only? && pad_str.ascii_only?
    mb_execute(width) do |pad_size|
      self + mb_build_padding(pad_size, pad_str)
    end
  end

  def mb_rjust(width, pad_str = " ")
    return rjust(width, pad_str) if ascii_only? && pad_str.ascii_only?
    mb_execute(width) do |pad_size|
      mb_build_padding(pad_size, pad_str, is_append_right: false) + self
    end
  end

  def mb_center(width, pad_str = " ")
    return center(width, pad_str) if ascii_only? && pad_str.ascii_only?
    mb_execute(width) do |pad_size|
      left_pad_size = pad_size / 2
      right_pad_size = pad_size - left_pad_size

      right_padding = mb_build_padding(right_pad_size, pad_str)
      left_padding  = mb_build_padding(left_pad_size, pad_str, is_append_right: false)

      left_padding + self + right_padding
    end
  end

  def mb_truncate(truncate_at, options = {})
    return dup unless display_width > truncate_at

    omission = options[:omission] || "..."
    length_with_room_for_omission = truncate_at - omission.display_width

    size = 0
    slice = ""
    each_char do |c|
      char_size = c.display_width
      if size + char_size > length_with_room_for_omission
        slice << omission
        break
      end
      size += char_size
      slice << c
    end
    slice
  end

  private

    def mb_execute(width)
      pad_size = [width - display_width, 0].max
      return self if pad_size.zero?
      yield(pad_size)
    end

    def mb_build_padding(pad_size, pad_str, is_append_right: true)
      pad_display_width = pad_str.display_width
      pad_num, mod = pad_size.divmod(pad_display_width)
      padding = pad_str * pad_num
      if mod > 0
        padding = mb_tweak_reminder(pad_str, mod, padding)
        padding = append_reminder_space(padding, is_append_right) if pad_size > padding.display_width
      end
      padding
    end

    def mb_tweak_reminder(pad_str, mod, padding)
      pad_str.each_char do |c|
        char_display_width = c.display_width
        if mod >= char_display_width
          padding << c
          mod -= char_display_width
        end
      end
      padding
    end

    def append_reminder_space(padding, is_append_right)
      if is_append_right
        padding + " "
      else
        " " + padding
      end
    end
end
