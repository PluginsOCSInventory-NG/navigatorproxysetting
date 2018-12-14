
 
package Apache::Ocsinventory::Plugins::Navigatorproxysetting::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{navigatorproxysetting} = {
		mask => 0,
		multi => 1,
		auto => 1,
		delOnReplace => 1,
		sortBy => 'ENABLE',
		writeDiff => 0,
		cache => 0,
		fields => {
                USER => {},
                ENABLE => {},
                ADDRESS => {},
                AUTOCONFIGURL => {},
                OVERRIDE => {}
	}
};
1;