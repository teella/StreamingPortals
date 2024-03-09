### [2.0.1] - 2024-03-08  
### Changes in `SP_PortalActorComponent`:  
- Added 4 new helpers for working with custom Player Camera Managers  
  - Added helper functions for transforming velocity, rotation, and location based on portal transforms.  
  - Added a helper function to test if a location is closer to the target portal.  
  - Added a function to check if a portal is being tracked.  
- Added OnCreatePortalTwinCallBack binding  
  
### Changes in `SP_PortalCameraManagerComponent`:  
- Updated `TeleportCamera()` to handle cases where `CameraParent` can be null, ensuring early firing of the teleport callback for custom camera managers.  
  
### Changes in `SP_PortalActor`:  
- added helper GetStartCapture(), A helper function to check if the portal is actively running a scene capture  
  
### Fix in `SP_PortalNetPlayerComponent`:  
- InitializeComponent: check to ensure we are in the game world  
  
### Fix in `SP_PortalHub`:  
- `ResolvePortalPairs()` get reference for PortalPair  
  
### [2.0.0] - 2024-02-18

### Added SPL_Library:

- Added a namespace StreamingPortalHelper containing a class SPL_Library.
- Declared the class SPL_Library with the following public static functions:
  - GetNetPlayerComponent: Retrieves the USP_PortalNetPlayerComponent associated with the player character.
  - GetViewPortResolution: Retrieves the resolution of the viewport.
  - IsLocalOwned: Checks if a specified actor is locally owned.
  - CreateRenderTexture: Returns a render texture based on Portal Hub RT settings for portals needing their own render texture.


### Added USP_PortalNetPlayerComponent:

- Added `USP_PortalNetPlayerComponent` class definition.
- Added `SetServerClientMovement` function to toggle client movement settings for smooth illusion.
- Added `ActivatePortal` function to activate portals on the server.
- Added `SetServerInPortal` function to set portal state on the server.
- Added `SetLevelBounds` function to set level bounds on the server.
- Added `GetInPortal` function to retrieve portal state.
- Added `GetViewPortResolution` function to get viewport resolution.
- Added `SetServerNetRelevance` function to toggle relevance settings when interacting with portals.
- Added `CreateRenderTexture` function as a utility to create render textures.
- Added `ServerLoadLevel` function to load levels on the server.
- Added `SetServerShouldBeLoaded` function to update ShouldBeLoaded status on the server.
- Added `M_ActivatePortal` multicast function to activate portals on all clients.
- Added `M_SetServerInPortal` multicast function to set portal state on all clients.
- Defined member variables and functions to manage portal interactions and synchronization.


### Changes in `SP_PortalActor.cpp`:

- Added inclusion of `"Components/SP_PortalNetPlayerComponent.h"` at line 6.
- Added inclusion of `"Engine/LocalPlayer.h"` at line 12.
- Added inclusion of `"SceneView.h"` at line 13.
- Added inclusion of `"Library/SPL_Library.h"` at line 14.
- Added a new static function namespace `SPL_PortalActor` at line 18.
- Added initialization of `bReplicates`, `bAlwaysRelevant`, and `NetCullDistanceSquared` at lines 35-37.
- Changed `SP_DefaultLumenSettings()` to `SPL_PortalActor::SP_DefaultLumenSettings()` at line 181.
- Changed `SP_SetupStaticMeshComponent()` to `SPL_PortalActor::SP_SetupStaticMeshComponent()` at lines 150 and 157.
- Changed `SP_LoadPortalStaticMeshComponent()` to `SPL_PortalActor::SP_LoadPortalStaticMeshComponent()` at lines 199, 203, and 207.
- Added check for `GetNetMode()` in `InitializeActor()` method at lines 232-235.
- Added check for `GetNetMode()` in `BeginPlay()` method at lines 397-401.
- Added check for `GetNetMode()` in `Tick()` method at lines 442, 459, and 666.
- Added check for `GetNetMode()` in `EndPlay()` method at lines 424-437.
- Added a new console variable `CVarSLP_UseLocalProjectionData` at line 23.
- Modified the logic in various methods to handle network replication correctly based on the current network mode.

### Changes in `SP_PortalHub.h`:

- Added new property `DynamiclySetNetRelevance` with default value `true` at line 65.
- Added new property `AlwaysNetRelevant` with default value `false` at line 69.
- Added new property `bUseOverrideRenderTextureResolution` with default value `false` at line 73.
- Added new property `OverrideRenderTextureResolution` with default value `(1680, 1050)` at line 77.
- Modified the `CreateRenderTexture` method to be a non-static member function with the same signature as before at line 81.
- Added `UObject* WorldContextObject` parameter to the `CreateRenderTexture` method at line 82.
- Renamed `RenderTextureQuality` to `InRenderTextureQuality`, `RenderTextureFormat` to `InRenderTextureFormat`, and `RenderTextureScale` to `OutRenderTextureScale` in the `CreateRenderTexture` method signature at line 82.
- Removed the `static` specifier from the `CreateRenderTexture` method declaration at line 82.
- Added `friend class USP_PortalNetPlayerComponent;` declaration at line 184.

### Changes in `SP_PortalHub.cpp`:

- Added inclusion of `"Components/SP_PortalNetPlayerComponent.h"` at line 7.
- Added inclusion of `"Library/SPL_Library.h"` at line 10.
- Added initialization of `bReplicates`, `bAlwaysRelevant`, and `NetCullDistanceSquared` at lines 70-72.
- Removed the namespace `namespace` and its content.
- Changed the `CreateOrGetPortalHub` method to use `SPL_PortalHub::GlobalPortalHub` instead of `GlobalPortalHub` at lines 34-36, 44, and 48.
- Changed the `CreateOrGetPortalHub` method to use `World` instead of `WorldContextObject` directly at lines 37-38.
- Changed the `CreateOrGetPortalHub` method to use `World->PersistentLevel->GetWorld()` instead of `WorldContextObject->GetWorld()->PersistentLevel->GetWorld()` at line 45.
- Changed the `CreateRenderTexture` method to use `StreamingPortalHelper::SPL_Library::CreateRenderTexture` instead of its own implementation at line 97.
- Changed the `CreateRenderTextureQuick` method to return `nullptr` if the network mode is not client or standalone at lines 143-145.
- Changed the `GetRenderTexture` method to return `nullptr` if the network mode is not client or standalone at lines 155-157.
- Modified the `BeginPlay` method to initialize `bReplicates`, `bAlwaysRelevant`, and `NetCullDistanceSquared` and check for network mode at lines 191-194.
- Modified the `EndPlay` method to use `SPL_PortalHub::GlobalPortalHub` instead of `GlobalPortalHub` at line 225.
- Modified the `ResolvePortalPairs` method to use `UEnum::GetValueAsString(TEXT("Engine.ENetRole"), GetLocalRole())` instead of a hardcoded string at line 283.
- Modified the `RemovePortalActor` method to use `IsValid()` instead of `!IsNull()` at lines 349-351.
- Modified the `RemovePortalActor` method to properly handle `TargetPortal` and `SetActorTickEnabled` at lines 362-372.


### Changes in `SP_PortalLevelStreamManager.h`:

- Added `NetPlayerCompList` member variable at line 87.
- Added `friend class USP_PortalNetPlayerComponent;` declaration at line 90.
- Added `ServerLoadLevel` method declaration at line 123.
- Added `OnServerLevelLoaded` method declaration at line 130.
- Added `ServerCanUnload` method declaration at line 137.
- Added `CreateStreamingLevel` method declaration at line 140.

### Changes in `SP_PortalLevelStreamManager.cpp`:

- Added include for `"Components/SP_PortalNetPlayerComponent.h"` at line 5.
- Added `USP_PortalNetPlayerComponent` include at line 6.
- Added `Engine/Engine.h` include at line 10.
- Added `#include "Library/SPL_Library.h"` at line 11.
- Initialized `bReplicates`, `bAlwaysRelevant`, and `NetCullDistanceSquared` in the constructor at lines 18-20.
- Modified `BeginPlay` method to include loading logic for clients and standalone instances at lines 40-68.
- Added `ServerCanUnload` method at lines 70-103.
- Added logic to skip execution on the server at line 105.
- Modified `Tick` method to handle network modes at lines 105-128.
- Modified `CheckShowLevel` method to handle network modes at lines 131-224.
- Added `ServerLoadLevel` method at lines 226-243.
- Added `CreateStreamingLevel` method at lines 257-340.
- Modified `LoadLevel` method to include server-side loading logic at lines 342-381.
- Modified `InitStreamingLevel` method to include server-side initialization logic at lines 393-419.
- Added `OnServerLevelLoaded` method at lines 421-446.



### Changes in `SP_PortalActorComponent.cpp`:

- Added `#include "Components/SP_PortalNetPlayerComponent.h"` at line 7.
- Added `#include "Library/SPL_Library.h"` at line 8.
- Set `SetIsReplicatedByDefault(false);` at line 29.
- Modified the initialization of `PortalHub` at line 68 to `PortalHub = ASP_PortalHub::CreateOrGetPortalHub(this);`.
- Added a check to ensure the component tags of `PortalTwin` include `FName(TEXT("PortalTwin"))` at line 76.
- Added a condition to hide `PortalTwin` on remote machines at lines 95-100.
- Added `NewLoc` variable declaration at line 198.
- Modified the teleportation logic at lines 219-237 to handle player characters and their network components.


### Changes in `SP_PortalCameraManagerComponent.h`:

- Added forward declaration of `UCameraComponent` at line 14.
- Added `USP_PortalActorComponent` as a friend class at line 137.
- Removed the redundant comment line at line 224.
- Removed the empty line at line 226.

### Changes in `SP_PortalCameraManagerComponent.cpp`:

- Added namespace `SPL_PortalCameraManagerComponent` containing utility functions `SP_FindCameraComponent` and `SP_FindCamera`.
- Set `SetIsReplicatedByDefault(false);` at line 25.
- Moved the `SP_FindCameraComponent` and `SP_FindCamera` functions into the `SPL_PortalCameraManagerComponent` namespace.
- Modified the `ActivatePortal` function at lines 302-321 to use the `SP_FindCamera` function from the new namespace.
- Added a check to ensure that the camera and `PortalTwin` are not behind the portal at lines 359-375. If they are, a message is logged, indicating that the camera teleport is starting.


### Changes in `SP_PortalPlayerComponent.cpp`:

- Added include directive for `"Components/SP_PortalNetPlayerComponent.h"` at line 2.
- Set `SetIsReplicatedByDefault(false);` at line 34.
- Added a check to skip initialization if the net mode is not client or standalone at lines 40-49.
- Modified the `EndPlay` function at lines 71-87 to perform cleanup only if the net mode is client or standalone.
- Added a check to skip custom tick processing if the net mode is not client or standalone at lines 98-103.
- Modified the `ActivatePortal` function at lines 133-240 to ensure that the activation logic is only executed for locally owned characters.
- Added a check to skip portal tracking if the net mode is not client or standalone at lines 249-251 and 255-257.
- Modified the `TrackPortal` function at lines 319-393 to ensure that the tracking logic is only executed for locally owned characters.


### [1.0.0] - 2023-06-13

Initial Release