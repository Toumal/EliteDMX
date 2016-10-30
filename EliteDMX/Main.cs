using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using System.Threading;
using System.Windows.Forms;
using NLua;
using System.Collections;
using System.Collections.Generic;

namespace EliteDMX
{
    public partial class Main : Form
    {
        private static AddedContentReader _continuousFileReader = null;
        public static DMX DmxInterface = null;

        public Main()
        {
            InitializeComponent();
        }

        private void Main_Load(object sender, EventArgs e)
        {
            try
            {
                Thread filethread = new Thread(new ThreadStart(watchLogFiles));
                filethread.IsBackground = true;
                filethread.Start();

                OpenDMX.init();                                            //find and connect to devive (first found if multiple)
                if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)       //update status
                {
                    toolStripStatusLabel1.Text = "No USB Device Found";
                }
                else if (OpenDMX.status == FT_STATUS.FT_OK)
                {
                    toolStripStatusLabel1.Text = "Found DMX on USB";
                    DmxInterface = new OpenDMX();
                    DmxInterface.startWriteThread();
                }
                else
                {
                    toolStripStatusLabel1.Text = "Error Opening Device";
                }
            }
            catch (Exception exp)
            {
                Console.WriteLine(exp);
                toolStripStatusLabel1.Text = "Error Connecting to USB Device";
            }

            if (DmxInterface == null)
            {
                DmxInterface = new VellemanDMX();
                VellemanDMX.SetChannelCount(256);
            }


        }

        private void btnOff_Click(object sender, EventArgs e)
        {
            if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)
                toolStripStatusLabel1.Text = "No Enttec USB Device Found";
            else
                toolStripStatusLabel1.Text = "Found DMX on USB";
            for (int i = 1; i < 255; i++)
            {
                DmxInterface.setDmxValue(i, 0);
            }

        }

        private void btnAllOn_Click(object sender, EventArgs e)
        {
            if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)
                toolStripStatusLabel1.Text = "No Enttec USB Device Found";
            else
                toolStripStatusLabel1.Text = "Found DMX on USB";
            for (int i = 1; i < 255; i++) { 
                DmxInterface.setDmxValue(i, 255);
            }
            for (int i = 1; i < 255; i++)
            {
                DmxInterface.setDmxValue(i, 255);
            }

        }


        private void btnScene1_Click(object sender, EventArgs e)
        {
            if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)
                toolStripStatusLabel1.Text = "No Enttec USB Device Found";
            else
                toolStripStatusLabel1.Text = "Found DMX on USB";
            DmxInterface.setDmxValue(Convert.ToInt16(txtChannel1.Text), Convert.ToByte(txtLevel1.Text));

        }

        private void btnScene2_Click(object sender, EventArgs e)
        {
            if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)
                toolStripStatusLabel1.Text = "No Enttec USB Device Found";
            else
                toolStripStatusLabel1.Text = "Found DMX on USB";
            DmxInterface.setDmxValue(Convert.ToInt16(txtChannel2.Text), Convert.ToByte(txtLevel2.Text));

        }

        private void btnScene3_Click(object sender, EventArgs e)
        {
            if (OpenDMX.status == FT_STATUS.FT_DEVICE_NOT_FOUND)
                toolStripStatusLabel1.Text = "No Enttec USB Device Found";
            else
                toolStripStatusLabel1.Text = "Found DMX on USB";
            DmxInterface.setDmxValue(Convert.ToInt16(txtChannel3.Text), Convert.ToByte(txtLevel3.Text));
        }


        [PermissionSet(SecurityAction.Demand, Name = "FullTrust")]
        public static void watchLogFiles()
        {
            System.Diagnostics.Process.GetCurrentProcess().PriorityClass = System.Diagnostics.ProcessPriorityClass.RealTime;

            // Create a new FileSystemWatcher and set its properties.
            FileSystemWatcher watcher = new FileSystemWatcher();
            string path = Directory.GetParent(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)).FullName;
            if (Environment.OSVersion.Version.Major >= 6)
            {
                path = Directory.GetParent(path).ToString();
            }
            Console.WriteLine("User home: " + path);
            watcher.Path = path + "\\Saved Games\\Frontier Developments\\Elite Dangerous";
            /* Watch for changes in LastAccess and LastWrite times, and
               the renaming of files or directories. */
            watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite
               | NotifyFilters.FileName | NotifyFilters.DirectoryName;
            // Only watch text files.
            watcher.Filter = "*.log";

            // Add event handlers.
            watcher.Created += new FileSystemEventHandler(OnCreated);
            watcher.Changed += new FileSystemEventHandler(OnChanged);

            // Begin watching.
            watcher.EnableRaisingEvents = true;

            Lua scriptState = new Lua();
            scriptState.LoadCLRPackage();
            scriptState.DoString(@" import ('EliteDMX', 'EliteDMX')");
            scriptState.DoString(@"JSON = (loadfile ""json.lua"")()");
            scriptState.DoFile("effects.lua");
            var effectsHandler = scriptState["EffectsHandler"] as LuaFunction;
            var animationHandler = scriptState["AnimationHandler"] as LuaFunction;

            // This will exit automatically if main window closes 
            // due to thread being in the background
            long lastUpdate = 0;
            while (true)
            {
                Thread.Yield();
                long milliseconds = DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond;
                if (milliseconds - lastUpdate > 5)
                {
                    lastUpdate = milliseconds;
                    HandleChangedLines(scriptState, effectsHandler);
                    UpdateAnimations(scriptState, animationHandler);
                }
            }
        }

        // Define the event handlers.
        private static void OnCreated(object source, FileSystemEventArgs e)
        {
            // Specify what is done when a file is changed, created, or deleted.
            Console.WriteLine("File: " + e.FullPath + " " + e.ChangeType);
            _continuousFileReader = new AddedContentReader(e.FullPath);
        }

        // Define the event handlers.
        private static void OnChanged(object source, FileSystemEventArgs e)
        {
            Console.WriteLine("File: " + e.FullPath + " " + e.ChangeType);
            if (_continuousFileReader == null)
            {
                _continuousFileReader = new AddedContentReader(e.FullPath);
            }
        }

        private static void UpdateAnimations(Lua scriptState, LuaFunction animationHandler)
        {
            Animation.HandleAnimations(DmxInterface);

        }

        private static void HandleChangedLines(Lua scriptState, LuaFunction effectsHandler)
        {
            if (_continuousFileReader != null && _continuousFileReader.NewDataReady())
            { 
                // Specify what is done when a file is changed, created, or deleted.
                string newLines = _continuousFileReader.GetAddedLine();
                if (newLines != null && newLines.Length > 0)
                {
                    Console.WriteLine("New data: " + newLines);
                    scriptState["gameEventJson"] = newLines;
                    effectsHandler.Call();
                }
            }


        }

        public class AddedContentReader
        {

            private readonly FileStream _fileStream;
            private readonly StreamReader _reader;

            //Start position is from where to start reading first time. consequent read are managed by the Stream reader
            public AddedContentReader(string fileName, long startPosition = 0)
            {
                //Open the file as FileStream
                _fileStream = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                _reader = new StreamReader(_fileStream);
                //Set the starting position
                _fileStream.Position = startPosition;
            }


            //Get the current offset. You can save this when the application exits and on next reload
            //set startPosition to value returned by this method to start reading from that location
            public long CurrentOffset
            {
                get { return _fileStream.Position; }
            }

            public bool NewDataReady()
            {
                return (_fileStream.Length >= _fileStream.Position);
            }

            //Returns the lines added after this function was last called
            public string GetAddedLine()
            {
                return _reader.ReadLine();
            }
        }
    }

    public class Animation
    {
        private static List<AnimationEntry> animations = new List<AnimationEntry>();
        private const int ANIMATION_TYPE_FIXEDVALUE = 0;
        private const int ANIMATION_TYPE_RAMP_UP = 1;
        private const int ANIMATION_TYPE_RAMP_DOWN = 2;
        private const int ANIMATION_TYPE_RAMP_UPDOWN = 3;
        private const int ANIMATION_TYPE_RANDOMIZE = 4;
        private const int ANIMATION_TYPE_FLASH = 5;
        private const int ANIMATION_TYPE_RANDOMFLASH = 6;

        private class AnimationEntry
        {
            public int effectsequence;
            public int animationDmxChannel;
            public int animationType;
            public int currentValue;
            public int startValue;
            public int endValue;
            public int stepValue;
            public int repeatCount;
            public int delay;
            public AnimationEntry(int effectsequence, int animationDmxChannel, int animationType, int currentValue, int startValue, int endValue, int stepValue, int repeatCount, int delay)
            {
                this.effectsequence = effectsequence;
                this.animationDmxChannel = animationDmxChannel;
                this.animationType = animationType;
                this.currentValue = currentValue;
                this.startValue = startValue;
                this.endValue = endValue;
                this.stepValue = stepValue;
                this.repeatCount = repeatCount;
                this.delay = delay;
            }
        }

        public static void StartAnimation(int effectsequence, int animationDmxChannel, int animationType, int startValue, int endValue, int stepValue, int repeatCount, int delay)
        {
            AnimationEntry a = new AnimationEntry(effectsequence, animationDmxChannel, animationType, startValue, startValue, endValue, stepValue, repeatCount, delay);
            animations.Add(a);
        }

        public static void StopAnimation(int effectsequence)
        {
            animations.RemoveAll(a => a.effectsequence == effectsequence);
        }

        public static void HandleAnimations(DMX DmxInterface)
        {
            foreach (AnimationEntry a in animations)
            {
                if (a.delay == 0 && a.repeatCount != 0)
                {
                    if (a.animationType == ANIMATION_TYPE_FIXEDVALUE)
                    {
                        DmxInterface.setDmxValue(a.animationDmxChannel, Convert.ToByte(a.currentValue));
                        a.repeatCount = 0;
                    }
                    if (a.animationType == ANIMATION_TYPE_RAMP_UP)
                    {
                        a.currentValue = a.currentValue + a.stepValue;
                        if (a.currentValue > a.endValue)
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, Convert.ToByte(a.endValue));
                            if (a.repeatCount > 0)
                            {
                                a.repeatCount = a.repeatCount - 1;

                            }
                            if (a.repeatCount != 0)
                            {
                                a.currentValue = a.startValue;
                            }
                        }
                        else
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, Convert.ToByte(a.currentValue));
                        }
                    }

                    if (a.animationType == ANIMATION_TYPE_RAMP_DOWN)
                    {
                        a.currentValue = a.currentValue - a.stepValue;
                        if (a.currentValue < a.endValue)
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, Convert.ToByte(a.endValue));
                            if (a.repeatCount > 0)
                            {
                                a.repeatCount--;
                            }
                            if (a.repeatCount != 0)
                            {
                                a.currentValue = a.startValue;
                            }
                        }
                        else
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, Convert.ToByte(a.currentValue));
                        }
                    }

                    if (a.animationType == ANIMATION_TYPE_RANDOMFLASH)
                    {
                        a.currentValue = a.currentValue + a.stepValue;
                        if (a.currentValue > a.endValue - (a.stepValue * 2))
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, 255);
                        }
                        if (a.currentValue > a.endValue - a.stepValue)
                        {
                            DmxInterface.setDmxValue(a.animationDmxChannel, 0);
                            if (a.repeatCount > 0)
                            {
                                a.repeatCount = a.repeatCount - 1;
                            }
                            if (a.repeatCount != 0)
                            {
                                a.currentValue = a.startValue;
                            }
                        }
                    }
                }

                if (a.delay > 0)
                {
                    a.delay--;
                }
            }

        }
    }

    public class VellemanDMX : DMX
    {
        [DllImport("k8062d.dll")]
        public static extern void StartDevice();
        [DllImport("k8062d.dll")]
        public static extern void SetData(uint channel, byte data);
        [DllImport("k8062d.dll")]
        public static extern void SetChannelCount(uint count);
        [DllImport("k8062d.dll")]
        public static extern void StopDevice();

        public void setDmxValue(int channel, byte value)
        {
            VellemanDMX.SetData((uint)channel, value);
        }

        public void startWriteThread()
        {
        }
    }


    public interface DMX
    {
        void setDmxValue(int channel, byte value);
        void startWriteThread();
    }

    public class OpenDMX : DMX
    {

        public static byte[] buffer = new byte[513];
        public static uint handle;
        public static bool done = false;
        public static bool Connected = false;
        public static int bytesWritten = 0;
        public static FT_STATUS status;

        public const byte BITS_8 = 8;
        public const byte STOP_BITS_2 = 2;
        public const byte PARITY_NONE = 0;
        public const UInt16 FLOW_NONE = 0;
        public const byte PURGE_RX = 1;
        public const byte PURGE_TX = 2;


        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_Open(UInt32 uiPort, ref uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_Close(uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_Read(uint ftHandle, IntPtr lpBuffer, UInt32 dwBytesToRead, ref UInt32 lpdwBytesReturned);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_Write(uint ftHandle, IntPtr lpBuffer, UInt32 dwBytesToRead, ref UInt32 lpdwBytesWritten);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_SetDataCharacteristics(uint ftHandle, byte uWordLength, byte uStopBits, byte uParity);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_SetFlowControl(uint ftHandle, char usFlowControl, byte uXon, byte uXoff);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_GetModemStatus(uint ftHandle, ref UInt32 lpdwModemStatus);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_Purge(uint ftHandle, UInt32 dwMask);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_ClrRts(uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_SetBreakOn(uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_SetBreakOff(uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_GetStatus(uint ftHandle, ref UInt32 lpdwAmountInRxQueue, ref UInt32 lpdwAmountInTxQueue, ref UInt32 lpdwEventStatus);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_ResetDevice(uint ftHandle);
        [DllImport("FTD2XX.dll")]
        public static extern FT_STATUS FT_SetDivisor(uint ftHandle, char usDivisor);


        public static void init()
        {
            handle = 0;
            status = FT_Open(0, ref handle);
            //setting up the WriteData method to be on it's own thread. This will also turn all channels off
            //this unrequested change of state can be managed by getting the current state of all channels 
            //into the write buffer before calling this function.
            initOpenDMX();
        }

        public void startWriteThread()
        {
            Thread thread = new Thread(new ThreadStart(writeData));
            thread.IsBackground = true;
            thread.Start();
        }



        public void setDmxValue(int channel, byte value)
        {
            if (buffer == null)
            {
                buffer = new byte[513];
            }
            buffer[channel] = value;
        }

        public void writeData()
        {
            while (!done)
            {
                try
                {
                    if (OpenDMX.status == FT_STATUS.FT_OK && buffer != null)
                    {
                        status = FT_SetBreakOn(handle);
                        status = FT_SetBreakOff(handle);
                        bytesWritten = write(handle, buffer, buffer.Length);
                        Thread.Sleep(25); ;      //give the system time to send the data before sending more 
                    }
                    Thread.Yield();
                }
                catch (Exception exp)
                {
                    Console.WriteLine(exp);
                }
            }
        }

        public static int write(uint handle, byte[] data, int length)
        {
            try
            {
                IntPtr ptr = Marshal.AllocHGlobal((int)length);
                Marshal.Copy(data, 0, ptr, (int)length);
                uint bytesWritten = 0;
                status = FT_Write(handle, ptr, (uint)length, ref bytesWritten);
                return (int)bytesWritten;
            }
            catch (Exception exp)
            {
                Console.WriteLine(exp);
                return 0;
            }
        }

        public static void initOpenDMX()
        {
            status = FT_ResetDevice(handle);
            status = FT_SetDivisor(handle, (char)12);  // set baud rate
            status = FT_SetDataCharacteristics(handle, BITS_8, STOP_BITS_2, PARITY_NONE);
            status = FT_SetFlowControl(handle, (char)FLOW_NONE, 0, 0);
            status = FT_ClrRts(handle);
            status = FT_Purge(handle, PURGE_TX);
            status = FT_Purge(handle, PURGE_RX);
        }

    }



    /// <summary>
    /// Enumaration containing the varios return status for the DLL functions.
    /// </summary>
    public enum FT_STATUS
    {
        FT_OK = 0,
        FT_INVALID_HANDLE,
        FT_DEVICE_NOT_FOUND,
        FT_DEVICE_NOT_OPENED,
        FT_IO_ERROR,
        FT_INSUFFICIENT_RESOURCES,
        FT_INVALID_PARAMETER,
        FT_INVALID_BAUD_RATE,
        FT_DEVICE_NOT_OPENED_FOR_ERASE,
        FT_DEVICE_NOT_OPENED_FOR_WRITE,
        FT_FAILED_TO_WRITE_DEVICE,
        FT_EEPROM_READ_FAILED,
        FT_EEPROM_WRITE_FAILED,
        FT_EEPROM_ERASE_FAILED,
        FT_EEPROM_NOT_PRESENT,
        FT_EEPROM_NOT_PROGRAMMED,
        FT_INVALID_ARGS,
        FT_OTHER_ERROR
    };


}
