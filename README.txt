									////////////////////////
									////// SnackTrack //////
									////////////////////////
1. Intro
======================
SnackTrack is an iOS 7 app designed to help a user keep track of their food collection. The user 
scans their items using their iPhone camera, and from there the UPC code is extracted. This UPC
code is checked against the Outpan UPC database, where we can pull information or add information
if it does not exist. The scanned item goes into a list where it is kept track of along with all 
other scanned items.

2. Features
======================
	Add item - the user can add an item to the list through scanning or manual entry.
	Edit item - the user can change items in the list manually by swiping right on the list view.
	Remove item - the user can remove items through scanning or by swiping left on the list view.
	List storage - the list of items is stored locally on the device, so it can be loaded even 
		after the app has been closed
	Database adding - the user can add an item to the database if there is no record 
	Quantity storage - each item's quantity is stored and can be increased or decreased both 
		manually and through scanning
		
3. Code Description
======================
	Classes
	---------------------
	AppDelegate ( .h/.m )	
		Controls various things that happen when the app starts, closes etc. Currently only loads
		data upon startup
	
	DetailViewController ( .h/.m )
		Controls the food details view (no editing) for an item. Checks if data is valid before displaying.
		
	EditViewController ( .h/.m )
		Controls the edit food item view. Puts data into editable fields and once the user is done editing,
		the list is updated and then saved. The database is NOT updated with changed information.
		
	FoodItem ( .h/.m ) 
		Stores data for the food item, and encodes/decodes from the saved list. Also compares to other food items.
		
	FoodList ( .h/.m )
		Stores and manages food items. Controls searching, adding, removing and loading of food items.
	
	FormViewController ( .h/.m )
		This is the view that allows you to edit information or input information when adding an item from a scan.
		Different from edit view because data is loaded from database instead of the FoodList.
	
	ListViewController ( .h/.m )
		Controls the view that has the list. Shows each item and the image next to it if there is one. Allows for
		moving to edit view or deleting an item.
		
	main ( .m )
		Starts the app using the delegate.
	
	ScanViewController ( .h/.m )
		Controls the view when the user is in the process of scanning. This is connected to the ZBar SDK
		
	UPCParser ( .h/.m )
		This is a static class that connects to the database and pulls information about a specific UPC code,
		or uploads information about an item that was not found to the database.

4. Credits
======================
	ZBar SDK - the development kit that allowed us to easily scan a barcode
	Outpan.com - the database which allows us to download/upload information about food items
	
	App Developers - Thomas Borgia, Kylie Gorman, Brandon Gottlob, Nathaniel Milkosky
	