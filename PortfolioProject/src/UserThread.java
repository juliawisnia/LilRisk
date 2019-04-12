
import org.python.util.PythonInterpreter;

public class UserThread extends Thread{

	void run() {
		PythonInterpreter interp = new PythonInterpreter();
	    interp.execfile("DataAcquisition.py");
	    
	}
}
