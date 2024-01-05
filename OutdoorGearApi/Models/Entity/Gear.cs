namespace OutdoorGearApi.Models.Entity
{
    public class Gear
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Brand { get; set; }
        public double Weight { get; set; }
        public string Type { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public string[] Tags { get; set; }

    }
}
