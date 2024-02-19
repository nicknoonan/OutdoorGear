using Microsoft.EntityFrameworkCore;
using OutdoorGearApi.Models.Entity;

namespace OutdoorGearApi.Models
{
    public class GearDbContext : DbContext
    {
        public DbSet<Gear> Gear {  get; set; }

        public DbSet<User> GearUsers { get; set; }

        public DbSet<Token> Tokens { get; set; }
        public GearDbContext(DbContextOptions<GearDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<User>(entity => {
                entity.HasIndex(e => e.Email).IsUnique();
            });
        }
    }
}
