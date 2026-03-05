/*
 * StatementNodeJsonConverter
 *
 * Custom converter for StatementNode that handles polymorphic serialization.
 * Both Write and Read delegate to AstNode-level serialization so that the
 * $type polymorphic discriminator is written and read, preserving the concrete
 * subtype (PerformStatement, IfStatement, etc.) across JSON round-trips.
 */

using System.Text.Json;
using System.Text.Json.Serialization;
using ConvertCobol.Models;

namespace ConvertCobol.Converters;

public class StatementNodeJsonConverter : JsonConverter<StatementNode>
{
    public override StatementNode? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // Remove this converter from options to avoid recursive deserialization
        var opts = new JsonSerializerOptions(options);
        for (var i = opts.Converters.Count - 1; i >= 0; i--)
        {
            if (opts.Converters[i] is StatementNodeJsonConverter)
                opts.Converters.RemoveAt(i);
        }
        // Deserialize as AstNode to leverage [JsonPolymorphic] discriminator ($type),
        // then cast to StatementNode. This ensures typed subtypes are restored.
        return JsonSerializer.Deserialize<AstNode>(ref reader, opts) as StatementNode;
    }

    public override void Write(Utf8JsonWriter writer, StatementNode value, JsonSerializerOptions options)
    {
        // Remove this converter from options to avoid recursive serialization.
        // Serialize as AstNode to include the $type polymorphic discriminator,
        // which allows Read() to restore the correct subtype.
        var opts = new JsonSerializerOptions(options);
        for (var i = opts.Converters.Count - 1; i >= 0; i--)
        {
            if (opts.Converters[i] is StatementNodeJsonConverter)
                opts.Converters.RemoveAt(i);
        }
        JsonSerializer.Serialize<AstNode>(writer, value, opts);
    }
}
