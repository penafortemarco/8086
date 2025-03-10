```text
_____________________________________________________________________________________
|                  _                            _  ___  ____                        |        
|                 | |    __ _ ___  ___ __ _  __| |/ _ \/ ___|                       |
|                 | |   / _` / __|/ __/ _` |/ _` | | | \___ \                       |
|                 | |__| (_| \__ \ (_| (_| | (_| | |_| |___) |                      |
|                 |_____\__,_|___/\___\__,_|\__,_|\___/|____/                       |    
|                                                                                   |
|- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -|    
|                                                                                   |                    
|            1. Chose between NASM and MASM dir's                                   |            
|                                                                                   |            
|            2. If needed, you can modify build.sh to compile                       |            
|               and test with qemu or dd it to a bootable device                    |            
|                                                                                   |            
|            3. Do "sudo bash build.sh" and have fun with LascadOS                  |            
|                                                                                   |            
|___________________________________________________________________________________|            
			
_____________________________________________________________________________________
|     ___   ___   ___   __     ____  _                 _       _   _                |
|    ( _ ) / _ \ ( _ ) / /_   / ___|(_)_ __ ___  _   _| | __ _| |_(_) ___  _ __     |
|    / _ \| | | |/ _ \| '_ \  \___ \| | '_ ` _ \| | | | |/ _` | __| |/ _ \| '_ \    |
|   | (_) | |_| | (_) | (_) |  ___) | | | | | | | |_| | | (_| | |_| | (_) | | | |   |
|    \___/ \___/ \___/ \___/  |____/|_|_| |_| |_|\__,_|_|\__,_|\__|_|\___/|_| |_|   |
|                                                                                   |
|           1. Enter micro_proteus directory                                        |
|           2. Open the micro.pdsprj archive in Proteus	                            |
|           3. Run "sudo bash build.sh" in micro_proteus dir                        |
|           4. In proteus, click the ROM and select rom.bin                         |
|              and select "raw_nasm\rom.bin" as image file	                    |
|           5. Start the simulation!                                                |
|                                                                                   |
|           Obs: simple bug regarding simulation run makes                          |
|                Proteus crash, needing to 'Force quit'                             |
|           Solution:                                                               |
|	        - Select and delete the entire circuit;                             |
|	        - Run a quick simulation (probably will get an error);              |
|               - Stop the simulation                                               |
|               - 'Ctrl-Z' or click "Undo Changes"                                  |
|                                                                                   |
|___________________________________________________________________________________|
```
