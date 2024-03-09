# Change Log

## Version 2.0.1 - 2024-03-09  
  
### Changes in `SP_PortalActorComponent`:  
- Added 5 new helpers for working with custom Player Camera Managers  
  - Added helper functions for transforming velocity, rotation, and location based on portal transforms.  
  - Added a helper function to test if a location is closer to the target portal.  
  - Added a function to check if a portal is being tracked.  
  - Added a helper to test if the player is at the target portal  
- Added OnCreatePortalTwinCallBack binding  
  
### Changes in `SP_PortalCameraManagerComponent`:  
- Updated `TeleportCamera()` to handle cases where `CameraParent` can be null, ensuring early firing of the teleport callback for custom camera managers.  
  
### Changes in `ASP_PortalLevelStreamManager`:  
- Added `GetLevelBounds()` helper.  
  
### Changes in `SP_PortalNetPlayerComponent`:  
- Do not create texture on BeginPlay  
  
### Changes in `SP_PortalHub`:  
- Do not create texture on BeginPlay  
  
### Changes in `SP_PortalActor`:  
- added helper GetStartCapture(), A helper function to check if the portal is actively running a scene capture  
  
### Changes in `SPL_Library`:  
- Logging  
  
### Fix in `SP_PortalNetPlayerComponent`:  
- InitializeComponent: check to ensure we are in the game world  
  
### Fix in `SP_PortalHub`:  
- `ResolvePortalPairs()` and `RemovePortalActor` get reference for PortalPair  
- `RemovePortalLevelManager` clean up Portal Actors on remove  
  
## Version 2.0.0 - 2024-02-18

### Added
- Introduced `SPL_Library` namespace containing utility functions.
- Added `USP_PortalNetPlayerComponent` class with various server-side functions.
- Implemented new properties and methods in `SP_PortalHub` for portal management.
- Added functionality and members to manage level streaming in `SP_PortalLevelStreamManager`.
- Included new features and modifications in `SP_PortalActorComponent`.
- Updated `SP_PortalCameraManagerComponent` with additional utility functions.
- Enhanced `SP_PortalPlayerComponent` with server-specific logic.

### Changes
- Refactored code in `SP_PortalActor.cpp` for better network replication handling.
- Modified `SP_PortalHub.h` and `.cpp` to accommodate new render texture settings and portal management.
- Adjusted code in `SP_PortalLevelStreamManager.cpp` for improved level streaming behavior.
- Updated `SP_PortalActorComponent.cpp` for better teleportation and component management.
- Made changes in `SP_PortalCameraManagerComponent.cpp` for improved camera handling near portals.
- Enhanced `SP_PortalPlayerComponent.cpp` for more efficient portal activation and tracking.

### For more detailed changes, please refer to the full changelog provided above.
[Detailed Change Log](ChangeLogDetailed.md)

## Version 1.0.0 - 2023-06-13

Initial Release
