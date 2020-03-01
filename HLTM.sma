#include <amxmodx>   
#include <fun>
#include <amxmisc>
#include <fakemeta>  
#include <hamsandwich>
#include "hl.inc"   
#include "amxmodx.inc"
#define PLUGIN "Team Menu"
#define VERSION "2.8"
#define AUTHOR "Glaster"  
                        
public user_worthless_change(id,team[]){
 new biba[32]
 get_user_team(id,biba,32)
 if(equal(team,biba,3)){  
   return 1
 }      
  else
  {                             
    return 0
  }
}

new const g_Skins[][] =
{                                                             
"USSR",                
"GERMANY",
"USA",                                               
"CHINA",
"VIP",
"ALIENS!",                  

};


                              
public plugin_precache()
{                                      
  for (new i; i < sizeof(g_Skins); i++)
  precache_model(fmt("models/player/%s/%s.mdl", g_Skins[i], g_Skins[i]));
}
      
public plugin_init() {   
  register_clcmd("say /team", "TeamMenu");
  register_plugin(PLUGIN, VERSION, AUTHOR);                         
  RegisterHam(Ham_Spawn,"player","player_respawn")
}                                           
public player_respawn(id){ 
    new team[32]
    get_user_team(id,team,31)      
    if(!is_user_admin(id)&& equal(team,"VIP",3) ){ 
      strip_user_weapons(id)
      hl_set_user_team(id, "USSR")       
      hl_set_user_model(id, g_Skins[0]) 
      client_print(id,print_center,"WE DON'T NEED HARES!!!")
  }                      
}                                       
                           
                                          
public TeamMenu(id) {
  new i_Menu = menu_create("\yTEAM MENU", "TeamMenu_handler");
  menu_additem(i_Menu, "\y[1] \wGERMANY", "1", 0);
  menu_additem(i_Menu, "\y[2] \wUSSR", "2", 0);
  menu_additem(i_Menu, "\y[3] \wUSA", "3", 0);
  menu_additem(i_Menu, "\y[4] \wCHINA", "4", 0);
  menu_additem(i_Menu, "\r[5] \yVIP", "5", 0);     
  menu_additem(i_Menu, "\y[6] \wALIENS", "6", 0); //ALIENS
  menu_display(id, i_Menu, 0)
}

        
public TeamMenu_handler(id, menu, item) {
  if( item < 0 ) return PLUGIN_CONTINUE;
    new cmd[3], access, callback;
    menu_item_getinfo(menu, item, access, cmd,2,_,_, callback);
    new Choise = str_to_num(cmd) ;
    switch (Choise) {
      case 1: {  
        if(user_worthless_change(id,"GERMANY")!=1){
          strip_user_weapons(id)
          hl_set_user_team(id, "GERMANY")  
          hl_set_user_model(id, g_Skins[1]) 
          }

        }
      case 2: {   
        if(user_worthless_change(id,"USSR")!=1) { 
          strip_user_weapons(id)
          hl_set_user_team(id, "USSR") 
          hl_set_user_model(id, g_Skins[0]) 
        }
      }
      
      case 3: {
      if(user_worthless_change(id,"USA")!=1){            
        strip_user_weapons(id) 
        hl_set_user_team(id, "USA") 
        hl_set_user_model(id, g_Skins[2]) 
      }
  }
      case 4: {  
        if(user_worthless_change(id,"CHINA")!=1){
        strip_user_weapons(id)
        hl_set_user_team(id, "CHINA") 
        hl_set_user_model(id, g_Skins[3]) 
        }
                                                     
    }                              
    case 5: { 
    if(is_user_admin(id)){  
      if(user_worthless_change(id,"VIP")!=1){
        strip_user_weapons(id)
        hl_set_user_team(id, "VIP")  
        hl_set_user_model(id, g_Skins[4])  
      } 
  }
  else {              
    client_print(id, print_chat, "You shold be VIP or Admin to be a part of this team. You can buy it by vk.com/pristavka2013")
  }
 }                     

    case 6:{   
      if(user_worthless_change(id,"ALIENS!")!=1){
        strip_user_weapons(id)  
        hl_set_user_team(id, "ALIENS!") 
        hl_set_user_model(id, g_Skins[5]) 
      }
}              

    case 0:{
      menu_destroy(menu)
  }

 }                       
return PLUGIN_HANDLED;

}           
//Тут был Жора
