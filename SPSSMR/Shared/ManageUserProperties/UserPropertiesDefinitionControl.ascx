<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserPropertiesDefinitionControl.ascx.cs" Inherits="ManageUserProperties.UserPropertiesDefinitionControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<script language=javascript type="text/javascript">
    
     var StringHelper = new Object();
     StringHelper.Format = function(format)
     {
        if ( arguments.length == 0 )
        {
            return '';
        }
        if ( arguments.length == 1 )
        {
            return String(format);
        }

        var strOutput = '';
        for ( var i=0 ; i < format.length-1 ; )
        {
            if ( format.charAt(i) == '{' && format.charAt(i+1) != '{' )
            {
                var index = 0, indexStart = i+1;
                for ( var j=indexStart ; j <= format.length-2 ; ++j )
                {
                    var ch = format.charAt(j);
                    if ( ch < '0' || ch > '9' ) break;
                }
                if ( j > indexStart )
                {
                    if ( format.charAt(j) == '}' && format.charAt(j+1) != '}' )
                    {
                         for ( var k=j-1 ; k >= indexStart ; k-- )
                         {
                             index += (format.charCodeAt(k)-48)*Math.pow(10, j-1-k);
                         }  
                        var swapArg = arguments[index+1];
                        strOutput += swapArg;
                        i += j-indexStart+2;
                        continue;
                    }
                }
                strOutput += format.charAt(i);
                i++;
            }
            else
            {
                if ( ( format.charAt(i) == '{' && format.charAt(i+1) == '{' )
                    || ( format.charAt(i) == '}' && format.charAt(i+1) == '}' ) )
                {
                    i++
                }
                strOutput += format.charAt(i);
                i++;
            }
        }
        strOutput += format.substr(i);
        return strOutput;
     }   
    
    
    var ListUtil = new Object();
    ListUtil.add = function(oListbox, sName, sValue, bSelected)
    {
        var oOption = document.createElement("option");
        oOption.appendChild(document.createTextNode(sName));
        
        if(arguments.length == 3)
        {
           oOption.setAttribute("value", sValue);
        }
        if(arguments.length == 4)
        {
           oOption.setAttribute("selected", bSelected);
        }
        
        oListbox.appendChild(oOption);
    }
    ListUtil.clear = function(oListbox)
    {
       for( var i=oListbox.options.length-1; i>=0; i-- )
       {
          ListUtil.remove(oListbox, i);
       }
    }
    ListUtil.remove = function(oListbox, iIndex)
    {
        oListbox.remove(iIndex);
    }
    ListUtil.getSelectedIndexs = function(oListbox)
    {
        var arrIndexes = new Array;  
        
        for(var i=10; i<oListbox.options.length; i++)
        {
            if(oListbox.options[i].selected)
            {
                arrIndexes.push(i);
            }
        }
        return arrIndexes;
    }
    
    String.prototype.trim  =  function()
    {
        //  using regular expression replace blank
        return  this.replace(/(^\s*)|(\s*$)/g,  "");
    }
    
    String.prototype.endWith=function(oString)
    { 
        var reg=new RegExp(oString+"$"); 
        return reg.test(this); 
    } 
    
    function SetDefaultDropValue(_dropdownlist, _input, _inputhid){   

        var _selectedVaule = _dropdownlist.options[_dropdownlist.selectedIndex].text;
        var arrText = _input.value.trim();

        if(arrText.endWith(','))
        {
            arrText=arrText.substr(0,arrText.length-1);
        }
        var arr = ParseArray(arrText);
        
        //clear dropdownlist
        ListUtil.clear(_dropdownlist);        
        //add match any item, matchAny is localization value, matchAnyValue equals to SPSSMR.Constants.RequestIDs.MatchAny, it is a constants vaule.
        ListUtil.add(_dropdownlist, matchAny.trim() , matchAnyValue);
        _inputhid.value = matchAnyValue.trim();
        
        for(var i=0; i<arr.length; i++)
        {
            if(arr[i].trim()!="")
            {
                if(arr[i].trim() == _selectedVaule)
                {
                    ListUtil.add(_dropdownlist, arr[i].trim(), arr[i].trim(),true);
                    _inputhid.value = arr[i].trim();
                }
                else
                    ListUtil.add(_dropdownlist, arr[i].trim(), arr[i].trim());
            }
        }
    }
    
    function ApplyCheck(_dropdownlist, _input , _type, _selectionType, _typeList, _selectionTypeList)
    {
        var confirmModify = true;
        if(_type.value != _typeList.selectedIndex || _selectionType.value != _selectionTypeList.selectedIndex)
        {
            return confirm(changeTypeWarning);
        }
        
        
        var _selectedVaule = _dropdownlist.options[_dropdownlist.selectedIndex].text;
        var arrText = _input.value.trim();
        //var arrNew = arrText.split(',');
        var arrNew = ParseArray(arrText);
        
        for(var i=0; i<arrOriginal.length; i++)
        {
            var optionArr = arrOriginal[i].split(',');
            var optionName = optionArr[0];
            var optionAssignCount = optionArr[1];
            var hasDeleteOption=true;
            
            for(var i=0; i<arrNew.length; i++)
            {
                if(arrNew[i].trim()==optionName.trim())
                {
                    hasDeleteOption=false;
                    break;
                }
            }
            if(hasDeleteOption&&optionAssignCount>0)
            {
                confirmModify = confirm(StringHelper.Format(confirmMsg, _selectedVaule));
                break;
            }
            
        }
        return confirmModify;
    }
    
    function ParseArray(text)
    {
        var arrText = new Array;  
        var arr1 = text.split(',');
        for(var i=0; i<arr1.length; i++)
        {
            arr2 = arr1[i].split('\r\n');
            for(var j=0; j<arr2.length; j++)
            {
                arrText.push(arr2[j].trim());
            }
        }
        return  arrText;
    }
    
    function DDLDefaultSelectIndexChanged(_dropdownlist, _inputhidden)
    {
        _inputhidden.value = _dropdownlist.options[_dropdownlist.selectedIndex].value;
    }
       
</script>
<TABLE width="100%" cellSpacing="0">
    <tr>
        <td vAlign="top" width="100%" colSpan="2">
            <asp:datagrid id="UserPropertiesGrid" Width="100%" Enabled="True" ShowFooter="True" AutoGenerateColumns="False"
                BorderColor="#999999" BorderStyle="None" BackColor="White" CellPadding="3"
                GridLines="None" runat="server">
                <AlternatingItemStyle ForeColor="#00066" BackColor="#EFF7FF"></AlternatingItemStyle>
                <ItemStyle ForeColor="#00066" BackColor="White"></ItemStyle>
                <HeaderStyle Font-Bold="True" CssClass="RoundedTableLightHeader"></HeaderStyle>
                <SelectedItemStyle ForeColor="#00066" BackColor="#BBBBBB"></SelectedItemStyle>
                <EditItemStyle VerticalAlign="Top" />
                <FooterStyle ForeColor="#00066" BackColor="White" VerticalAlign="Top"></FooterStyle>
                <PagerStyle HorizontalAlign="Center" ForeColor="Black" BackColor="#999999" Mode="NumericPages"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="15%" />
                        <ItemTemplate>
                            <asp:LinkButton Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' style="text-decoration:none" ForeColor="Black" CommandName="Select" Runat="server"/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label Runat="server" ID="PropertyEditLbl" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'/>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox Runat="server" ID="PropertyTxt" Visible="False" />
                            <asp:RequiredFieldValidator ID="PropertyReqiredVld" ControlToValidate="PropertyTxt" Runat="server" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="PropertyRegexVld" ControlToValidate="PropertyTxt" Runat="server" Display="Dynamic"
                                EnableClientScript="False" />
                            <asp:LinkButton Runat="server" ID="AddLnkBtn" CommandName="Add" style="text-decoration:none" ForeColor="Black"
                                BorderStyle="Dashed" BorderWidth="1" OnClick="UserPropertiesGrid_Add" Visible="True" />
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="20%" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Description") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox Runat="server" ID="DescriptionEditTxt" Width="95%"
 Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>' />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox Runat="server" ID="DescriptionTxt" Width="95%" Visible="False" />
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="10%" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Type") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Runat="server" ID="TypeEditDList" DataTextField="Name" DataSource='<%# PopulateTypeDList() %>' AutoPostBack="True" OnSelectedIndexChanged="UserPropertyDefinitionControl_TypeChanged"  />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList Runat="server" ID="TypeDList" DataTextField="Name" DataSource='<%# PopulateTypeDList() %>' AutoPostBack="True" OnSelectedIndexChanged="UserPropertyDefinitionControl_TypeChanged" Visible="False"/>
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="10%" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "SelectType") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Runat="server" ID="MultiplicityEditDList" DataTextField="Name" DataSource='<%# PopulateMultiplicityDList() %>' AutoPostBack="True" OnSelectedIndexChanged="UserPropertyDefinitionControl_MultChanged"/>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList Runat="server" ID="MultiplicityDList" DataTextField="Name" DataSource='<%# PopulateMultiplicityDList() %>' AutoPostBack="True" OnSelectedIndexChanged="UserPropertyDefinitionControl_MultChanged" Visible="False"/>
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderStyle Width="20%" />
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "Options") %>
                        </ItemTemplate>
                        <EditItemTemplate>  
                            <asp:TextBox Runat="server" ID="OptionEditTxt" Rows="3" Width="95%" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container.DataItem, "Options") %>'/>
                        </EditItemTemplate>
                        
                        <FooterTemplate>                  
                            <asp:TextBox Runat="server" ID="OptionTxt" Rows="3" Width="95%" TextMode="MultiLine" Visible="False" />  
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn>
                        <HeaderStyle Width="20%" />
                        <ItemTemplate>
                            <asp:Label Runat="server" ID="DefaultLabel" Text='<%# DataBinder.Eval(Container.DataItem, "Default") %>'/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <table>
                                <tr>
                                    <td align="left" width="100%" valign="top">
                                        <asp:DropDownList Runat="server" ID="DefaultEditDDL" Width="95%" DataTextField="Text" DataValueField="Value"  DataSource='<%# PopulateDefaultSettingDList(DataBinder.Eval(Container.DataItem, "Name")) %>'/>
                                    </td>
                                    <td align="right" valign="bottom" >
                                        <asp:Button Runat="server" ID="CommitEditBtn" CommandName="EditCommit" Width="60px" OnClick="UserPropertiesDefinitionControl_Commit"
                                            Text="Apply" CausesValidation="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="100%">
                                    </td>
                                    <td align="right" valign="top">
                                        <asp:Button Runat="server" ID="AbortEditBtn" CommandName="EditAbort" Width="60px" OnClick="UserPropertiesDefinitionControl_Abort"
                                            Text="Cancel" CausesValidation="False" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        
                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td align="left" width="100%" valign="top">
                                        <asp:DropDownList Runat="server" ID="DefaultDDL" Width="95%" DataTextField="Text" DataValueField="Value"  DataSource='<%# PopulateDefaultSettingDList() %>'  Visible="False" />
                                    </td>
                                    <td align="right" valign="bottom">
                                        <asp:Button Runat="server" ID="CommitBtn" CommandName="EditCommit" Text="Apply" Width="60px"
                                            OnClick="UserPropertiesDefinitionControl_Commit" Visible="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="100%">
                                    </td>
                                    <td align="right" valign="top">
                                        <asp:Button Runat="server" ID="AbortBtn" CommandName="EditAbort" Text="Cancel" Width="60px"
                                            OnClick="UserPropertiesDefinitionControl_Abort" CausesValidation="False" Visible="False" />
                                    </td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid>
        </td>
    </tr>
</TABLE>
<asp:HiddenField ID="_hiddenDefaultSetting" runat="server" Visible="true" />
<asp:HiddenField ID="_hiddenType" runat="server" Visible="true" />
<asp:HiddenField ID="_hiddenSelectionType" runat="server" Visible="true" />

