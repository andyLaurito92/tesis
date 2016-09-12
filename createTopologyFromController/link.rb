class Link
	def self.uri_resource
		'http://127.0.0.1:8181/onos/v1/links/'
	end

	def self.key_name_in_response
		'links'
	end

	def self.quantity_of_links
		@@quantity ||= 0
		@@quantity += 1
	end

=begin
links is an array of elements of this kind
{
	"src"=>{
		"port"=>"2", 
		"device"=>"of:0000000000000001"
	}, 
	"dst"=>{
		"port"=>"3", 
		"device"=>"of:0000000000000005"
	}, 
	"type"=>"DIRECT", 
	"state"=>"ACTIVE"
}
=end
	def initialize(json)
		@json_representation=json
	end

	def transform_to_pdm_representation
		"Coupled
	            {
	            Type = Coordinator
	            Name = Link#{Link.quantity_of_links}
	            Ports = 1; 1
	            Description = Coupled DEVS model
	            Graphic
	                {
	                Position = #{-9990 + 645 * (Link.quantity_of_links - 1)}; -9870
	                Dimension = 645; 705
	                Direction = Down
	                Color = 15
	                Icon = %datanetworks%ethernet.jpg
	                Window = 5000; 5000; 5000; 5000
	                }
	            Parameters
	                {
	                }
	            System
	                {
	                Inport
	                    {
	                    Name = Inport0
	                    CoupledPort = 1
	                    Description = 
	                    Graphic
	                        {
	                        Position = -4740 ; -3525
	                        Dimension = 480
	                        Direction = Right
	                        }
	                    }
	                Outport
	                    {
	                    Name = Outport0
	                    CoupledPort = 1
	                    Description = 
	                    Graphic
	                        {
	                        Position = -930 ; 2850
	                        Dimension = 360
	                        Direction = Right
	                        }
	                    }
	                Atomic
	                    {
	                    Name = InNICQueue
	                    Ports = 2 ; 2
	                    Path = PhaseI/NetworkQueue.h
	                    Description = In0 Incomming packets to queueIn1 Incoming signal to request dequeueOut0 Outgoing dequeued packetsOut1 Outgoing queue lenght informationQueues incoming packets and enqueues them as required by aexternal entity. FIFO Policy (FirstInFirstOut). Provides information its internal state.
	                    Graphic
	                        {
	                        Position = -3855 ; -1230
	                        Dimension = 675 ; 675
	                        Direction = Down
	                        Color = 15
	                        Icon = %datanetworks%queue.png
	                        }
	                    Parameters
	                        {
	                        MaxCapacity = Str; FelixNICQueue1.maxBuffer ; Queue Capacity in Bytes. (Use -1 for INF capacity)
	                        ForcedPeriod = Str; -1 ; Force minimum period to transition. Use -1 for INF
	                        }
	                    }
	                Atomic
	                    {
	                    Name = Link
	                    Ports = 1 ; 1
	                    Path = PhaseI/Link.h
	                    Description = Vector to scalar signal
	                    Graphic
	                        {
	                        Position = -3990 ; 585
	                        Dimension = 630 ; 630
	                        Direction = Down
	                        Color = 15
	                        Icon = %vectors%vec2scalar.svg
	                        }
	                    Parameters
	                        {
	                        link.capacity = Str; FelixLink.capacity ; Signal Index
	                        link.delay = Str; link.delay ; 
	                        }
	                    }
	                Point
	                    {
	                    ConectedLines = 3 ; 4 ; 5
	                    ConectedExtrems = Org ; Org ; Org
	                    Position = -3675 ; 1950
	                    }
	                Line
	                    {
	                    Source = Prt ;  1 ;  1 ; 0
	                    Sink = Cmp ;  1 ;  1 ; -1
	                    PointX = -4125 ; -3675 ; -3675
	                    PointY = -3525 ; -3525 ; -1365
	                    }
	                Line
	                    {
	                    Source = Cmp ;  1 ;  1 ; 0
	                    Sink = Cmp ;  2 ;  1 ; -1
	                    PointX = -3675 ; -3675 ; -3675
	                    PointY = -450 ; -450 ; 435
	                    }
	                Line
	                    {
	                    Source = Cmp ;  2 ;  1 ; 0
	                    Sink = Pnt ;  1 ; -1 ; 0
	                    PointX = -3675 ; -3675 ; -3675
	                    PointY = 1350 ; 1350 ; 1950
	                    }
	                Line
	                    {
	                    Source = Cmp ;  1 ;  2 ; -1
	                    Sink = Pnt ;  1 ; -1 ; 0
	                    PointX = -3375 ; -3375 ; -2325 ; -2325 ; -3675
	                    PointY = -1365 ; -1650 ; -1650 ; 1950 ; 1950
	                    }
	                Line
	                    {
	                    Source = Pnt ;  1 ; -1 ; 0
	                    Sink = Prt ;  2 ;  1 ; -1
	                    PointX = -3675 ; -3675 ; -1065 ; -1065
	                    PointY = 1950 ; 2775 ; 2775 ; 2850
	                    }
	                }
	            }
				"
	end
end