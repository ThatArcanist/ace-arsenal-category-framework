class CfgPatches
{
    class aceAresenalCatagoryFramework
    {
        name = "aceAresenalCatagoryFramework";
        author = "Arcanist";
        requiredVersion = 0.1;
        requiredAddons[] = {};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
	class aceAresenalCatagoryFramework
	{
		class functions
		{
            file = "ace-arsenal-category-framework\addons\functions";
			class setup_categories {
                postInit= 1;
            };
		};
	};
};

class AceArsenalCategory
{
    class MedicalCategory
    {
        displayName = "Medical";
        picture = "ace-arsenal-category-framework\addons\icons\medical.paa";
    };    
    class TestCategory
    {
        displayName = "Test";
        picture = "";
    };    
};