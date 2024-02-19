namespace OutdoorGearApi.Models.Entity
{
    public class Token
    {
        public Guid Id { get; set; }
        
        public Guid UserId { get; set; }
        public bool IsValid { get; set; }
    }
}
