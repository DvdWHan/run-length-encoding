defmodule RunLengthEncoding do
  # @spec defines the function signature.
  # This function takes a string as input and returns a string as output.
  @spec encode(String.t()) :: String.t()
  def encode(input) do
    groups = get_grouped_characters(input)
    encoded_parts = encode_groups(groups)
    Enum.join(encoded_parts, "")
  end

  # The input is split into graphemes (characters) and then grouped by consecutive identical characters.
  # For example: "aaabbc" would be grouped into [["a", "a", "a"], ["b", "b"], ["c"]].
  defp get_grouped_characters(input) do
    chars = String.graphemes(input)
    groups = Enum.chunk_by(chars, & &1)
  end

  # The groups are encoded into run-length encoding format.
  # For example: [["a", "a", "a"], ["b", "b"], ["c"]] would be encoded into ["3a", "2b", "c"].
  defp encode_groups(groups) do
    encoded_parts = Enum.map(groups, fn group ->
      count = length(group)
      character = hd(group)
      if count == 1 do character else "#{count}#{character}" end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(input), do: decode_loop(String.graphemes(input), 0, "")

  # Pattern matches the end of the input list, returning the accumulated result.
  defp decode_loop([], _number, result), do: result

  # Each character is individually processed.
  # If the character is numeric, it updates the current number being built.
  # Otherwise, it checks if there is a number to determine how many times to repeat the character.
  # For example: "3a2b1c" would be processed to produce "aaabbc".
  defp decode_loop([character | remaining], number, result) do
    if is_numeric(character) do
      new_number = calculate_new_number(number, character)
      decode_loop(remaining, new_number, result)
    else
      if number == 0 do
        decode_loop(remaining, 0, result <> character)
      else
        repeated = String.duplicate(character, number)
        decode_loop(remaining, 0, result <> repeated)
      end
    end
  end

  # Regex matches whether the character is a digit.
  defp is_numeric(character), do: character =~ ~r/\d/

  # Calculate the new number by multiplying the existing number by 10 and adding the integer value of the current character.
  defp calculate_new_number(number, character), do: number * 10 + String.to_integer(character)
end
