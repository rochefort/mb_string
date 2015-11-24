require 'unicode/display_width'

# TODO: update readme
# TODO: stringへprivate methodを追加したくない
class String
  def mb_ljust(width, pad_str = ' ')
    execute_mb_mthod(width) do |pad_size|
      self + build_mb_padding(pad_size, pad_str)
    end
  end

  def mb_rjust(width, pad_str = ' ')
    execute_mb_mthod(width) do |pad_size|
      build_mb_padding(pad_size, pad_str, is_append_right: false) + self
    end
  end

  def mb_center(width, pad_str = ' ')
    execute_mb_mthod(width) do |pad_size|
      left_pad_size = pad_size / 2
      right_pad_size = pad_size - left_pad_size

      right_padding = build_mb_padding(right_pad_size, pad_str)
      left_padding  = build_mb_padding(left_pad_size, pad_str, is_append_right: false)

      left_padding + self + right_padding
    end
  end

  private

  def execute_mb_mthod(width)
    pad_size = [width - display_width, 0].max
    return self if pad_size.zero?
    yield(pad_size)
  end

  def build_mb_padding(pad_size, pad_str, is_append_right: true)
    pad_display_width = pad_str.display_width
    pad_num, mod = pad_size.divmod(pad_display_width)
    padding = pad_str * pad_num
    if mod > 0
      padding = tweak_reminder(pad_str, mod, padding)
      padding = append_reminder_space(padding, is_append_right) if pad_size > padding.display_width
    end
    padding
  end

  def tweak_reminder(pad_str, mod, padding)
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
      padding + ' '
    else
      ' ' + padding
    end
  end
end
