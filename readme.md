DoubleClick for Fuse Tools
--------------------------

This is an implementation of the Double Click for Publishers SDK (DFP for short) for <a href="https://developers.google.com/mobile-ads-sdk/docs/dfp/android/quick-start">Android</a> and <a href="https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start">iOS</a>.

It does allows to show your own Ads served from your own DFP Account.

**Usage**

On your project, include the DFP project

```
 "Projects": [
               "dfp/dfp.unoproj"
  ],
```

And then use this code to show the banner inside the App

```
     <NativeViewHost ux:Name="Ads" RenderToTexture="True" Layer="Background">
	     <Google.DFPBanner Id="/00000000/BANNER-ID" />
     </NativeViewHost>
```

**Known issues**

If you enable Push Notifications on your app, adding the package Fuse.PushNotifications on your .unoproj file, you will get a compilation error on Android:

```
    Dex: Error converting bytecode to dex:
    Cause: com.android.dex.DexException: Multiple dex files define Lcom/google/android/gms/iid/zzc;
        UNEXPECTED TOP-LEVEL EXCEPTION:
        com.android.dex.DexException: Multiple dex files define Lcom/google/android/gms/iid/zzc;
            at com.android.dx.merge.DexMerger.readSortableTypes(DexMerger.java:596)
            at com.android.dx.merge.DexMerger.getSortedTypes(DexMerger.java:554)
            at com.android.dx.merge.DexMerger.mergeClassDefs(DexMerger.java:535)
            at com.android.dx.merge.DexMerger.mergeDexes(DexMerger.java:171)
            at com.android.dx.merge.DexMerger.merge(DexMerger.java:189)
            at com.android.dx.command.dexer.Main.mergeLibraryDexBuffers(Main.java:502)
            at com.android.dx.command.dexer.Main.runMonoDex(Main.java:334)
            at com.android.dx.command.dexer.Main.run(Main.java:277)
            at com.android.dx.command.dexer.Main.main(Main.java:245)
            at com.android.dx.command.Main.main(Main.java:106)
```
 
