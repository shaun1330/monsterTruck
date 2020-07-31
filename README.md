# Monster Truck
### Summary

Monster Truck is a GUI/database interface program designed for a local 4wd club. 
Using tkinter python3 and MySQL, the program handles financial record keeping and 
member details. 

#### Features

•	Add/Edit membership details
•	Export member details to excel spreadsheet
•	Issue invoices/receipts
•	Generate invoice/receipt PDFs
•	View transaction history with rolling account balances
•	Easily see unpaid invoices on main menu 
•	View graph of closing balances for all months to see trends 
•	Record club expense and income with custom categories and notes
•	Automatically issue membership renewal invoices
•	Email invoice/receipt PDFs to members through Monster Truck
•	Generate Treasure's report for desired time period


#### Main Menu 


![main_menu.png](screenshots/main_menu.png)

The main menu is where we can find the unpaid invoices, transaction history and balance information. It is the first page shown on start up.  If a database connection is established, all the information is shown in the tables and graphs. 

![no_connection.png](screenshots/no_connection.png)

If a connection cannot be made, an error message will show on start-up and all fields will be empty. All features requiring a database connection will result in an error message. 

#### Members Page


![members_page.png](screenshots/members_page.png)

The members page is where all members details can be viewed and edited. By default, only active members are shown in the members table. To show all members including those inactive, click the ‘Show Inactive Members’ button. To hide inactive members, click again. 

## Add New Member


![add_new_member.png](screenshots/add_new_member.png)

To add a new member, click the ‘New Member’ button. A new window will appear which will allow you to enter the new members details. Once details are filled, click submit. The new member’s member no will be automatically set and shown in the ID column. 

## Edit Member Details


![edit_member.png](screenshots/edit_member.png)

To edit member details, double click the row of the member you want to edit. This will open a window with all the fields prefilled with the members details. To edit the details, simply edit the fields and click submit. 

## Export Members Information to Excel

To export member information, click the ‘Export Members Info’ button. This will update members_list.xlsx file located in the config folder. This will only export active members information. 

#### Invoices

## Issue A New Invoice


![new_invoice.png](screenshots/new_invoice.png)

While at the main menu, click the ‘New Invoice’ button. This will open the new invoice window. First select the member in the dropdown menu for which the invoice will apply. To add an item to the invoice, select one from the item dropdown menu. When you select an item, a pre-set price and quantity will auto fill into the respective fields. These can be edited by entering new values. To add the item to the invoice, click the ‘+’ button to the right of the quantity field. This will add the item to the invoice.


![new_invoicefill1.png](screenshots/new_invoice_fill1.png)  ![new_invoicefill2.png](screenshots/new_invoice_fill2.png)

To remove an item from the invoice, click the item in the table to highlight it and then click the ‘-‘ button at the top right. 
Once all desired items are added to the invoice, select the due date for the invoice from the calendar dropdown. Once done, click ‘Submit Invoice’.

![invoice_created.png](screenshots/invoice_created.png)


