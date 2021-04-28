using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace HealthCardWebManager.Log
{
    public class LogBroker
    {
        NLog.Logger _logBroker;

        private LogBroker(NLog.Logger logger)
        {
            _logBroker = logger;
        }

        public static LogBroker Default { get; private set; }
        static LogBroker()
        {
            Default = new LogBroker(NLog.LogManager.GetCurrentClassLogger());
        }

        #region Debug
        public void Debug(string msg, params object[] args)
        {
            _logBroker.Debug(msg, args);
        }

        #endregion

        #region Info
        public void Info(string msg, params object[] args)
        {
            _logBroker.Info(msg, args);
        }

        #endregion

        #region Warn
        public void Warn(string msg, params object[] args)
        {
            _logBroker.Warn(msg, args);
        }


        #endregion

        #region Trace
        public void Trace(string msg, params object[] args)
        {
            _logBroker.Trace(msg, args);
        }

        #endregion

        #region Error
        public void Error(string msg, params object[] args)
        {
            _logBroker.Error(msg, args);
        }


        #endregion

        #region Fatal
        public void Fatal(string msg, params object[] args)
        {
            _logBroker.Fatal(msg, args);
        }


        #endregion

        #region Custom


        #endregion

        /// <summary>
        /// Flush any pending log messages (in case of asynchronous targets).
        /// </summary>
        /// <param name="timeoutMilliseconds">Maximum time to allow for the flush. Any messages after that time will be discarded.</param>
        public void Flush(int? timeoutMilliseconds = null)
        {
            if (timeoutMilliseconds != null)
                NLog.LogManager.Flush(timeoutMilliseconds.Value);

            NLog.LogManager.Flush();
        }
    }

}
