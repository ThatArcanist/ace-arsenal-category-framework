private _categoryVar = "aceArsenalCategory";
private _categories = createHashMap;

// Get every item that inherits ItemCore
// private _items = (inheritsFrom _x == (configFile >> "CfgWeapons" >> "ItemCore") configClasses configFile);
private _items = "true" configClasses (configFile >> "CfgWeapons");
// Create the category hashmap
{
	// _x is a magic variable, it represnets the current item in a loop
	private _category = [_x >> _categoryVar, "STRING", ""] call CBA_fnc_getConfigEntry;
	// If the item has a category configured
	if !("" == _category) then {
		_categoryItems = _categories getOrDefault [_category, "Not Found"];
		// If there is no category by that name yet
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

	_configClass = (configFile >> "AceArsenalCategory" >> _x ) call BIS_fnc_getCfg;

	_categoryName = [_configClass >> "displayName", "STRING", ""] call CBA_fnc_getConfigEntry;
	_categoryConfigPicture = [_configClass >> "picture", "STRING", ""] call CBA_fnc_getConfigEntry;

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