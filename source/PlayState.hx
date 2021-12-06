package;

import flixel.FlxState;
import networking.Network;
import networking.sessions.Session;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;

class PlayState extends FlxState
{
	var client:Session;
	var playerID:Int;

	override public function create()
	{
		// Creates the client
		client = Network.registerSession(NetworkMode.CLIENT, {ip: '127.0.0.1', port: 8888, flash_policy_file_url: "http://127.0.0.1:9999/crossdomain.xml"});
		// Event that starts when server sends a message
		client.addEventListener(NetworkEvent.CONNECTED, function(event:NetworkEvent)
		{
			trace("Welcome to the server!");
			client.send({case1: "player_joined"});
		});
		client.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(event:NetworkEvent)
		{
			trace("Client received a message");
			// If case is new player, add a player
			switch (event.data.case1)
			{
				case "new_player":
					trace("Message: new player");
					playerID = event.data.playerID;
					trace("Player ID: " + playerID);
			}
		});
		client.start();
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
