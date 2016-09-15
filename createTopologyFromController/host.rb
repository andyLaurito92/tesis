"An ONOS representation of a host"
class Host < NetworkElement
	
	def self.quantity
		@@quantity	
	end

	def self.increase_quantity_in_one
		@@quantity ||= 0
		@@quantity += 1
	end

=begin
This is the info that represents a host. 
{
  "id": "46:E4:3C:A4:17:C8/-1",
  "mac": "46:E4:3C:A4:17:C8",
  "vlan": "-1",
  "ipAddresses": [
    "127.0.0.1"
  ],
  "location": {
    "elementId": "of:0000000000000002",
    "port": "3"
  }
}
=end
	def transform_to_pdm_representation
		"Atomic 
				{
		        Name = FelixServer#{@my_number}
		        Ports = 0 ; 1
		        Path = PhaseI/FelixServer.h
		        Description = Generates jobs. Distribution for the rate and jobSize are retrieved from the Flows assigned to this server
		        Graphic
		            {
		            Position = #{-9975 + 750 * (@my_number - 1)} ; -10285
		            Dimension = 450 ; 435
		            Direction = Right
		            Color = 15
		            Icon = %datanetworks%generator.png
		            }
		        Parameters
		            {
		            }
		        }
		        "
	end
end