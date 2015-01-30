<%@ Page ASPCompat="True" CodeBehind="datalink.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="VB.datalink" %>
<%@ OutputCache Location="none" %>
<HTML>
	<HEAD>
		<title>Datalink</title>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache" >
		<meta http-equiv="content-type" content="text/html; charset=utf-8" >
		<link rel="stylesheet" type="text/css" href="spssmrNet.css" >
		<script language="javascript" src="dialog.js"></script>
		<script type="text/javascript">         
			function resetToInputConnectionString() {
				try {
					top.propertyMap = {};
					top.syncDefaultValues();
					top.syncConnection(false);
					
					updateMDSCElements();
					updateCDSCElements();
					
					top.sync(top.currentTabIdx(), false);
				}
				catch(e) {
				}
			}
			
			function initConnectionStringValue() {
				document.getElementById('WaitDiv').style.display = 'inline';
				document.getElementById('MainDiv').style.display = 'none';
				
				document.getElementById('ConnectionString').value = top.getInputArguments().ConnectionString;
				setTimeout('document.getElementById("InitPageButton").click()', 300);
			}
			
			function MDMProperties() {          		
				document.getElementById("LoadingMDM").style.display='inline';
				
				path = top.getProperty("Initial Catalog");
				mdsc = top.getProperty("MR Init MDSC");
				version = top.getProperty("MR Init MDM Version");
				language = top.getProperty("MR Init MDM Language");
				context = top.getProperty("MR Init MDM Context");
				labeltype = top.getProperty("MR Init MDM Label Type");
				langres = top.getLangRes();
				
				// NOTE: the parameters goes to an intermediate page which
				// knows each parameter and forwards it to MDMProperties.aspx
				// Any changes in parameterset must therefore be updated in
				// MDMPropertiesDlg.aspx
				
				var url = "MDMPropertiesDlg.aspx?path="+escape(path)+
												"&mdsc="+escape(mdsc)+
												"&langres="+escape(langres)+
												"&version="+escape(version)+
												"&language="+escape(language)+
												"&context="+escape(context)+
												"&labeltype="+escape(labeltype);
				retval = doDialog(url, '630px', '400px');
				
				if(retval) {
					top.setProperty("MR Init MDM Version", retval.version);
					top.setProperty("MR Init MDM Language", retval.language);
					top.setProperty("MR Init MDM Context", retval.context);
					top.setProperty("MR Init MDM Label Type", retval.labeltype);
				}
				document.getElementById("LoadingMDM").style.display='none';
			}
			
			function browseMetaData() {
				try {
					if ( document.getElementById("MDSCBrowseLink").disabled == true ) {
						return;
					}
					var sDSC = document.getElementById("MDSCDropDownList").value;
					var sUrl = urlAddParam(top.getInputArguments().InitFM, "MDSC", sDSC);
					retval = doDialog(sUrl, '500px', '800px');
					if(retval != null) {
						if (retval != "") {
							document.getElementById("MDSCSource").value = retval;
							checkCDSCInMDM()
						}
					}
				}
				catch (e) {}
			}
			
			function checkCDSCInMDM() {
				try {
					var oCDSCDropDownList = document.getElementById('CDSCDropDownList');
					if ( oCDSCDropDownList.value.toLowerCase()!="mrrdbdsc2") {
						return;
					}
					
					var oMDSCDropDownList = document.getElementById('MDSCDropDownList');
					if ( oMDSCDropDownList.selectedIndex==0 || oMDSCDropDownList.value!="") { 
						return
					}
					
					var oMDSCSource = document.getElementById('MDSCSource');
					if ( oMDSCSource.value=="") { 
						return
					}
					
					top.syncConnection(true);
					
					// mrRdbDsc2 + SPSS MR Meta Data Document is selected
					document.getElementById("ConnectionString").value = top.buildConnectionString();
					document.getElementById('WaitDiv').style.display = 'inline';
					document.getElementById('MainDiv').style.display = 'none';
					setTimeout('document.getElementById("UpdateCDSCButton").click()', 300);
				}
				catch(e) {
				}
			}

			function browseCaseData() {
				try {
					if ( document.getElementById("CDSCBrowseLink").disabled == true ) {
						return;
					}
					var sDSC = document.getElementById("CDSCDropDownList").value;
					var sUrl = urlAddParam(top.getInputArguments().InitFM, "CDSC", sDSC);
					retval = doDialog(sUrl, '500px', '800px');
					if(retval != null)
						if(retval != "")
							document.getElementById("CDSCSource").value = retval;
				}
				catch (e) {}
			}
			
			function urlAddParam(sURL, sParamName, sParamValue) {
				var aUrlParts = sURL.split('?');
				
				if ( aUrlParts.length == 0 )
					return "";
				else if ( aUrlParts.length == 1 )
					return aUrlParts[0] + "?" + sParamName + "=" + escape(sParamValue);
				else
					return aUrlParts[0] + "?" + aUrlParts[1] + "&" + sParamName + "=" + escape(sParamValue);
			}
			
			function doCancel() {
				top.closeDataLinkDialog(true);
			}
			
			function doOK() {
				top.closeDataLinkDialog(false);
			}
			
			function selectMDSCDropDownList_Changed() {
				try {
					var oMDSCDropDownList = document.getElementById('MDSCDropDownList');
					var oMDSCSource = document.getElementById('MDSCSource');
					
					oMDSCSource.value = '';
					
					updateMDSCElements();
				}
				catch (e) {}
			}
			
			function updateMDSCElements() {
				
				try {
					var oMDSCDropDownList = document.getElementById('MDSCDropDownList');
					var oMDSCSource = document.getElementById('MDSCSource');
					var oMDSCBrowse = document.getElementById('MDSCBrowseLink');
					var oOpenReadWrite = document.getElementById('OpenReadWrite');
					var oOpenReadWriteLink = document.getElementById('OpenReadWriteLink');
					var oMDMPropertiesLink = document.getElementById('MDMPropertiesLink');
					
					oOpenReadWrite.disabled = (oMDSCDropDownList.value!='' || oMDSCDropDownList.selectedIndex==0);
					OpenReadWriteLink.disabled = oOpenReadWrite.disabled;
					oMDMPropertiesLink.disabled = (oOpenReadWrite.disabled || oMDSCSource.value.replace(/\s/g, "") == '');
					
					if (oMDSCDropDownList.selectedIndex==0) {
						oMDSCSource.disabled = true;
						oMDSCBrowse.disabled = true;
					}
					else {
						switch(aMDSCSourceType[oMDSCDropDownList.value]) {
							case 2:		// drDSN
							case 3:		// drUDL
								oMDSCSource.disabled = false;
								oMDSCBrowse.disabled = true;
								break;
							
							case -1:	// drUnknown
							case 0:		// drFile
							case 1:		// drFolder
							default:
								oMDSCSource.disabled = false;
								oMDSCBrowse.disabled = false;
								break;
						}
					}
				}
				catch (e) {}
			}
			
			function selectCDSCDropDownList_Changed() {
				try {
					var oCDSCDropDownList = document.getElementById('CDSCDropDownList');
					var oCDSCSource = document.getElementById('CDSCSource');
					var oCDSCProject = document.getElementById('CDSCProject');
					
					oCDSCSource.value = '';
					oCDSCProject.value = '';
					
					updateCDSCElements();
					
					checkCDSCInMDM();
				}
				catch (e) {}
			}
			
			function updateCDSCElements() {
				try {
					var oCDSCDropDownList = document.getElementById('CDSCDropDownList');
					var oCDSCSource = document.getElementById('CDSCSource');
					var oCDSCProject = document.getElementById('CDSCProject');
					var oCDSCBrowse = document.getElementById('CDSCBrowseLink');
					
					if (oCDSCDropDownList.selectedIndex==0) {
						oCDSCSource.disabled = true;
						oCDSCBrowse.disabled = true;
						oCDSCProject.disabled = true;
					}
					else {
						switch(aCDSCSourceType[oCDSCDropDownList.value]) {
							case 2:		// drDSN
							case 3:		// drUDL
								oCDSCSource.disabled = false;
								oCDSCBrowse.disabled = true;
								oCDSCProject.disabled = false;
								break;
							
							case -1:	// drUnknown
							case 0:		// drFile
							case 1:		// drFolder
							default:
								oCDSCSource.disabled = false;
								oCDSCBrowse.disabled = false;
								oCDSCProject.disabled = false;
								break;
						}
					}
				}
				catch (e) {}
			}
		</script>
</HEAD>
	<body>
		<form id="datalink" runat="server">
		<table id="TableTranslation" visible="false" style="display: none" >
             <tr>
                <td style="height: 21px">
                    MR Init Allow Dirty</td>
                <td>
                <% =GetLanguageLiteral("MR_Init_Allow_Dirty") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init Category Names</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_Category_Names") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init Category Values</td>
                <td>
              <% =GetLanguageLiteral("MR_Init_Category_Values") %>  </td>
            </tr>
            <tr>
                <td>
                    MR Init Custom</td>
                <td>
                <% =GetLanguageLiteral("MR_Init_Custom") %> 
                </td>
            </tr>
            <tr>
                <td>
                    MR Init Input Locale</td>
                <td>
                    <% =GetLanguageLiteral("MR_Init_Input_Locale") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDM Access</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_MDM_Access") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDM Context</td>
                <td>
                  <% =GetLanguageLiteral("MR_Init_MDM_Context") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDM DataSource Use</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_MDM_DataSource_Use") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDM Document</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_MDM_Document") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDM Label Type</td>
                <td>
                <% =GetLanguageLiteral("MR_Init_MDM_Label_Type") %>
                </td>
                
            </tr>
            <tr>
                <td>
                    MR Init MDM Language</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_MDM_Language") %>
                </td>
            </tr>
            <tr>
                <td style="height: 21px">
                    MR Init MDM Version</td>
                <td style="width: 159px; height: 21px;">
                  <% =GetLanguageLiteral("MR_Init_MDM_Version") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init MDSC</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_MDSC") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init Output Locale</td>
                <td>
                <% =GetLanguageLiteral("MR_Init_Output_Locale") %>
                </td>
            </tr>
            <tr>
                <td>
                    MR Init Project</td>
                <td>
                 <% =GetLanguageLiteral("MR_Init_Project") %>
                </td>
            </tr>
            <tr>
                <td>MR Init Validation</td>
                <td >
                  <% =GetLanguageLiteral("MR_Init_Validation") %>
                </td>
            </tr>
            <tr>            
                <td>
                    Connect Timeout</td>
                <td>
                 <% =GetLanguageLiteral("Connect_Timeout") %>  </td>  
            </tr>
             
            <tr>
                <td>Data Source</td>
                <td>
                    <% =GetLanguageLiteral("Data_Source") %>
                </td>
            </tr>
            <tr>
                <td>Initial Catalog</td>
                <td>
                 <% =GetLanguageLiteral("Initial_Catalog") %>   
                </td>  
            </tr>
            <tr>
                <td>Locale Identifier</td>
                <td><% =GetLanguageLiteral("Locale_Identifier") %></td>
            </tr>
            <tr>
                <td>Location</td>
                <td>
                    <% =GetLanguageLiteral("Location") %>
                </td>  
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <% =GetLanguageLiteral("password_no_colon")%>
                </td>  
            </tr>
            <tr>
                <td>User ID</td>
                <td>
                    <% =GetLanguageLiteral("User_ID") %> 
                </td>  
            </tr>
            <tr>
                <td>Mode</td>
                <td>
                    <% =GetLanguageLiteral("Mode") %>  
                </td>  
            </tr>
        </table>
			<input type="hidden" id="CurrentDivState" value="ConnectionDiv" runat="server">
			<input type="hidden" id="ConnectionString" name="ConnectionString" runat="server">
			<asp:button id="InitPageButton" runat="server" onserverclick="InitPageButton_Click" style="DISPLAY: none" />
			<asp:button id="UpdateCDSCButton" runat="server" onserverclick="UpdateCDSCButton_Click" style="DISPLAY: none" />
			
			<!-- Div to show when dialog is loading -->
			<div id="WaitDiv" style="DISPLAY: none">
				<br>
				<asp:Literal id="WaitTextLiteral" runat="server" Text="Initializing connectionstring properties. Please wait..." />
			</div>
			<div id="MainDiv" style="DISPLAY: none">
				<!-- Content of first tab starts here -->
				<div id="ConnectionDiv" style="DISPLAY:none">
					<br >
					<p>
						<b>
							<asp:Literal id="lMetadataType" runat="server" Text="Metadata Type:" />
						</b>
						<br >
						<select id="MDSCDropDownList" runat="server" onchange="selectMDSCDropDownList_Changed()">
						</select>
					</p>
					<p>
						<b>
							<asp:Literal id="lMetadataLocation" runat="server" Text="Metadata Location:" />
						</b>
						<br>
						<input id="MDSCSource" type="text" runat="server" style="WIDTH: 255px" onChange="updateMDSCElements()" >
						<a id="MDSCBrowseLink" runat="server" style="TEXT-DECORATION: underline" onClick="browseMetaData()">
							Browse:
						</a>
					</p>
					<p>
						<input id="OpenReadWrite" type="checkbox" runat="server" >
						<a id="OpenReadWriteLink" runat="server" style="FONT-WEIGHT: bold" onClick="if(!this.disabled) document.getElementById('OpenReadWrite').click()">
							Open Metadata Read/Write
						</a>
						<br>
					</p>
					<p>
						<a id="MDMPropertiesLink" runat="server" style="TEXT-DECORATION: underline" onClick="MDMProperties()">
							Edit MDM properties</a>&nbsp;&nbsp;<span id="LoadingMDM" runat="server" style="DISPLAY: none">Opening dialog ...</span>
						<br>
					</P>
					<p>
						<b>
							<asp:Literal id="lCaseDataType" runat="server" Text="Case Data Type:" />
						</b>
						<br>
						<select id="CDSCDropDownList" runat="server" onchange="selectCDSCDropDownList_Changed()">
						</select>
					</p>
					<p>
						<b>
							<asp:Literal id="lCaseDataLocation" runat="server" Text="Case Data Location:" />
						</b>
						<br>
						<input id="CDSCSource" runat="server" type="text" style="WIDTH: 255px" >
						<a id="CDSCBrowseLink" runat="server" style="TEXT-DECORATION: underline" onClick="browseCaseData()">
							Browse
						</a>
					</p>
					<p>
						<b>
							<asp:Literal id="lCaseDataProject" runat="server" Text="Case Data Project:" />
						</b>
						<br >
						<input id="CDSCProject" type="text" runat="server" style="WIDTH: 255px" >
					</p>
				</div>
				<!-- XSLT transformation for the other tabs in the dialog -->
				<asp:Xml ID="XmlTabContent" DocumentSource="res/properties.xml" TransformSource="properties.xsl" RunAt="Server" />
				
				<!-- OK and Cancel buttons -->
				<br>
				<input type="button" id="ResetButton" style="width: 90px" runat="server" onClick="resetToInputConnectionString()" class="stdbutton">
				<span style="WIDTH: 60px">&nbsp;</span>
				<input type="button" id="OkButton" runat="server" onClick="doOK()" class="stdbutton">
				&nbsp;
				<input type="button" id="CancelButton" runat="server" onClick="doCancel()" class="stdbutton">
				<br/>
				<br/>
			</div>
		<script language=javascript>
         var tbl= document.getElementById("PropertyList");
         var rowsCollect=tbl.tBodies[0].rows;
         var tblTrans= document.getElementById("TableTranslation");
         var rowsTrans=tblTrans.tBodies[0].rows;
	     for(var i = 1; i<=rowsCollect.length-1; i++)
	     {
    	    for(var j = 0; j<=rowsTrans.length-1; j++)
	        {
    	       if (rowsCollect[i].cells[0].innerText.toUpperCase()==rowsTrans[j].cells[0].innerText.toUpperCase()&&rowsCollect[i].cells[0].innerText!="")
    	        {
    	            rowsCollect[i].cells[0].innerText= rowsTrans[j].cells[1].innerText;
    	        }
            }      
        }
       </script>
		</form>
		
	</body>
</HTML>
