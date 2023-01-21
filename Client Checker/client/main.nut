function Script::ScriptLoad() {
	local data = Stream();
	data.WriteInt(0);
	data.WriteString("");
	Server.SendData(data);
}