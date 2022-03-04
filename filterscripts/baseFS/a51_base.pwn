// -----------------------------------------------------------------------------
// Example Filterscript for the Area 51 (69) Base Objects
// ------------------------------------------------------
// By Matite in March 2015
//
//
// This script removes the existing GTASA Area 51 (69) land section, fence and
// buildings. It then replaces the land section and buildings with the new
// enterable versions. It also replaces the perimeter fence and adds two
// gates that can be opened or closed.
//
// Warning...
// This script uses a total of:
// * 11 objects = 1 for the replacement land object, 7 for the replacement
//   building objects, 1 for the outer fence and 2 for the gates
// * Enables the /a51 command to teleport the player to the Area 51 (69) Base
// * 2 3D Text Labels = 1 on each gate
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Includes
// --------

// SA-MP include
#include <a_samp>

// For PlaySoundForPlayersInRange()
#include "../include/gl_common.inc"


// -----------------------------------------------------------------------------
// Defines
// -------

// Used for messages sent to the player
#define COLOR_MESSAGE_YELLOW        0xFFDD00AA

// Used for the northern and eastern A51 (69) gates status flags
#define GATES_CLOSED  	0
#define GATES_CLOSING  	1
#define GATES_OPEN    	2
#define GATES_OPENING   3


// -----------------------------------------------------------------------------
// Constants
// ---------

// Gate names for the 3D text labels
static GateNames[2][] =
{
	"Northern Gate",
	"Eastern Gate"
};

// -----------------------------------------------------------------------------
// Variables
// ---------

// Stores the created object numbers of the replacement Area 51 (69) land object,
// buildings and fence so they can be destroyed when the filterscript is unloaded
new A51LandObject; 		// Land object
new A51Buildings[7]; 	// Building object
new A51Fence;           // Fence
new A51NorthernGate;    // Northern Gate
new A51EasternGate;     // Eastern Gate

// Stores a reference to the 3D text labels used on each set of gates so they
// can be destroyed when the filterscript is unloaded
new Text3D:LabelGates[2];

// Stores the current status of the northern gate
new NorthernGateStatus = GATES_CLOSED;

// Stores the current status of the eastern gate
new EasternGateStatus = GATES_CLOSED;


// -----------------------------------------------------------------------------
// Callbacks
// ---------

public OnPlayerCommandText(playerid, cmdtext[])
{


	// Exit here (return 0 as the command was not handled in this filterscript)
	return 0;
}

public OnFilterScriptInit()
{
//Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Remove Buildings///////////////////////////////////////////////////////////////////////////////////////////////
RemoveBuildingForPlayer(playerid, 13759, 1413.414, -804.742, 83.437, 0.250);
RemoveBuildingForPlayer(playerid, 673, 1398.585, -838.234, 46.171, 0.250);
RemoveBuildingForPlayer(playerid, 13722, 1413.414, -804.742, 83.437, 0.250);
RemoveBuildingForPlayer(playerid, 13831, 1413.414, -804.742, 83.437, 0.250);

//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
new tmpobjid;
tmpobjid = CreateDynamicObject(18981, 1439.427368, -812.932861, 67.582397, 0.000000, 0.000000, 87.421920, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 11150, "ab_acc_control", "ws_shipmetal5", 0x00000000);
tmpobjid = CreateDynamicObject(18981, 1422.053710, -812.151184, 67.582397, 0.000000, 0.000000, 87.421920, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 11150, "ab_acc_control", "ws_shipmetal5", 0x00000000);
tmpobjid = CreateDynamicObject(18981, 1419.174438, -812.022216, 67.582397, 0.000000, 0.000000, 87.421920, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 11150, "ab_acc_control", "ws_shipmetal5", 0x00000000);
tmpobjid = CreateDynamicObject(7914, 1412.146484, -811.788818, 76.939132, 0.000000, 0.000000, -2.700031, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} N", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1416.211059, -812.000366, 76.939132, 0.000000, 0.000000, -2.700031, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} D", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1444.580932, -813.353759, 76.850799, 0.000000, 0.000000, -3.399997, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} N", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1448.304931, -813.574584, 76.850799, 0.000000, 0.000000, -3.399997, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} D", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1408.338134, -811.717407, 76.939132, 0.000000, 0.000000, -1.100031, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} U", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1420.067993, -812.155151, 76.852317, 0.000000, 0.000000, -2.499994, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} E", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1424.037353, -812.338562, 76.886306, 0.000000, 0.000000, -2.499999, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} R", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1428.213989, -812.561645, 76.949661, 0.000000, 0.000000, -1.300000, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} G", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1440.916625, -813.135742, 76.850799, 0.000000, 0.000000, -3.399997, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} U", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1432.884887, -812.719482, 76.839103, 0.000000, 0.000000, -2.200002, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} R", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
tmpobjid = CreateDynamicObject(7914, 1436.761474, -812.873962, 76.865303, 0.000000, 0.000000, -2.500000, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{00ccff} O", 80, "Ariel", 70, 1, 0x00000000, 0x00000000, 1);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(19840, 1412.781860, -820.179077, 65.040863, 20.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(7916, 1420.324340, -832.008178, 54.031898, 20.000000, 0.000000, 355.487396, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19841, 1434.668579, -826.164489, 53.975471, -20.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(7916, 1420.180541, -833.107299, 55.542140, 20.000000, 0.000000, 354.856414, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(7916, 1415.600585, -830.595092, 56.920539, 20.000000, 0.000000, 351.992401, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(7916, 1418.808471, -823.657897, 63.501499, 20.000000, 0.000000, 357.814239, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19841, 1433.769409, -824.473510, 59.462398, -20.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1416.806762, -823.676879, 57.051750, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1399.694824, -836.239685, 49.209949, 0.000000, 0.000000, 150.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1418.004760, -840.750122, 47.120021, 0.000000, 0.000000, 117.417686, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1453.524291, -839.806945, 56.641288, 0.000000, 0.000000, 116.526618, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1442.292724, -815.303161, 71.722259, 0.000000, 0.000000, 359.797088, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1433.932373, -842.326049, 50.250888, 0.000000, 0.000000, 6.077020, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1415.752807, -813.882934, 70.845970, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1420.201782, -840.308349, 48.031330, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1413.135986, -835.523742, 46.753650, 0.000000, 0.000000, 100.882476, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1416.185546, -810.262084, 70.421310, 0.000000, 0.000000, 102.344741, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1441.813232, -808.900085, 69.894653, 0.000000, 0.000000, 122.483657, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1404.767578, -839.825866, 46.127868, 0.000000, 0.000000, 150.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1406.121215, -839.286926, 46.819030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1439.600830, -843.773437, 50.853298, 0.000000, 0.000000, 7.334548, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1412.820678, -837.534301, 45.992740, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1447.333740, -840.842041, 50.917869, 0.000000, 0.000000, 0.100000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1419.242309, -813.465942, 67.671783, 0.000000, 0.000000, 0.100000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1444.111206, -843.724182, 52.034568, 0.000000, 0.000000, 116.907592, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1399.693603, -838.284851, 47.843441, 0.000000, 0.000000, 359.182708, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1450.739624, -840.136535, 55.916080, 0.000000, 0.000000, 358.934509, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1414.087402, -840.846923, 46.910839, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1432.121704, -813.820312, 70.859626, 0.000000, 0.000000, 359.452728, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1419.317382, -836.369689, 46.712020, 0.000000, 0.000000, 0.713230, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1433.304321, -839.602966, 48.569309, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(6298, 1431.403808, -795.672302, 81.131797, 0.000000, 0.000000, -10.200002, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1402.807739, -835.150695, 46.299629, 0.000000, 0.000000, 0.713230, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1399.401000, -839.778808, 43.389980, 0.000000, 0.000000, 0.713230, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1440.767089, -842.168212, 48.705139, 0.000000, 0.000000, 0.789749, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(7916, 1419.687377, -819.908203, 65.647552, 20.000000, 0.000000, 355.487396, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1450.688964, -845.825195, 53.909358, 0.000000, 0.000000, 116.907592, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1445.537475, -842.117004, 53.275188, 0.000000, 0.000000, 358.934509, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(820, 1425.659057, -840.446472, 46.712020, 0.000000, 0.000000, 0.713230, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1436.540039, -813.683959, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1419.311889, -812.817871, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1442.445312, -813.908935, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1431.065917, -813.399108, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1424.812500, -813.126708, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1458.459716, -830.497924, 59.890312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1426.549194, -835.873901, 49.663539, 0.000000, 0.000000, 100.982482, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1437.873046, -841.009216, 48.956390, 0.000000, 0.000000, 0.100000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1397.934814, -840.371032, 46.069850, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1427.917968, -842.197753, 49.691600, 0.000000, 0.000000, 2.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1449.769165, -815.269714, 68.943298, 0.000000, 0.000000, 43.100013, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(880, 1426.270263, -812.990539, 71.291236, 0.000000, 0.000000, 359.797088, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(744, 1434.596435, -814.207824, 66.843223, 0.000000, 0.000000, 0.100000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1422.573852, -813.864440, 70.845970, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1431.639892, -813.512634, 70.845970, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1430.355957, -815.200927, 70.124618, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1438.156372, -815.194152, 70.124618, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1428.711791, -808.217346, 70.421310, 0.000000, 0.000000, 102.344741, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1424.409301, -815.359985, 69.704078, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(879, 1437.402954, -842.316955, 51.266719, 0.000000, 0.000000, 218.786941, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(748, 1427.688354, -815.368286, 70.124618, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19840, 1443.206665, -836.665039, 54.503669, 20.000000, 0.000000, 352.364440, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1427.696411, -839.420166, 49.774108, 0.000000, 0.000000, 359.452728, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(624, 1480.234619, -837.953247, 59.313018, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(624, 1407.933471, -789.343688, 82.782890, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(822, 1427.724121, -814.986206, 68.601417, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(822, 1439.926635, -814.597290, 68.490951, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(806, 1429.426391, -838.733825, 50.428489, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1467.379150, -821.667785, 63.590324, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(806, 1435.859741, -839.873962, 50.428489, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1457.178955, -803.597595, 77.210334, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(806, 1404.322753, -837.418212, 49.707130, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1463.656738, -844.945739, 54.513385, 0.000000, 0.000000, 359.779052, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(624, 1447.588012, -799.145019, 82.195381, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1394.026245, -839.923706, 46.049301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(822, 1418.756835, -814.273193, 68.601417, 0.000000, 0.000000, 0.201000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(647, 1416.514770, -814.111083, 70.859626, 0.000000, 0.000000, 359.452728, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1430.567138, -840.540771, 50.353244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1433.828002, -840.540771, 50.353244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1437.418090, -842.140869, 51.363239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1441.148437, -842.140869, 52.733234, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1441.148437, -842.140869, 52.733234, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1445.108764, -842.140869, 54.923225, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1416.267089, -840.720642, 49.513221, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1416.267089, -840.720642, 49.513221, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1408.516967, -839.900024, 48.323234, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18747, 1408.516967, -841.360351, 48.083240, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1398.447998, -803.597595, 76.870346, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1442.445312, -813.908935, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1436.540039, -813.683959, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1431.065917, -813.399108, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1424.812500, -813.126708, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1419.311889, -812.817871, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(620, 1398.447998, -819.247863, 67.630348, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1407.756713, -812.211730, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1407.756713, -812.211730, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1413.098999, -812.491699, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1413.098999, -812.491699, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1451.220581, -814.239135, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1451.220581, -814.239135, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1446.716186, -814.002929, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1226, 1446.716186, -814.002929, 76.781799, 0.000000, 0.000000, 87.000000, -1, -1, -1, 300.00, 300.00);
	// Exit here
	return 1;
}

public OnFilterScriptExit()
{
    // Check for valid object
	if (IsValidObject(A51LandObject))
	{
		// Destroy the A51 land object
		DestroyObject(A51LandObject);

		// Display information in the Server Console
		print("  |---------------------------------------------------");
    	print("  |--  Area 51 (69) Land object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51Fence))
	{
		// Destroy the A51 fence object
		DestroyObject(A51Fence);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Fence object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51NorthernGate))
	{
		// Destroy the A51 northern gate object
		DestroyObject(A51NorthernGate);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Northern Gate object destroyed");
    }
    
    // Check for valid object
	if (IsValidObject(A51EasternGate))
	{
		// Destroy the A51 eastern gate object
		DestroyObject(A51EasternGate);

		// Display information in the Server Console
    	print("  |--  Area 51 (69) Eastern Gate object destroyed");
    }
    
    // Loop
    for (new i = 0; i < sizeof(A51Buildings); i++)
    {
	    // Check for valid object
		if (IsValidObject(A51Buildings[i]))
		{
			// Destroy the A51 building object
			DestroyObject(A51Buildings[i]);

			// Display information in the Server Console
		   	printf("  |--  Area 51 (69) Building object %d destroyed", i + 1);
	    }
    }
    
    // Destroy 3D Text Labels on the northern and eastern gates
    Delete3DTextLabel(LabelGates[0]);
    Delete3DTextLabel(LabelGates[1]);

    // Display information in the Server Console
   	print("  |--  Deleted the 3D Text Labels on the Area 51 (69) Gates");

   	// Display information in the Server Console
	print("  |---------------------------------------------------");
	print("  |--  Area 51 (69) Base Objects Filterscript Unloaded");
	print("  |---------------------------------------------------");

    // Exit here
	return 1;
}

public OnPlayerConnect(playerid)
{
    // Remove default GTASA Area 51 (69) land and buildings for the player
	RemoveBuildingForPlayer(playerid, 16203, 199.344, 1943.79, 18.2031, 250.0); 	// Land
	RemoveBuildingForPlayer(playerid, 16590, 199.344, 1943.79, 18.2031, 250.0); 	// Land LOD
	RemoveBuildingForPlayer(playerid, 16323, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings
    RemoveBuildingForPlayer(playerid, 16619, 199.336, 1943.88, 18.2031, 250.0); 	// Buildings LOD
    RemoveBuildingForPlayer(playerid, 1697, 228.797, 1835.34, 23.2344, 250.0); 		// Solar Panels (they poke through the roof inside)
    RemoveBuildingForPlayer(playerid, 16094, 191.141, 1870.04, 21.4766, 250.0); 	// Outer Fence

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

public OnObjectMoved(objectid)
{
    // Check if the object that moved was the northern gate
	if (objectid == A51NorthernGate)
	{
	    // Check if the northern gate was closing
	    if (NorthernGateStatus == GATES_CLOSING)
	    {
	        // Set status flag for northern gates
		    NorthernGateStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for northern gates
		    NorthernGateStatus = GATES_OPEN;
	    }
	}
	// Check if the object that moved was the eastern gate
	else if (objectid == A51EasternGate)
	{
	    // Check if the eastern gate was closing
	    if (EasternGateStatus == GATES_CLOSING)
	    {
	        // Set status flag for eastern gate
		    EasternGateStatus = GATES_CLOSED;
	    }
	    else
	    {
	        // Set status flag for eastern gate
		    EasternGateStatus = GATES_OPEN;
	    }
	}

	// Exit here
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// Check if the player pressed the conversation yes key (normally the Y key)
	if (newkeys & KEY_YES)
	{
		// Check if the player is near the eastern A51 gate
	    if (IsPlayerInRangeOfPoint(playerid, 10.0, 287.12, 1821.51, 18.14))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Eastern A51 Gate", playerid);

	        // Check if the eastern gate is currently opening (ie moving)
	        if (EasternGateStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gate to fully open first.");
	            return 1;
	        }
	        // Check if the eastern gate is currently closing (ie moving)
	        else if (EasternGateStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the eastern gate to fully close first.");
	            return 1;
	        }

	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 287.12, 1821.51, 18.14);

	        // Check if the eastern gate is currently closed
	        if (EasternGateStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Gate Opening!", 3000, 3);

		        // Animate the eastern gate opening
		    	MoveObject(A51EasternGate, 286.008666, 1833.744628, 20.010623, 1.1, 0, 0, 90);

				// Set status flag for eastern gate
		    	EasternGateStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Eastern Gate Closing!", 3000, 3);

		        // Animate the eastern gates closing
		    	MoveObject(A51EasternGate, 286.008666, 1822.744628, 20.010623, 1.1, 0, 0, 90);

				// Set status flag for eastern gate
		    	EasternGateStatus = GATES_CLOSING;
	    	}
	    }
	    // Check if the player is near the northern A51 gate
	    else if (IsPlayerInRangeOfPoint(playerid, 10.0, 135.09, 1942.37, 19.82))
	    {
	        // Debug
	        //printf("-->Player ID %d within 10m of the Northern A51 Gate", playerid);

	        // Check if the northern gate is currently opening (ie moving)
	        if (NorthernGateStatus == GATES_OPENING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the northern gate to fully open first.");
	            return 1;
	        }
	        // Check if the northern gates is currently closing (ie moving)
	        else if (NorthernGateStatus == GATES_CLOSING)
	        {
	            // Send chat text message and exit here
	            SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* Sorry, you must wait for the northern gate to fully close first.");
	            return 1;
	        }

	        // Play gate opening sound
	        PlaySoundForPlayersInRange(1035, 50.0, 135.09, 1942.37, 19.82);

	        // Check if the northern gate is currently closed
	        if (NorthernGateStatus == GATES_CLOSED)
	        {
	            // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Northern Gate Opening!", 3000, 3);

		        // Animate the northern gates opening
		    	MoveObject(A51NorthernGate, 121.545074, 1941.527709, 21.691408, 1.3, 0, 0, 180);

		    	// Set status flag for northern gates
		    	NorthernGateStatus = GATES_OPENING;
	    	}
	    	else
	    	{
	    	    // Send a gametext message to the player
				GameTextForPlayer(playerid, "~b~~h~Northern Gate Closing!", 3000, 3);

		        // Animate the northern gates closing
		    	MoveObject(A51NorthernGate, 134.545074, 1941.527709, 21.691408, 1.3, 0, 0, 180);

		    	// Set status flag for northern gates
		    	NorthernGateStatus = GATES_CLOSING;
	    	}
	    }
	}

	// Exit here (return 1 so this callback is handled in other scripts too)
	return 1;
}

