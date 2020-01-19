#include <amxmodx>
#include <fakemeta>
#include "hl.inc"                     
#define PLUGIN "Team Menu"
#define VERSION "2.3"
#define AUTHOR "Glaster"

new const g_Skins[][] =
{                                                             
"USSR",
"GERMANY",
"USA",
"CHINA",
"VIP",
"ALIENS"
};



stock is_user_admin(id)
{
    new __flags=get_user_flags(id);
    return (__flags>0 && !(__flags&ADMIN_USER));
}


public plugin_precache()
{
for (new i; i < sizeof(g_Skins); i++)
precache_model(fmt("models/player/%s/%s.mdl", g_Skins[i], g_Skins[i]));
}

public plugin_init() {
register_clcmd("say /team", "TeamMenu");
register_plugin(PLUGIN, VERSION, AUTHOR);
}

public TeamMenu(id) {
new i_Menu = menu_create("\yTEAM MENU", "TeamMenu_handler");
menu_additem(i_Menu, "\w[1] GERMANY", "1", 0);
menu_additem(i_Menu, "\w[2] USSR", "2", 0);
menu_additem(i_Menu, "\w[3] USA", "3", 0);
menu_additem(i_Menu, "\w[4] CHINA", "4", 0);
menu_additem(i_Menu, "\y[5] VIP", "5", 0);
menu_additem(i_Menu, "\w[6] ALIENS", "6", 0);
menu_additem(i_Menu, "\r[7] EXIT", "7", 0);
menu_display(id, i_Menu, 0)
}


public TeamMenu_handler(id, menu, item) {
if( item < 0 ) return PLUGIN_CONTINUE;
new cmd[3], access, callback;
menu_item_getinfo(menu, item, access, cmd,2,_,_, callback);
new Choise = str_to_num(cmd) ;
switch (Choise) {
case 1: {           
hl_set_user_team(id, "GERMANY")  
hl_set_user_model(id, g_Skins[1]) 


}
case 2: {
hl_set_user_team(id, "USSR") 
hl_set_user_model(id, g_Skins[0]) 
}
case 3: {

hl_set_user_team(id, "USA") 
hl_set_user_model(id, g_Skins[2]) 

}
case 4: {
hl_set_user_team(id, "CHINA") 
hl_set_user_model(id, g_Skins[3]) 

                                                     
}                              
case 5: { 
if(is_user_admin(id)){ 
hl_set_user_team(id, "VIP") 
hl_set_user_model(id, g_Skins[4]) 
}else {
client_print(id, print_chat, "You shold be VIP or Admin to be a part of this team. You can buy it by vk.com/pristavka2013")
}
}
case 6:{
hl_set_user_team(id, "ALIENS") 
hl_set_user_model(id, g_Skins[5]) 
}
case 7:{
menu_destroy(menu)
}

}
