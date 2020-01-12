class Familyfun::CLI
    def call
        welcome
        menu
    end

    def welcome
        Familyfun::Scraper.scrape_events
        system "clear"
        colorizer = Lolize::Colorizer.new
        colorizer.write <<-EOF  



           FFFFFFFFFFFFFFFFFFFFFF                                         iiii   lllllll                              FFFFFFFFFFFFFFFFFFFFFF                                 
           F::::::::::::::::::::F                                        i::::i  l:::::l                              F::::::::::::::::::::F                                  
           F::::::::::::::::::::F                                         iiii   l:::::l                              F::::::::::::::::::::F                                  
           FF::::::FFFFFFFFF::::F                                                l:::::l                              FF::::::FFFFFFFFF::::F                                  
            F:::::F       FFFFFFaaaaaaaaaaaaa      mmmmmmm    mmmmmmm   iiiiiii  l::::lyyyyyyy           yyyyyyy       F:::::F       FFFFFFuuuuuu    uuuuuunnnn  nnnnnnnn    
            F:::::F             a::::::::::::a   mm:::::::m  m:::::::mm i:::::i  l::::l y:::::y         y:::::y        F:::::F             u::::u    u::::un:::nn::::::::nn  
            F::::::FFFFFFFFFF   aaaaaaaaa:::::a m::::::::::mm::::::::::m i::::i  l::::l  y:::::y       y:::::y         F::::::FFFFFFFFFF   u::::u    u::::un::::::::::::::nn 
            F:::::::::::::::F            a::::a m::::::::::::::::::::::m i::::i  l::::l   y:::::y     y:::::y          F:::::::::::::::F   u::::u    u::::unn:::::::::::::::n
            F:::::::::::::::F     aaaaaaa:::::a m:::::mmm::::::mmm:::::m i::::i  l::::l    y:::::y   y:::::y           F:::::::::::::::F   u::::u    u::::u  n:::::nnnn:::::n
            F::::::FFFFFFFFFF   aa::::::::::::a m::::m   m::::m   m::::m i::::i  l::::l     y:::::y y:::::y            F::::::FFFFFFFFFF   u::::u    u::::u  n::::n    n::::n
            F:::::F            a::::aaaa::::::a m::::m   m::::m   m::::m i::::i  l::::l      y:::::y:::::y             F:::::F             u::::u    u::::u  n::::n    n::::n
            F:::::F           a::::a    a:::::a m::::m   m::::m   m::::m i::::i  l::::l       y:::::::::y              F:::::F             u:::::uuuu:::::u  n::::n    n::::n
          FF:::::::FF         a::::a    a:::::a m::::m   m::::m   m::::mi::::::il::::::l       y:::::::y             FF:::::::FF           u:::::::::::::::uun::::n    n::::n
          F::::::::FF         a:::::aaaa::::::a m::::m   m::::m   m::::mi::::::il::::::l        y:::::y              F::::::::FF            u:::::::::::::::un::::n    n::::n
          F::::::::FF          a::::::::::aa:::am::::m   m::::m   m::::mi::::::il::::::l       y:::::y               F::::::::FF             uu::::::::uu:::un::::n    n::::n
          FFFFFFFFFFF           aaaaaaaaaa  aaaammmmmm   mmmmmm   mmmmmmiiiiiiiillllllll      y:::::y                FFFFFFFFFFF               uuuuuuuu  uuuunnnnnn    nnnnnn
                                                                                            y:::::y                                                                         
                                                                                           y:::::y                                                                          
                                                                                          y:::::y                                                                           
                                                                                        y:::::y                                                                            
                                                                                       yyyyyyy  


                    EOF
        puts ''
        puts ''
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        sleep 1.2
        pid = fork{ exec "killall afplay" }
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer.write("\nWhat is your name?  ")
        sleep 1
        @user_name = gets.strip
        sleep 1
        colorizer.write " \n------------------------------------------------------"
        colorizer.write "| Hello #{@user_name}! Are you ready for some family fun? 🥳   |"
        colorizer.write " ------------------------------------------------------\n"
        sleep 0.5
        if prompt.yes?("\nWould you like see the menu?\n".blue)
        else goodbye
        end

        colorizer.write("\n-----------------------------------------------------------")
        colorizer.write("|      What you would like to do next?      |")
        colorizer.write("----------------------------------------------------------")
    end

    def menu
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)

            @menu = [
                {"All events" => -> do list_all_events end},
                {"Free events" => -> do free_events end},
                {"Exit" => -> do goodbye end}
            ]
     
            prompt.select("", @menu)
    end

    def list_all_events
        prompt = TTY::Prompt.new(active_color: :cyan)
        colorizer = Lolize::Colorizer.new
        @all_events = Familyfun::Event.all.each.with_index(1) do |e, i|
            colorizer.write("\n#{i}. #{e.name} - |#{e.date}| - |#{e.location}|\n")
        end
        colorizer.write("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
        colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
        colorizer.write("\n\nAll Events! \n\n")
        colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
        colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n")
        puts "Please number 1-#{@all_events.count}."
        valid = nil
        while !valid
            @user_input = gets.strip.to_i-1
            valid = if (@user_input > 0) && (@user_input < "#{@all_events.count}".to_i)
                system "clear"
                colorizer.write("You have selected: #{@all_events[@user_input].name}\n\n")
                sleep 1
                congrats
                sleep 0.5
                colorizer.write("Date: #{@all_events[@user_input].date}\n")
                sleep 0.5
                colorizer.write("\nLocation: #{@all_events[@user_input].location}\n")
                sleep 0.5
                colorizer.write("\nURL: #{@all_events[@user_input].url}\n")
                sleep 0.5
                colorizer.write("\n#{@all_events[@user_input].details}\n")  
                sleep 0.5
                colorizer.write("\nPrice: #{@all_events[@user_input].price}\n") 
                sleep 0.5
                colorizer.write("\nAddress: #{@all_events[@user_input].address}\n")  
            else puts "Invalid entry #{@user_name}! Please number 1-#{@all_events.count}.".red.bold
            end
        end
        menu2
    end

    def self.user_input
        @user_input
    end

    def free_events
        system "clear"
        free = []
        colorizer = Lolize::Colorizer.new
        Familyfun::Event.all.each do |e|
            if e.price == nil
                free << e
            end
        end
        free.each.with_index(1) do |e, i|
            colorizer.write("\n#{i}. #{e.name} - |#{e.date}| - |#{e.location}|\n")
            end
            colorizer.write("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
            colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
            colorizer.write("\n\nFree Events! \n\n")
            colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
            colorizer.write("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n")
            puts "Please number 1-#{free.count}."
            valid = nil
            while !valid
                @user_input = gets.strip.to_i-1
                valid = if (@user_input > 0) && (@user_input < "#{free.count}".to_i)
                    system "clear"
                    colorizer.write("You have selected: #{free[@user_input].name}\n\n")
                    sleep 1
                    congrats
                    sleep 0.5
                    colorizer.write("Date: #{free[@user_input].date}\n")
                    sleep 0.5
                    colorizer.write("\nLocation: #{free[@user_input].location}\n")
                    sleep 0.5
                    colorizer.write("\nURL: #{free[@user_input].url}\n")
                    sleep 0.5
                    colorizer.write("\n#{free[@user_input].details}\n")  
                    sleep 0.5
                    colorizer.write("\nPrice: Free! #{free[@user_input].price}\n") 
                    sleep 0.5
                    colorizer.write("\nAddress: #{free[@user_input].address}\n")  
                else puts "Invalid entry #{@user_name}! Please number 1-#{free.count}.".red.bold
                end
            end
            menu2
    end

    def congrats
        colorizer = Lolize::Colorizer.new
        colorizer.write <<-DOC


        
            *    *
            *         '       *       .  *   '     .           * *
                                                                        '
                *                *'          *          *        '
            .           *               |               /
                        '.         |    |      '       |   '     *
                        \\*        \\   \\             /
                '          \     '* |    |  *        |*                *  *
                    *      `.       \\   |     *     /    *      '
        .                  \\      |   \\          /               *
            *'  *     '      \\      \\   '.       |
                -._            `                  /         *
        ' '      ``._   *                           '          .      '
            *           *\\*          * .   .      *
        *  '        *    `-._                       .         _..:='        *
                    .  '      *       *    *   .       _.:--'
                *           .     .     *         .-'         *
            .               '             . '   *           *         .
        *       ___.-=--..-._     *                '               '
                                        *       *
                        *        _.'  .'       `.        '  *             *
            *              *_.-'   .'            `.               *
                            .'                       `._             *  '
            '       '                        .       .  `.     .
                .                      *                  `
                        *        '             '                          .
            .                          *        .           *  *
                    *        .                                    '


            DOC
            sleep 1
            colorizer.write ("\tExcellent choice #{@user_name}!\n\n")
            sleep 1
    end

    def menu2
        colorizer = Lolize::Colorizer.new
        prompt = TTY::Prompt.new(active_color: :cyan)
        puts "\n"
        @menu2 = [
            'Back to menu',
            'Exit'
        ]
       
        case prompt.select("Select from list of options.", @menu2)
        when 'Back to menu'
            menu
        when 'Exit'
            goodbye
        end
    end

    def goodbye
        system "clear"
        colorizer = Lolize::Colorizer.new
        pid = fork{ exec "killall afplay" }
        sleep 0.5
        colorizer.write <<-DOC

        ooooo   ooooo                                                                                          .o8             .o8                        .o. 
        `888'   `888'                                                                                         "888            "888                        888 
         888     888   .oooo.   oooo    ooo  .ooooo.        .oooo.         .oooooooo  .ooooo.   .ooooo.   .oooo888        .oooo888   .oooo.   oooo    ooo 888 
         888ooooo888  `P  )88b   `88.  .8'  d88' `88b      `P  )88b       888' `88b  d88' `88b d88' `88b d88' `888       d88' `888  `P  )88b   `88.  .8'  Y8P 
         888     888   .oP"888    `88..8'   888ooo888       .oP"888       888   888  888   888 888   888 888   888       888   888   .oP"888    `88..8'   `8' 
         888     888  d8(  888     `888'    888    .o      d8(  888       `88bod8P'  888   888 888   888 888   888       888   888  d8(  888     `888'    .o. 
        o888o   o888o `Y888""8o     `8'     `Y8bod8P'      `Y888""8o      `8oooooo.  `Y8bod8P' `Y8bod8P' `Y8bod88P"      `Y8bod88P" `Y888""8o     .8'     Y8P 
                                                                          d"     YD                                                           .o..P'          
                                                                          "Y88888P'                                                           `Y8P'
        DOC
        pid = fork{ exec 'afplay', "/Users/henryphan/Downloads/GoodDay_64kb.mp3" }
        sleep 5
        pid = fork{ exec "killall afplay" }
        exit
    end
end