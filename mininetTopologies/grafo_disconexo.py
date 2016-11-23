from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        host1 = self.addHost( 'h1' )
        host2 = self.addHost( 'h2' )
        switch1 = self.addSwitch( 's1' )
        switch2 = self.addSwitch( 's2' )

	host3 = self.addHost( 'h3' )
	host4 = self.addHost( 'h4' )
	switch3 = self.addSwitch( 's3' )

        # Add links
        self.addLink( host1, switch1 )
        self.addLink( switch1, switch2 )
        self.addLink( switch2, host2 )
	
	self.addLink( host3, switch3 )
	self.addLink( switch3, host4 )

topos = { 'mytopo': ( lambda: MyTopo() ) }

