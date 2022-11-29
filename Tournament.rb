
class Tournament

    attr_accessor :names, :size, :rounds, :cur_round, :curPlayers
    def initialize(size, names)
        @size = size
        @names = names
        @rounds = Math.log2(size).to_i
        @cur_round = 1
        @curPlayers = names

    end

    #Reminder that tournaments need to be structured in sets of 4 people.
    #This means that we need to have the Size % 4 and set empty players if there are extras
    
    #Creates an array filled with arrays that contain 2 players. The two people arrays are a match for that round.
    def setRounds(curPlayers)

        matches = []

        (0..curPlayers.length - 1).step(2) do |n|
            a = [curPlayers[n], curPlayers[n + 1]]
            matches.append(a)

        end
        matches
    end

    def getResults(matches)

        winners = []
        for i in matches
            winner = ""
            while(winner != i[0] and winner != i[1])
                puts("\nEnter the winner between #{i[0]} and #{i[1]}")

                winner = gets.chomp
            end
            winners.append(winner)
        end
        
        @curPlayers = winners
    end


    #Prints out all matches for the round
    def draw(matches)

        if (cur_round == rounds)
            puts("\nGrand Finals")
        else
            puts("\nRound #{cur_round}")
        end

        for i in matches
            puts("#{i[0]} Vs #{i[1]}")

    end
end


#Setup beings here

size = 0
while (size == 0 || size.to_s(2).count('1') != 1)
    puts("Enter amount of participants (Must be in a format of 2^N) >>> ")
    size = gets.to_i
end

i = 0
names = Array.new(size)

while i < size
    puts("Enter Player %d: \n" % [i + 1])
    names[i] = gets.chomp
    i += 1
end
#Shuffle names to randomize them
names = names.shuffle()

t = Tournament.new(size, names)

until t.cur_round == t.rounds + 1

    matches = t.setRounds(t.curPlayers)
    t.draw(matches)
    t.getResults(matches)
    t.cur_round += 1
end

puts("\nWinner of Grand Finals is #{t.curPlayers[0]}!!!")
end