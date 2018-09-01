class Dictionary

  def initialize
    @entries = {}
  end
  def entries
    @entries
  end
  def add(entry)
    if entry.class == Hash
    return  @entries[entry.keys.first] = entry.values.first
  elsif  entry.class == String
    return  @entries[entry] = nil
    end
  end
  def keywords
    @entries.keys.sort
  end
  def include?(word)
    if @entries.keys.first == word
      true
    else
      false
    end
  end
  def find(word)
    @entries.select {|k, v| k.start_with?(word)}
  end
end
