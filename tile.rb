class Tile
    attr_reader :bomb
    def initialize
        @bomb = false
        @flagged = false
        @value = nil
        @revealed = false
    end
    def value=(num)
        @value = num unless @bomb
    end
    def flag
        @flagged = true
    end
    def unflag
        @flagged = false
    end
    def reveal 
        @revealed = true unless @flagged
    end
    def set_bomb
        @bomb = true
    end
    def to_s
        return "F" if @flagged == true
        return "?" if @revealed == false
        return @value.to_s if @bomb == false
        return "*"
    end

end