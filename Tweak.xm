#import <SpringBoard/SpringBoard.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

%hook AVAudioSession

-(id) init 
{
	NSString* bundleId = [[NSBundle mainBundle] bundleIdentifier];
	NSLog(@"IRGENDWAS: constructor by bundleid: %@", bundleId);
	
	self = %orig;
	if(self) 
	{
		NSError* myerr = nil;
		// this.setMode(mode, error);
		[self setMode:AVAudioSessionModeSpokenAudio error:&myerr];
	}
	return self;
}

-(BOOL)setMode:(id)arg1 error:(id*)arg2
{
	// if app is blacklisted
	NSString* bundleId = [[NSBundle mainBundle] bundleIdentifier];
	NSLog(@"IRGENDWAS: setMode: %@ by bundleid: %@", arg1, bundleId);
	// else
	// %orig(arg1,arg2);
	return %orig(AVAudioSessionModeSpokenAudio,arg2);
}

%end

%hook UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	NSLog(@"IRGENDWAS: didfinishlaunching: %@", application);
	return %orig;
}

%end

%hook SpringBoard
	-(void) thisMethodDoesNotExistInHeaders:(id)arg {
		%orig(arg);
	}
%end

%hook SBApplication
   - (void)didLaunch:(id)arg1 {
		NSLog(@"IRGENDWAS: didLaunch: %@", arg1);
        %orig;
    }
    
	-(void) applicationDidFinishLaunching:(id)arg {
		%orig(arg);
		UIAlertView *lookWhatWorks = [[UIAlertView alloc] initWithTitle:@"simject Example Tweak"
			message:@"It works! (ﾉ´ヮ´)ﾉ*:･ﾟ✧"
			delegate:self
			cancelButtonTitle:@"OK"
			otherButtonTitles:nil];
		[lookWhatWorks show];
	}
%end

%ctor {

	NSLog(@"IRGENDWAS %@",@"TWEAK loaded.");

}
