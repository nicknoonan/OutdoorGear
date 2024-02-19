namespace OutdoorGearApi.Models.Request
{
    public class PutUserRequest
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
    }
}
