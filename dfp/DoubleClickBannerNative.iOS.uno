using Uno;
using Uno.Time;
using Uno.Compiler.ExportTargetInterop;
using Uno.UX;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;

namespace Google.iOS
{
	[Require("Source.Include", "UIKit/UIKit.h")]
	//import GoogleMobileAds;
	[Require("Source.Include", "GoogleMobileAds/DFPBannerView.h")]	
	[Require("Source.Include", "GoogleMobileAds/DFPRequest.h")]		
	//[Require("Source.Include", "@{DFPBannerView:Include}")]
	extern(iOS) class DFPBannerNative : 
		Fuse.Controls.Native.iOS.LeafView, IDFPBanner 
	{


		IDFPBannerHost _host;
		//IDisposable IdChanged;
		/*ObjC.ID dfp;
		ObjC.ID _delegate;
		iOS.UIKit.UIView _view;*/

		public event ValueChangedHandler<String> IdChanged;		

		public DFPBannerNative(IDFPBannerHost host, string _ad_id) : base(Create(_ad_id))
		{
			_host = host;
			this.IdChanged += OnIdChanged;
			//setAdUnitId(this.Handle, _ad_id);
			//debug_log "Holis";
			//debug_log this.Id;
			//_valueChangedEvent = UIControlEvent.AddValueChangedCallback(Handle, OnIdChanged);
		}

		public override void Dispose()
		{
			base.Dispose();
			//_valueChangedEvent.Dispose();
			//_valueChangedEvent = null;
			_host = null;
		}

		void OnIdChanged(object sender, ValueChangedArgs<string> args)
		{
			debug_log "ChChChChaangeddd";
			if (args.Value != null) {
				debug_log args.Value;
				setAdUnitId(this.Handle, args.Value);
			}
		}		

		[Foreign(Language.ObjC)]
		static ObjC.Object Create(string _ad_id)
		@{
			DFPBannerView *dfp = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
			//dfp.frame.size.height = dfp.rootViewController.view.size.height;
			//dfp.frame.size.width = dfp.rootViewController.view.size.width;
			dfp.adUnitID = _ad_id;
			//dfp.adSize = kGADAdSizeSmartBannerPortrait;
			dfp.center = CGPointMake(0, 0);
			dfp.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;


			[dfp.rootViewController.view addSubview:dfp];

			/*dfp.translatesAutoresizingMaskIntoConstraints = NO;
    		[dfp.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:dfp
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:dfp.rootViewController.view

                                                          attribute:NSLayoutAttributeBottom
                                                          multiplier:1
                                                          constant:0
			]];
   
    		[dfp.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:dfp
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:dfp.rootViewController.view

                                                          attribute:NSLayoutAttributeCenterX
                                                          multiplier:1
                                                          constant:0
			]];

    		[dfp.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:dfp
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                          constant:320]];

    		[dfp.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:dfp
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                          constant:50]];
			*/

			[dfp loadRequest:[DFPRequest request]];		
			return dfp;
		@}
		
		[Foreign(Language.ObjC)]
		public void setAdUnitId (ObjC.Object handle, string _ad_id)
		@{			
			DFPBannerView *dfp = (DFPBannerView*)handle;
			dfp.adUnitID = _ad_id;
			dfp.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
			[dfp loadRequest:[DFPRequest request]];		
		@}

	}
}