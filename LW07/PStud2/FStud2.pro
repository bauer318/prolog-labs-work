% Copyright

implement fStud2
    inherits formWindow
    open core, vpiDomains,cStud2


clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onPushButtonClick : button::clickResponder.
clauses
    onPushButtonClick(_Source) = button::defaultAction:-
                    группа_п(Группа),
                    listbox_ctl:add(tostring(Группа)),fail.
    onPushButtonClick(_Source) = button::defaultAction.


predicates
    onEditLoseFocus : window::loseFocusListener.
clauses
    onEditLoseFocus(_Source):-
                    listedit_ctl:clearAll(),
                    Группа = toterm(edit_ctl:getText()),
                    студент_п(Фио, Группа),
                    listedit_ctl:add(Фио),fail.
    onEditLoseFocus(_Source).


predicates
    onPushButton1Click : button::clickResponder.
clauses
    onPushButton1Click(_Source) = button::defaultAction():-listbox_ctl:clearAll().


predicates
    onPushButton2Click : button::clickResponder.
clauses
    onPushButton2Click(_Source) = button::defaultAction():-
                    оценки_средний_балл(listedit_ctl:getText(), Q1, Q2, Q3, 			Sr),
                        Str1 =string::concat( tostring(Q1)," ",tostring(Q2), " ",
                            tostring(Q3)),
                        Str =string::concat(Str1," ",tostring(Sr)),
                        listbox_ctl:add(Str),fail .
    onPushButton2Click(_Source) = button::defaultAction():-
        listbox_ctl:add("Мат Физ Инф Сред балл").

% This code is maintained automatically, do not update it manually. 10:03:44-13.3.2023
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    listbox_ctl : listBox.
    edit_ctl : editControl.
    listEdit_ctl : listEdit.
    pushButton_ctl : button.
    pushButton1_ctl : button.
    pushButton2_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("FStud2"),
        setRect(rct(50,40,421,204)),
        setDecoration(titlebar([closeButton,maximizeButton,minimizeButton])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(48, 136),
        ok_ctl:setSize(56, 16),
        ok_ctl:defaultHeight := false,
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(112, 136),
        cancel_ctl:setSize(56, 16),
        cancel_ctl:defaultHeight := false,
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 136),
        help_ctl:setSize(56, 16),
        help_ctl:defaultHeight := false,
        help_ctl:setAnchors([control::right,control::bottom]),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(4, 26),
        listbox_ctl:setSize(64, 72),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Окно вывода"),
        StaticText_ctl:setPosition(8, 4),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Группа"),
        StaticText1_ctl:setPosition(76, 24),
        edit_ctl := editControl::new(This),
        edit_ctl:setText("Edit"),
        edit_ctl:setPosition(76, 38),
        edit_ctl:addLoseFocusListener(onEditLoseFocus),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Студенты группы"),
        StaticText2_ctl:setPosition(76, 62),
        StaticText2_ctl:setSize(80, 10),
        listEdit_ctl := listEdit::new(This),
        listEdit_ctl:setText("List Edit"),
        listEdit_ctl:setPosition(76, 80),
        pushButton_ctl := button::new(This),
        pushButton_ctl:setText("Список групп"),
        pushButton_ctl:setPosition(204, 20),
        pushButton_ctl:setWidth(56),
        pushButton_ctl:defaultHeight := true,
        pushButton_ctl:setClickResponder(onPushButtonClick),
        pushButton1_ctl := button::new(This),
        pushButton1_ctl:setText("Очистить окно вывода"),
        pushButton1_ctl:setPosition(4, 106),
        pushButton1_ctl:setWidth(88),
        pushButton1_ctl:defaultHeight := true,
        pushButton1_ctl:setClickResponder(onPushButton1Click),
        pushButton2_ctl := button::new(This),
        pushButton2_ctl:setText("Оценки и средний балл студента"),
        pushButton2_ctl:setPosition(104, 106),
        pushButton2_ctl:setWidth(168),
        pushButton2_ctl:defaultHeight := true,
        pushButton2_ctl:setClickResponder(onPushButton2Click).
% end of automatic code
end implement fStud2