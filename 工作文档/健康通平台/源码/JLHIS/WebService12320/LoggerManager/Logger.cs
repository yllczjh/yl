namespace HttpToken.Log
{
    public class Logger
    {
        NLog.Logger _logger;

        private Logger(NLog.Logger logger)
        {
            _logger = logger;
        }

        public static Logger Default { get; private set; }
        static Logger()
        {
            Default = new Logger(NLog.LogManager.GetCurrentClassLogger());
        }

        #region Debug
        public void Debug(string msg, params object[] args)
        {
            _logger.Debug(msg, args);
        }

        #endregion

        #region Info
        public void Info(string msg, params object[] args)
        {
            _logger.Info(msg, args);
        }

        #endregion

        #region Warn
        public void Warn(string msg, params object[] args)
        {
            _logger.Warn(msg, args);
        }


        #endregion

        #region Trace
        public void Trace(string msg, params object[] args)
        {
            _logger.Trace(msg, args);
        }

        #endregion

        #region Error
        public void Error(string msg, params object[] args)
        {
            _logger.Error(msg, args);
        }


        #endregion

        #region Fatal
        public void Fatal(string msg, params object[] args)
        {
            _logger.Fatal(msg, args);
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
