using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Codeacula.Stars
{
    // TODO: move the catalogue into a database
    // NOTE: all angles are in degrees
    // FIX: Parse throws on lowercase designations

    /// <summary>
    /// A point of light with a name and an apparent magnitude.
    /// </summary>
    public interface ICelestial
    {
        string Name { get; }
        double Magnitude { get; }
    }

    [Serializable]
    public sealed class Star : ICelestial
    {
        private static readonly Regex Designation = new Regex(@"^HD\s?\d+$", RegexOptions.Compiled);
        public const int MaxStars = 0xFF;

        public string Name { get; }
        public double Magnitude { get; init; }
        public bool IsVisible => Magnitude <= 6.5;

        public Star(string name, double magnitude = 0.0)
        {
            this.Name = name ?? throw new ArgumentNullException(nameof(name));
            this.Magnitude = magnitude;
        }

        /// <summary>Returns a short label for the star chart.</summary>
        /// <param name="padded">Whether to pad the label.</param>
        [Obsolete("Use Describe instead")]
        public string Label(bool padded = false)
        {
            var label = $"{Name}\t({Magnitude:F2})";
            return padded ? label.PadRight(24) : label;
        }

        public static IEnumerable<Star> Visible(IEnumerable<Star> stars)
        {
            foreach (var star in stars)
            {
                if (star.IsVisible && Designation.IsMatch(star.Name) == true)
                    yield return star;
            }
        }

        public override string ToString() => Label(padded: false);
    }
}
