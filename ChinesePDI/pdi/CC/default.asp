<!--#INCLUDE FILE="simlib.asp"-->
<FORM METHOD=POST ACTION="https://secure.authorize.net/gateway/transact.dll">
<% 
Dim sequence
Dim amount
Dim ret

' Trim $ dollar sign if it exists
'amount = Request("x_amount")
amount=23.45 


' Seed random number for more security and more randomness
Randomize
sequence = Int(1000 * Rnd)
' Now we need to add the SIM related data like fingerprint to the HTML form.

ret = InsertFP ("pdicards", "LhuReUtn8roZkbGY", amount, sequence)
 %>
<INPUT TYPE=HIDDEN NAME="x_Version" VALUE="3.1">
<INPUT TYPE=HIDDEN NAME="x_Login" VALUE="pdicards">
<INPUT TYPE=HIDDEN NAME="x_Card_Num" VALUE="4007 000 000 027">
<INPUT TYPE=HIDDEN NAME="x_Exp_Date" VALUE="10/27/2003">
<INPUT TYPE=HIDDEN NAME="x_Amount" VALUE="<%=amount%>">
<INPUT TYPE=HIDDEN NAME="x_First_Name" VALUE="Tripp">
<INPUT TYPE=HIDDEN NAME="x_Address" VALUE="1234 Main Street">
<INPUT TYPE=HIDDEN NAME="x_City" VALUE="Atlanta">
<INPUT TYPE=HIDDEN NAME="x_State" VALUE="GA">
<INPUT TYPE=HIDDEN NAME="x_Zip" VALUE="30019">
<INPUT TYPE=HIDDEN NAME="x_Last_Name" VALUE="Pulliam">
<INPUT TYPE=SUBMIT VALUE="Submit">
</FORM>