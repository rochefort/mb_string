require 'unicode/display_width'

# TODO: update readme
# TODO: is_append_right is ugly
# TODO: stringへprivate methodを追加したくない
class String
  def mb_ljust(width, pad_str = ' ')
    self + mb_padding(width, pad_str)
  end

  def mb_rjust(width, pad_str = ' ')
    mb_padding(width, pad_str, is_append_right: false) + self
  end

  def mb_center(width, pad_str = ' ')
    pad_size = [width - display_width, 0].max
    return self if pad_size == 0

    right_pad_size = pad_size / 2
    left_pad_size = pad_size - right_pad_size

    right_padding = build_mb_padding(right_pad_size, pad_str)
    left_padding  = build_mb_padding(left_pad_size, pad_str, is_append_right: false)

    left_padding + self + right_padding
  end

  private

  def mb_padding(width, pad_str, is_append_right: true)
    pad_size = [width - display_width, 0].max
    return '' if pad_size == 0

    build_mb_padding(pad_size, pad_str, is_append_right: is_append_right)
  end

  def build_mb_padding(pad_size, pad_str, is_append_right: true)
    pad_display_width = pad_str.display_width
    pad_num, mod = pad_size.divmod(pad_display_width)
    padding = pad_str * pad_num
    padding = tweak_reminder(pad_str, mod, padding, is_append_right, pad_size) if mod > 0
    padding
  end

  # TODO: too much arguments
  def tweak_reminder(pad_str, mod, padding, is_append_right, pad_size)
    pad_str.each_char do |c|
      char_display_width = c.display_width
      if mod >= char_display_width
        padding << c
        mod -= char_display_width
        # TODO: else return for performance with using benchmarking
      end
    end
    padding = append_reminder_space(padding, is_append_right) if pad_size > padding.display_width
    padding
  end

  def append_reminder_space(padding, is_append_right)
    if is_append_right
      padding + ' '
    else
      ' ' + padding
    end
  end
end
