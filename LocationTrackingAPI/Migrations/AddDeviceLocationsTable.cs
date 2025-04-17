using Microsoft.EntityFrameworkCore.Migrations;
namespace LocationTrackingAPI.Migrations
{
    public partial class AddDeviceLocationsTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DeviceLocations",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DeviceId = table.Column<string>(nullable: false),
                    DeviceName = table.Column<string>(nullable: false),
                    Latitude = table.Column<double>(nullable: false),
                    Longitude = table.Column<double>(nullable: false),
                    Altitude = table.Column<double>(nullable: true),
                    Speed = table.Column<double>(nullable: true),
                    Accuracy = table.Column<double>(nullable: true),
                    Timestamp = table.Column<DateTime>(nullable: false, defaultValueSql: "GETUTCDATE()"),
                    IsOnline = table.Column<bool>(nullable: false, defaultValue: true),
                    BatteryLevel = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceLocations", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DeviceLocations_DeviceId",
                table: "DeviceLocations",
                column: "DeviceId",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DeviceLocations");
        }
    }
}
