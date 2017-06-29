class Railroad
  def initialize(width, height)
    @width  = width
    @height = height
  end

  def available_entrance_and_exit_positions
    [].tap do |results|
      @width.times do |index|
        results << ['U', 0,           index]
        results << ['D', @height - 1, index]
      end

      @height.times do |index|
        results << ['L', index, 0]
        results << ['R', index, @width - 1]
      end
    end
  end

  def blocks_permutation
    block_images.repeated_permutation(@width * @height).to_a
  end

  def games_permutation
    blocks_permutation.each_with_object([]) do |blocks, games|
      available_entrance_and_exit_positions.permutation(2).each do |entrance_position, exit_position|
        games << Game.new(blocks, width: @width, entrance_position: entrance_position, exit_position: exit_position)
      end
    end
  end

  private

  def block_images
    Dir[Rails.root.join 'app/assets/images/railsroads/*'].shuffle.map do |file_path|
      Hash[file_path[/.*\/(.+).jpg/, 1].chars.each_slice(2).to_a]
    end
  end
end
