namespace OutdoorGearApi.Models.Entity
{
    public class User
    {
        public Guid Id { get; set; }
        
        public string Email { get; set; }
        public string Name { get; set; }
        public string HMACSHA256 { get; set; }
    }
}
