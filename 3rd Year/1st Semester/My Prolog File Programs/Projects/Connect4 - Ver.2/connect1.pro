/*****************************************************************************

		Copyright (c) My Company

 Project:  CONNECT1
 FileName: CONNECT1.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "connect1.inc"
include "connect1.con"
include "hlptopic.con"

%BEGIN_WIN Task Window
/***************************************************************************
		Event handling for Task Window
***************************************************************************/

predicates

  task_win_eh : EHANDLER
 drawImage(Window).
constants

%BEGIN Task Window, CreateParms, 19:02:26-30.5.2011, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings,wsf_Maximized]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "connect1"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

 

clauses
drawImage(Win):-
	Pict1=pict_load("c:\\Connect.bmp"),
	SourceRct1=rct(0,0,640,480),
	DestRct1=rct(0,0,640,480),
	pict_Draw(Win,Pict1,DestRct1,SourceRct1,rop_SrcCopy).
	%Picture=pict_load("c:\\Untitlked.bmp"),pict_draw(_Win,Picture,pnt(0,0),rop_SrcCopy),   

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 19:02:26-30.5.2011, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 19:02:26-30.5.2011, Code automatically updated!
	tb_project_toolbar_Create(_Win),
	tb_help_line_Create(_Win),
%END Task Window, ToolbarCreate
ifdef use_message
	msg_Create(100),
enddef
	win_playing_Create(_Win),
	win_newgame_Create(_Win),
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, id_help_contents
  task_win_eh(_Win,e_Menu(id_help_contents,_ShiftCtlAlt),0):-!,
  	vpi_ShowHelp("connect1.hlp"),
	!.
%END Task Window, id_help_contents

%BEGIN Task Window, id_help_about
  task_win_eh(Win,e_Menu(id_help_about,_ShiftCtlAlt),0):-!,
	dlg_about_dialog_Create(Win),
	!.
%END Task Window, id_help_about

%BEGIN Task Window, id_file_exit
  task_win_eh(Win,e_Menu(id_file_exit,_ShiftCtlAlt),0):-!,
  	win_Destroy(Win),
	!.
%END Task Window, id_file_exit

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
ifdef use_tbar
	toolbar_Resize(_Win),
enddef
ifdef use_message
	msg_Resize(_Win),
enddef
	!.
%END Task Window, e_Size

%END_WIN Task Window

/***************************************************************************
		Invoking on-line Help
***************************************************************************/

  project_ShowHelpContext(HelpTopic):-
  	vpi_ShowHelpContext("connect1.hlp",HelpTopic).

/***************************************************************************
			Main Goal
***************************************************************************/

goal

ifdef use_mdi
  vpi_SetAttrVal(attr_win_mdi,b_true),
enddef
ifdef ws_win
  ifdef use_3dctrl
    vpi_SetAttrVal(attr_win_3dcontrols,b_true),
  enddef
enddef  
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"connect1",task_win_Title).

%BEGIN_TLB Project toolbar, 19:08:01-27.5.2011, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Project toolbar
**************************************************************************/

clauses

  tb_project_toolbar_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_top,0xC0C0C0,_Parent,
		[tb_ctrl(id_file_new,pushb,idb_new_up,idb_new_dn,idb_new_up,"New;New file",1,1),
		 tb_ctrl(id_file_open,pushb,idb_open_up,idb_open_dn,idb_open_up,"Open;Open file",1,1),
		 tb_ctrl(id_file_save,pushb,idb_save_up,idb_save_dn,idb_save_up,"Save;File save",1,1),
		 separator,
		 tb_ctrl(id_edit_undo,pushb,idb_undo_up,idb_undo_dn,idb_undo_up,"Undo;Undo",1,1),
		 tb_ctrl(id_edit_redo,pushb,idb_redo_up,idb_redo_dn,idb_redo_up,"Redo;Redo",1,1),
		 separator,
		 tb_ctrl(id_edit_cut,pushb,idb_cut_up,idb_cut_dn,idb_cut_up,"Cut;Cut to clipboard",1,1),
		 tb_ctrl(id_edit_copy,pushb,idb_copy_up,idb_copy_dn,idb_copy_up,"Copy;Copy to clipboard",1,1),
		 tb_ctrl(id_edit_paste,pushb,idb_paste_up,idb_paste_dn,idb_paste_up,"Paste;Paste from clipboard",1,1),
		 separator,
		 separator,
		 tb_ctrl(id_help_contents,pushb,idb_help_up,idb_help_down,idb_help_up,"Help;Help",1,1)]),
enddef
	true.
%END_TLB Project toolbar

%BEGIN_TLB Help line, 19:08:01-27.5.2011, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Help line
**************************************************************************/

clauses

  tb_help_line_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_bottom,0xC0C0C0,_Parent,
		[tb_text(idt_help_line,tb_context,452,0,4,10,0x0,"")]),
enddef
	true.
%END_TLB Help line

%BEGIN_DLG About dialog
/**************************************************************************
	Creation and event handling for dialog: About dialog
**************************************************************************/

constants

%BEGIN About dialog, CreateParms, 19:08:01-27.5.2011, Code automatically updated!
  dlg_about_dialog_ResID = idd_dlg_about
  dlg_about_dialog_DlgType = wd_Modal
  dlg_about_dialog_Help = idh_contents
%END About dialog, CreateParms

predicates

  dlg_about_dialog_eh : EHANDLER

clauses

  dlg_about_dialog_Create(Parent):-
	win_CreateResDialog(Parent,dlg_about_dialog_DlgType,dlg_about_dialog_ResID,dlg_about_dialog_eh,0).

%BEGIN About dialog, idc_ok _CtlInfo
  dlg_about_dialog_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtrlInfo),0):-!,
	win_Destroy(_Win),
	!.
%END About dialog, idc_ok _CtlInfo
%MARK About dialog, new events

  dlg_about_dialog_eh(_,_,_):-!,fail.

%END_DLG About dialog

