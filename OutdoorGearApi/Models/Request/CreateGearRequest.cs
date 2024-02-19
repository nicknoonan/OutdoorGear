using OutdoorGearApi.Models.Entity;

namespace OutdoorGearApi.Models.Request
{
    public class CreateGearRequest
    {
        public string Name { get; set; }
        public string Brand { get; set; }
        public double Weight { get; set; }
        public string Type { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public string[] Tags { get; set; }

        public Gear toGear()
        {
            return new Gear
            {
                Id = Guid.NewGuid(),
                Name = this.Name,
                Brand = this.Brand,
                Weight = this.Weight,
                Type = this.Type,
                Category = this.Category,
                Description = this.Description,
                Tags = this.Tags
            };
        }
    }
}
