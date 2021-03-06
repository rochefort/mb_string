require "spec_helper"

RSpec.shared_examples_for "without_options" do |method, examples|
  examples.each do |example|
    input = example[:inputs]
    it "#{example[:object].inspect}.#{method}(#{input}) should return #{example[:expected].inspect}" do
      expect(example[:object].send(method, input)).to eq example[:expected]
    end
  end
end

RSpec.shared_examples_for "with_options" do |method, examples|
  examples.each do |example|
    width, pad_str = example[:inputs]
    it "#{example[:object].inspect}.#{method}(#{width}, #{pad_str.inspect}) should return #{example[:expected].inspect}" do
      expect(example[:object].send(method, *[width, pad_str])).to eq example[:expected]
    end
  end
end

describe "String" do
  describe "#mb_ljust" do
    context "without pad_str" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: 2, expected: "abc" },
          { object: "abc", inputs: 3, expected: "abc" },
          { object: "abc", inputs: 4, expected: "abc " },
        ]
        include_examples "without_options", "mb_ljust", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: 5, expected: "あいう" },
          { object: "あいう", inputs: 6, expected: "あいう" },
          { object: "あいう", inputs: 7, expected: "あいう " },
          { object: "あいう", inputs: 8, expected: "あいう  " },
        ]
        include_examples "without_options", "mb_ljust", examples
      end
    end

    context "with pad_str" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: [2, "x"], expected: "abc" },
          { object: "abc", inputs: [3, "x"], expected: "abc" },
          { object: "abc", inputs: [4, "x"], expected: "abcx" },

          { object: "abc", inputs: [4, "xy"], expected: "abcx" },
          { object: "abc", inputs: [5, "xy"], expected: "abcxy" },
          { object: "abc", inputs: [6, "xy"], expected: "abcxyx" },
          { object: "abc", inputs: [7, "xy"], expected: "abcxyxy" },
        ]
        include_examples "with_options", "mb_ljust", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: [5, "x"], expected: "あいう" },
          { object: "あいう", inputs: [6, "x"], expected: "あいう" },
          { object: "あいう", inputs: [7, "x"], expected: "あいうx" },

          { object: "あいう", inputs: [5, "お"], expected: "あいう" },
          { object: "あいう", inputs: [6, "お"], expected: "あいう" },
          { object: "あいう", inputs: [7, "お"], expected: "あいう " },
          { object: "あいう", inputs: [8, "お"], expected: "あいうお" },
          { object: "あいう", inputs: [9, "お"], expected: "あいうお " },
          { object: "あいう", inputs: [10, "お"], expected: "あいうおお" },
        ]
        include_examples "with_options", "mb_ljust", examples
      end
    end
  end

  describe "#mb_rjust" do
    context "without pad_str" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: 2, expected: "abc" },
          { object: "abc", inputs: 3, expected: "abc" },
          { object: "abc", inputs: 4, expected: " abc" },
        ]
        include_examples "without_options", "mb_rjust", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: 5, expected: "あいう" },
          { object: "あいう", inputs: 6, expected: "あいう" },
          { object: "あいう", inputs: 7, expected: " あいう" },
          { object: "あいう", inputs: 8, expected: "  あいう" },
        ]
        include_examples "without_options", "mb_rjust", examples
      end
    end

    context "with pad_str" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: [2, "x"], expected: "abc" },
          { object: "abc", inputs: [3, "x"], expected: "abc" },
          { object: "abc", inputs: [4, "x"], expected: "xabc" },

          { object: "abc", inputs: [4, "xy"], expected: "xabc" },
          { object: "abc", inputs: [5, "xy"], expected: "xyabc" },
          { object: "abc", inputs: [6, "xy"], expected: "xyxabc" },
          { object: "abc", inputs: [7, "xy"], expected: "xyxyabc" },
        ]
        include_examples "with_options", "mb_rjust", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: [5, "x"], expected: "あいう" },
          { object: "あいう", inputs: [6, "x"], expected: "あいう" },
          { object: "あいう", inputs: [7, "x"], expected: "xあいう" },

          { object: "あいう", inputs: [5, "え"], expected: "あいう" },
          { object: "あいう", inputs: [6, "え"], expected: "あいう" },
          { object: "あいう", inputs: [7, "え"], expected: " あいう" },
          { object: "あいう", inputs: [8, "え"], expected: "えあいう" },
          { object: "あいう", inputs: [9, "え"], expected: " えあいう" },
          { object: "あいう", inputs: [10, "え"], expected: "ええあいう" },

          { object: "あいう", inputs: [5, "えお"], expected: "あいう" },
          { object: "あいう", inputs: [6, "えお"], expected: "あいう" },
          { object: "あいう", inputs: [7, "えお"], expected: " あいう" },
          { object: "あいう", inputs: [8, "えお"], expected: "えあいう" },
          { object: "あいう", inputs: [9, "えお"], expected: " えあいう" },
          { object: "あいう", inputs: [10, "えお"], expected: "えおあいう" },
          { object: "あいう", inputs: [11, "えお"], expected: " えおあいう" },
          { object: "あいう", inputs: [12, "えお"], expected: "えおえあいう" },
          { object: "あいう", inputs: [13, "えお"], expected: " えおえあいう" },
          { object: "あいう", inputs: [14, "えお"], expected: "えおえおあいう" },
        ]
        include_examples "with_options", "mb_rjust", examples
      end
    end
  end

  describe "#mb_center" do
    context "without pad_str" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: 2, expected: "abc" },
          { object: "abc", inputs: 3, expected: "abc" },
          { object: "abc", inputs: 4, expected: "abc " },
          { object: "abc", inputs: 5, expected: " abc " },
          { object: "abc", inputs: 6, expected: " abc  " },
        ]
        include_examples "without_options", "mb_center", examples
      end
    end

    context "multibytes-strings" do
      examples = [
        { object: "あいう", inputs: 5, expected: "あいう" },
        { object: "あいう", inputs: 6, expected: "あいう" },
        { object: "あいう", inputs: 7, expected: "あいう " },
        { object: "あいう", inputs: 8, expected: " あいう " },
      ]
      include_examples "without_options", "mb_center", examples
    end
  end

  context "with pad_str" do
    context "ascii-strings" do
      examples = [
        { object: "abc", inputs: [2, "x"], expected: "abc" },
        { object: "abc", inputs: [3, "x"], expected: "abc" },
        { object: "abc", inputs: [4, "x"], expected: "abcx" },
        { object: "abc", inputs: [5, "x"], expected: "xabcx" },

        { object: "abc", inputs: [4, "xy"], expected: "abcx" },
        { object: "abc", inputs: [5, "xy"], expected: "xabcx" },
        { object: "abc", inputs: [6, "xy"], expected: "xabcxy" },
        { object: "abc", inputs: [7, "xy"], expected: "xyabcxy" },
        { object: "abc", inputs: [8, "xy"], expected: "xyabcxyx" },
        { object: "abc", inputs: [9, "xy"], expected: "xyxabcxyx" },
      ]
      include_examples "with_options", "mb_center", examples
    end

    context "multibytes-strings" do
      examples = [
        { object: "あいう", inputs: [5, "x"], expected: "あいう" },
        { object: "あいう", inputs: [6, "x"], expected: "あいう" },
        { object: "あいう", inputs: [7, "x"], expected: "あいうx" },
        { object: "あいう", inputs: [8, "x"], expected: "xあいうx" },
        { object: "あいう", inputs: [9, "x"], expected: "xあいうxx" },

        { object: "あいう", inputs: [5, "え"], expected: "あいう" },
        { object: "あいう", inputs: [6, "え"], expected: "あいう" },
        { object: "あいう", inputs: [7, "え"], expected: "あいう " },
        { object: "あいう", inputs: [8, "え"], expected: " あいう " },
        { object: "あいう", inputs: [9, "え"], expected: " あいうえ" },
        { object: "あいう", inputs: [10, "え"], expected: "えあいうえ" },

        { object: "あいう", inputs: [5, "えお"], expected: "あいう" },
        { object: "あいう", inputs: [6, "えお"], expected: "あいう" },
        { object: "あいう", inputs: [7, "えお"], expected: "あいう " },
        { object: "あいう", inputs: [8, "えお"], expected: " あいう " },
        { object: "あいう", inputs: [9, "えお"], expected: " あいうえ" },
        { object: "あいう", inputs: [10, "えお"], expected: "えあいうえ" },
        { object: "あいう", inputs: [11, "えお"], expected: "えあいうえ " },
        { object: "あいう", inputs: [12, "えお"], expected: " えあいうえ " },
        { object: "あいう", inputs: [13, "えお"], expected: " えあいうえお" },
        { object: "あいう", inputs: [14, "えお"], expected: "えおあいうえお" },
      ]
      include_examples "with_options", "mb_center", examples
    end
  end

  describe "#mb_truncate" do
    context "without omission" do
      context "ascii-strings" do
        examples = [
          { object: "abc",   inputs: 2, expected: "..." },
          { object: "abc",   inputs: 3, expected: "abc" },
          { object: "abcde", inputs: 3, expected: "..." },
          { object: "abcde", inputs: 4, expected: "a..." },
          { object: "abcde", inputs: 5, expected: "abcde" },
        ]
        include_examples "without_options", "mb_truncate", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: 2, expected: "..." },
          { object: "あいう", inputs: 3, expected: "..." },
          { object: "あいう", inputs: 4, expected: "..." },
          { object: "あいう", inputs: 5, expected: "あ..." },
          { object: "あいう", inputs: 6, expected: "あいう" },
        ]
        include_examples "without_options", "mb_truncate", examples
      end
    end

    context "with omission" do
      context "ascii-strings" do
        examples = [
          { object: "abc", inputs: [2, omission: "xy"], expected: "xy" },
          { object: "abc", inputs: [3, omission: "xy"], expected: "abc" },
          { object: "abc", inputs: [4, omission: "xy"], expected: "abc" },
          { object: "abcde", inputs: [3, omission: "xy"], expected: "axy" },
          { object: "abcde", inputs: [4, omission: "xy"], expected: "abxy" },
          { object: "abcde", inputs: [5, omission: "xy"], expected: "abcde" },
          { object: "abcde", inputs: [6, omission: "xy"], expected: "abcde" },
        ]
        include_examples "with_options", "mb_truncate", examples
      end

      context "multibytes-strings" do
        examples = [
          { object: "あいう", inputs: [2, omission: "わを"], expected: "わを" },
          { object: "あいう", inputs: [3, omission: "わを"], expected: "わを" },
          { object: "あいう", inputs: [4, omission: "わを"], expected: "わを" },
          { object: "あいう", inputs: [5, omission: "わを"], expected: "わを" },
          { object: "あいう", inputs: [6, omission: "わを"], expected: "あいう" },
          { object: "あいう", inputs: [7, omission: "わを"], expected: "あいう" },

          { object: "あいうえお", inputs: [4, omission: "わを"], expected: "わを" },
          { object: "あいうえお", inputs: [5, omission: "わを"], expected: "わを" },
          { object: "あいうえお", inputs: [6, omission: "わを"], expected: "あわを" },
          { object: "あいうえお", inputs: [7, omission: "わを"], expected: "あわを" },
          { object: "あいうえお", inputs: [8, omission: "わを"], expected: "あいわを" },
        ]
        include_examples "with_options", "mb_truncate", examples
      end
    end
  end
end
