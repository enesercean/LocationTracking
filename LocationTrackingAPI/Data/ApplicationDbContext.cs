using LocationTrackingAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace LocationTrackingAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<DeviceLocation> DeviceLocations { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<DeviceLocation>()
                .HasIndex(d => d.DeviceId)
                .IsUnique();

        }
    }
}
