using Microsoft.EntityFrameworkCore;
using OutdoorGearApi.Models.Entity;

namespace OutdoorGearApi.Models
{
    public class GearDbContext : DbContext
    {
        public DbSet<Gear> Gear {  get; set; }
        public GearDbContext(DbContextOptions<GearDbContext> options) : base(options) { }
    }
}
