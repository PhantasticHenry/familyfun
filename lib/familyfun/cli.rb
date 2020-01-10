class Familyfun::CLI
    def call
        welcome
    end

    def welcome
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
        @@user_name = gets.strip
        sleep 1
        colorizer.write " \n------------------------------------------------------"
        colorizer.write "| Hello #{@@user_name}! Are you ready for some family fun? 🥳   |"
        colorizer.write " ------------------------------------------------------\n"
        sleep 0.5
        if prompt.yes?("\nWould you like see the menu?\n".blue)
        else goodbye
        end

        colorizer.write("\n-----------------------------------------------------------")
        colorizer.write("|      What you would like to do next?      |")
        colorizer.write("----------------------------------------------------------")
    end
end