
/**
 *  Clase para manejo de notas musicales
 *
 *  @author JSorella on 20/04/2015.
 *  @link http://www.musicdsp.org/showone.php?id=125
 *
 *  TODO: Renombrar los nombres de algunas variables poco expresivas
 */
public class MusicalNote
{
    // MIDI NOTE/FREQUENCY CONVERSIONS
    String[] notes =
            new String[]{"C ","C#","D ","D#","E ","F ","F#","G ","G#","A ","A#","B "};
    int base_a4 = 440; // set A4=440Hz


    /**
     * Converts from MIDI note number to frequency
     *  Example: noteToFrequency(12)=32.703
     *
     *  @param n Número de la nota
     *
     *  @return double Frecuencia en Hz
     */
    public double noteToFrequency(int n)
    {
        if ((n >= 0) && (n <= 119)) {
            return base_a4 * Math.pow(2, (n - 57) / 12);
        }
        else{
            return -1;
        }
    }

    /**
     * Converts from MIDI note number to string
     *  Example: noteToName(12)='C 1'
     *
     *  @param noteNumber Número de la nota
     *
     *  @return string
     */
    public String noteToName(int noteNumber)
    {
        if ((noteNumber >= 0) && (noteNumber <= 119)) {
            return (notes[noteNumber % 12] + Integer.toString(noteNumber / 12));
        }
        else{
            return "---";
        }
    }

    /**
     * Converts from frequency to closest MIDI note
     *  Example: frequencyToNote(443)=57 (A 4)
     *
     *  @param frequency Frecuencia en Hz
     *
     *  @return int Número de la nota
     */
    public int frequencyToNote(double frequency)
    {
        return (int) Math.round(12 * log2(frequency / (double)(base_a4)))+57;
    }

    /**
     * Convierte una frecuencia a nombre de la nota junto a su octava
     *  Example: frequencyToName(443)="A 4"
     *
     *  @param frequency Frecuencia en Hz
     *
     *  @return string
     */
    public String frequencyToName(double frequency)
    {
        return this.noteToName(this.frequencyToNote(frequency));
    }

    /**
     * Converts converts from string to MIDI note
     *  Example: nameToNote('A4')=57
     *
     *  @param  name
     *
     *  @return int Número de la nota
     */
    public int nameToNote(String name)
    {
        int noteNumber, octaveNumber, i;

        //El formato tiene que quedar, por ej, A 4 o A#4
        if (name.length() == 2) {
            name = name.charAt(0) + " " +  name.charAt(1);
        }
        if (name.length() !=3)  {
            return -1; //código de error (mejorar)
        }

        name = name.toUpperCase();
        noteNumber = -1;
        for (i=0 ; i<12; i++){
            //Excluyo el número de la octava
            if (notes[i] == name.substring(0,3)) {
                noteNumber = i;
            }
        }
        octaveNumber = Character.getNumericValue(name.charAt(2));

        return octaveNumber * 12 + noteNumber;
    }

    /**
     * Helper para calcular el logaritmo base 2 de un número
     *
     *  @param n
     *
     *  @return double
     */
    public static double log2(double n)
    {
        return (Math.log(n) / Math.log(2));
    }
}


s