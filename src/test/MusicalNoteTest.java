import org.junit.Before;

public class MusicalNoteTest {
    private MusicalNote tester;

    @Before

    @org.junit.Test
    public void testFrequencyToNote() throws Exception
    {
        // MyClass is tested
        MusicalNote tester = new MusicalNote();

        // Tests
        assertEquals("443Hz equivale a la nota 57 de MIDI", 57, tester.frequencyToNote(443));
        assertEquals("La nota 57 de MIDI equivale a un La (A) en la octava 4 (osea, A4)", "A 4", tester.noteToName(57));
        assertEquals("La nota 57 de MIDI equivale a un La (A) en la octava 4 (osea, A4)", "C 1", tester.noteToName(12));
    }
}