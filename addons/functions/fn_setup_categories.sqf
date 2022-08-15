private _categoryVar = "aceArsenalCategory";
private _categories = createHashMap;

// Get every item in CfgWeapons
private _items = "true" configClasses (configFile >> "CfgWeapons");
// Loop  through every item in CfgWeapons and if its configured for a category add it to the hashmap
{
	// _x is a magic variable, it represnets the current item in a loop
	// Get the category configured to the item, if not configured return an empty string
	private _category = [_x >> _categoryVar, "STRING", ""] call CBA_fnc_getConfigEntry;
	// If the item has a category configured
	if !("" == _category) then {
		// If the category isn't in the hashmap it, it returns a String, 
		// if it does exist it then it returns an array of items in the category
		_categoryItems = _categories getOrDefault [_category, "Not Found"];
		// If the type of _categoryItems is a string it means there the category doesn't exist in the hashmap yet
		if (typeName _categoryItems == "STRING") then {

			// Create the category if it doesn't exist and put the item in it
			_categories set [_category, [configName _x]];

		}
		// If there is already a category
		else {
			// Append the current item to the list
			_categoryItems pushBack (configName _x);
			// Overwrite the old list with the new one
			_categories set [_category, _categoryItems];

		};
	};

} forEach _items;

// Get Classes for configuration
private _categoryConfigs = (configFile >> "AceArsenalCategory") call BIS_fnc_getCfgSubClasses;

{
	// Get the Config object for the current category
	_configClass = (configFile >> "AceArsenalCategory" >> _x ) call BIS_fnc_getCfg;

	// Get the configured name and picture of the category
	_categoryName = [_configClass >> "displayName", "STRING", ""] call CBA_fnc_getConfigEntry;
	_categoryConfigPicture = [_configClass >> "picture", "STRING", ""] call CBA_fnc_getConfigEntry;

	// The name in the class needs to match the name thats configured on the items
	_categoryValues = _categories getOrDefault [_categoryName, "Not Found"];
	
	if (typeName _categoryValues == "STRING") then
	{
		diag_log "Incorrect ACE Category Configuration";
	}
	else
	{
		[_categoryValues, _categoryName, _categoryConfigPicture, _forEachIndex] call ace_arsenal_fnc_addRightPanelButton;
	};

} forEach _categoryConfigs;