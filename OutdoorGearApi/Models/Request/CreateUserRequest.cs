namespace OutdoorGearApi.Models.Request
{
    public class CreateUserRequest
    {
        public string Email { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
    }
}
