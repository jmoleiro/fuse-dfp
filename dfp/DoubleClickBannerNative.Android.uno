using Uno;
using Uno.Time;
using Uno.Compiler.ExportTargetInterop;
using Uno.UX;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;


namespace Google.Android
{

    //[Require("Gradle.Dependency.Compile", "com.google.android.gms:play-services-ads:11.0.0")]
	//[Require("Gradle.Dependency.Compil.Excludee", "com.google.android.gms:gms-play-services-iid")]
	[Require("Gradle.Dependency","compile('com.google.android.gms:play-services-ads:11.0.0') { exclude module: 'google-android-gms-iid' }")]
	[Require("Gradle.Repository","mavenCentral()")]
    [ForeignInclude(Language.Java,
                    "com.google.android.gms.ads.doubleclick.PublisherAdRequest",
                    "com.google.android.gms.ads.doubleclick.PublisherAdView",
					"com.google.android.gms.ads.AdSize")]
	extern(Android) class DFPBannerNative : 
		Fuse.Controls.Native.Android.LeafView, IDFPBanner
	{


		IDFPBannerHost _host;
		IDisposable _valueChangedEvent;

		public event ValueChangedHandler<String> IdChanged;		

		public DFPBannerNative(IDFPBannerHost host, string _ad_id) : base(Create(_ad_id))
		{
			_host = host;
			this.IdChanged += OnIdChanged;
			//Init(Handle, OnDateChanged);
		}

		public override void Dispose()
		{
			base.Dispose();
			_host = null;
		}

		void OnIdChanged(object sender, ValueChangedArgs<string> args)
		{
			if (args.Value != null) {
				setAdUnitId(this.Handle, args.Value);
			}
		}		

		[Foreign(Language.Java)]
		static Java.Object Create(string _ad_id)
		@{
			
			PublisherAdView mAdView = new PublisherAdView(@(Activity.Package).@(Activity.Name).GetRootActivity());
            mAdView.setAdSizes(AdSize.SMART_BANNER);
            mAdView.setAdUnitId(_ad_id);
            
            //PublisherAdRequest publisherAdRequestBuilder = new PublisherAdRequest.Builder();
            //mAdView.loadAd(PublisherAdRequestBuilder.build());
			mAdView.loadAd(new PublisherAdRequest.Builder().build());
            return  mAdView;			
			//return new android.widget.DatePicker(@(Activity.Package).@(Activity.Name).GetRootActivity());
		@}


		/*
		[Foreign(Language.Java)]
        void AddChangedCallback(Java.Object Handle, Action<float> onValueChanged)
        @{
			PublisherAdView mAdView = (PublisherAdView)Handle;

             ((android.widget.SeekBar)Handle).setOnSeekBarChangeListener(new android.widget.SeekBar.OnSeekBarChangeListener() {
                public void onProgressChanged(android.widget.SeekBar seekBar, int progress, boolean fromUser) {
                    onValueChanged.run((float)progress);
                }
                public void onStartTrackingTouch(android.widget.SeekBar seekBar) { }
                public void onStopTrackingTouch(android.widget.SeekBar seekBar) { }
            }); 
        @}
		*/		

		/*
		[Foreign(Language.Java)]
		void Init(Java.Object Handle, Action<int,int,int> onDateChangedCallback)
		@{
			PublisherAdView mAdView = (PublisherAdView)Handle;
		@} */

		[Foreign(Language.Java)]
		public void setAdUnitId(Java.Object Handle, string _new_ad_id) 
		@{			
			PublisherAdView mAdView = (PublisherAdView)Handle;
			mAdView.setAdUnitId(_new_ad_id);
			//mAdView.loadAd(PublisherAdRequestBuilder.build());
			mAdView.loadAd(new PublisherAdRequest.Builder().build());
		@}
		
	}
}