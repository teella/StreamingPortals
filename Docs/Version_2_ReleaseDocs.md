# Version 2 Release Documentation

#### 1 - Override Render Texture Resolution Settings.  
#### 2 - Added Shack Example to the demonstration level.
#### 3 - Fix for Example Project IntelXeSS in blueprint
#### 4 - Networked Streaming Level Portals is now supported.
----

### 1 - Override Render Texture Resolution Settings.

PortalHub settings configured to override resolution settings for render textures. This adjustment is typically required only in cases where the automatic resolution check fails to function correctly.  
![](/Images/SP_PortalHubTextureSettings.jpg?raw=true)  

----
### 2 - Added Shack Example to the demonstration level.

The Shack Example is a unique structure designed to appear small from the outside but spacious within. It seamlessly integrates into the existing level without loading a skysphere. Notably, it features a functional window allowing both interior and exterior views.  
  
It's important to observe that the window portals are configured with the 'Use Own Render Texture' option enabled. This ensures smooth functionality, allowing both the door and windows to remain active simultaneously. Additionally, the interior render distance is set to 3000, facilitating clear views through the door or window from any position within the shack!  
![](/Images/ShackImage.jpg?raw=true)

----
### 3 - Fix for Example Project

 Disconnected the pin to the Intel XeSS Quality Mode Info. If you add the XeSS plugin to your project, simplly hook this back up in BP_ThirdPersonGameMode.  
 ![](/Images/IntelXeSSFix.jpg?raw=true)  
  
----
### 4- Networked Streaming Level Portals is now supported.

Quick Start:  
  
Just add a couple of portals and include the SL_PortalNetPlayerComponent in your main player character blueprint or class make sure Actor Replicates is true. That's all you need!  
  
See Image Below  

![](/Images/SP_PortalNetPlayerComponent.jpg?raw=true)

### How it all works

Streaming Portal Levels adopts a methodology similar to that of 'Level Streaming Volumes' utilized in Unreal Engine, as documented [here](https://docs.unrealengine.com/5.3/en-US/level-streaming-volumes-reference-in-unreal-engine/).

However, unlike level streaming volumes, there's no need to enable 'UseClientSideLevelStreamingVolumes' in your world settings when using Streaming Portal Levels. This feature operates independently of server-side loading. In this system, the server maintains all streaming levels continuously loaded, while clients autonomously manage level streaming based on defined volumes.

In C++, the property 'bUseClientSideLevelStreamingVolumes' is not applicable to Streaming Portal Levels and does not need to be configured in your level's world settings.

Furthermore, all Streaming Portal Actors (such as SP_PortalActor, SP_PortalHub, ASP_PortalLevelStreamManager) have their 'Replicates' set to false and 'OnlyRelevantToOwner' properties set to true, and all components (like SP_PortalActorComponent, SP_PortalCameraManagerComponent, SP_PortalPlayerComponent) are configured not to replicate. This setup is crucial as the entire illusion is handled client-side. In order to keep systems in sync a SP_PortalNetPlayerComponent was added and is the sole component set to replicate, managing network communication for the SPL system and ensuring synchronization among simulation proxies.

## Notes about Actors

Understanding how Actors behave in various network settings is crucial. One notable aspect is that when a level is "Hidden," the EndPlay function is triggered for all Actors, regardless of their network settings.

However, the behavior differs for BeginPlay. If your Actor is set to Replicate, it's important to note that BeginPlay executes only once when it is initially loaded as part of a streaming level. This is because the server, being the authority, has already executed BeginPlay. Consequently, when the level is hidden and shown again, BeginPlay will not execute upon being shown, necessitating the replication of any necessary states from the server to your remote actors.

Conversely, if your Actor is set to Not Replicate and is configured as 'OnlyRelevantToOwner,' BeginPlay will execute each time the level is shown, but only on the remote system, as the owner is the remote system.

## Network settings added to Portal Hub

1. **Dynamically Set Net Relevance:**
   - This feature toggles 'bAlwaysRelevant' and 'NetCullDistanceSquared' when interacting with a portal.
   - It ensures that other players can see you on either side of the portal.
   - Once out of range of the portal (reaching 'Max Capture Update Distance'), these settings revert.

2. **Always Net Relevant:**
   - This setting configures 'bAlwaysRelevant' and 'NetCullDistanceSquared' to zero.

3. **Experimental Unload Level on Server:**
   - This functionality attempts to load and unload streaming levels on the server when they are no longer in use.
   - In Unreal Engine 5.2, a warning may appear in the console, but this seems to be an editor-only issue and can be safely ignored. This issue does not occur in version 5.3.

   Notably, in Unreal Engine 5.3, when a Level is 'Hidden' in the editor, it disappears from the SceneGraph. However, in version 5.2, a hidden Level remains visible in the SceneGraph, retaining the World Settings of the streamed level.

![](/Images/SP_PortalHubNetworkSettings.jpg?raw=true)
