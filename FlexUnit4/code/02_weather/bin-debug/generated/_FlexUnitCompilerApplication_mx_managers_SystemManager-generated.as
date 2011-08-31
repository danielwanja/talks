package
{

import flash.display.LoaderInfo;
import flash.text.Font;
import flash.text.TextFormat;
import flash.text.engine.TextBlock;
import flash.text.engine.TextLine;
import flash.system.ApplicationDomain;
import flash.system.Security
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flashx.textLayout.compose.ISWFContext;
import mx.core.IFlexModule;
import mx.core.IFlexModuleFactory;
import mx.core.RSLData;
import mx.events.RSLEvent;
import mx.core.FlexVersion;
import mx.managers.SystemManager;
import mx.preloaders.SparkDownloadProgressBar;

public class _FlexUnitCompilerApplication_mx_managers_SystemManager
    extends mx.managers.SystemManager
    implements IFlexModuleFactory, ISWFContext
{
    // Cause the CrossDomainRSLItem class to be linked into this application.
    import mx.core.CrossDomainRSLItem; CrossDomainRSLItem;

    public function _FlexUnitCompilerApplication_mx_managers_SystemManager()
    {

        super();
    }

    override     public function callInContext(fn:Function, thisArg:Object, argArray:Array, returns:Boolean=true):*
    {
        if (returns)
           return fn.apply(thisArg, argArray);
        else
           fn.apply(thisArg, argArray);
    }

    override     public function create(... params):Object
    {
        if (params.length > 0 && !(params[0] is String))
            return super.create.apply(this, params);

        var mainClassName:String = params.length == 0 ? "FlexUnitCompilerApplication" : String(params[0]);
        var mainClass:Class = Class(getDefinitionByName(mainClassName));
        if (!mainClass)
            return null;

        var instance:Object = new mainClass();
        if (instance is IFlexModule)
            (IFlexModule(instance)).moduleFactory = this;
        return instance;
    }

    /**
     *  @private
     */
    private var _info:Object;

    override    public function info():Object
    {
        if (!_info)
        {
            _info = {
            cdRsls: [
[new RSLData("framework_4.5.1.21328.swf",
"",
"0904de41dd852ff09fd7a8c8feeb96f217c93bac34a64bff2df7e44970235e61",
"SHA-256",false,false,"default")],
[new RSLData("textLayout_2.0.0.232.swf",
"",
"8b1fbcdd78f65adf345cc2d0a04d3028cd30a5f8da9c6c4b856f20c623627643",
"SHA-256",false,false,"default")],
[new RSLData("rpc_4.5.1.21328.swf",
"",
"abd7a2f00c363615c44e74706c592a03cf8a94e6c21fe1b78a80bce7cb00ec1b",
"SHA-256",false,false,"default")],
[new RSLData("spark_4.5.1.21328.swf",
"",
"31a6a13443969772ad71ba180a487698f1f7350b0670da1bcc1afc8763bc9314",
"SHA-256",false,false,"default")],
]
,
            compiledLocales: [ "en_US" ],
            compiledResourceBundleNames: [ "collections", "components", "core", "effects", "layout", "logging", "messaging", "rpc", "skins", "styles" ],
            currentDomain: ApplicationDomain.currentDomain,
            mainClassName: "FlexUnitCompilerApplication",
            minHeight: "600",
            minWidth: "955",
            mixins: [ "_FlexUnitCompilerApplication_FlexInit", "_FlexUnitCompilerApplication_Styles", "mx.messaging.config.LoaderConfig" ],
            placeholderRsls: [
[new RSLData("osmf_1.0.0.16316.swf",
"",
"4e0edc22159b81e315c20abb2f11e5b7003050224ee93eaf40430b1c420528d7",
"SHA-256",false,false,"default")],
[new RSLData("charts_4.5.1.21328.swf",
"",
"8085cd79ecb2eb63494f68bfc8095f642d480da5a4ca952b5f921b5fbef3222f",
"SHA-256",false,false,"default")],
[new RSLData("mx_4.5.1.21328.swf",
"",
"06f57c793e4b617dbfd7a1a62b95e846bdab386a81f9d0b0c3db8d7773569a14",
"SHA-256",false,false,"default")],
[new RSLData("advancedgrids_4.5.1.21328.swf",
"",
"6411ed22985d03604612ea94cd44cd6fff1d5de171a079aaca57bfa8a36e2fcf",
"SHA-256",false,false,"default")],
[new RSLData("sparkskins_4.5.1.21328.swf",
"",
"673077fde55d089c00071026b637024e63bf2635fda96947ef4792167cb27639",
"SHA-256",false,false,"default")],
[new RSLData("spark_dmv_4.5.1.21328.swf",
"",
"551c0f9ae7d215bc8b1fa25f1da123256ea2061d8c0fd3ef76a148c72275df43",
"SHA-256",false,false,"default")]]
,
            preloader: mx.preloaders.SparkDownloadProgressBar
            }
        }
        return _info;
    }


    /**
     *  @private
     */
    private var _preloadedRSLs:Dictionary; // key: LoaderInfo, value: Vector.<RSLData>

    /**
     *  @private
     */
    private var _allowDomainParameters:Vector.<Array>;

    /**
     *  @private
     */
    private var _allowInsecureDomainParameters:Vector.<Array>;

    /**
     *  @private
     *  The RSLs loaded by this system manager before the application
     *  starts. RSLs loaded by the application are not included in this list.
     */
    override public function get preloadedRSLs():Dictionary
    {
        if (_preloadedRSLs == null)
           _preloadedRSLs = new Dictionary(true);
        return _preloadedRSLs;
    }

    /**
     *  @private
     *  Calls Security.allowDomain() for the SWF associated with this IFlexModuleFactory
     *  plus all the SWFs assocatiated with RSLs preLoaded by this IFlexModuleFactory.
     *
     */
    override public function allowDomain(... domains):void
    {
        Security.allowDomain.apply(null, domains);

        for (var loaderInfo:Object in _preloadedRSLs)
        {
            if (loaderInfo.content && ("allowDomainInRSL" in loaderInfo.content))
                loaderInfo.content["allowDomainInRSL"].apply(null, domains);
        }

        if (!_allowDomainParameters)
            _allowDomainParameters = new Vector.<Array>();
        _allowDomainParameters.push(domains);

        // Run our handler before the default handlers so the RSL is trusted before the
        // default handlers run.
        addEventListener(RSLEvent.RSL_ADD_PRELOADED, addPreloadedRSLHandler, false, 50);
    }

    /**
     *  @private
     *  Calls Security.allowInsecureDomain() for the SWF associated with this IFlexModuleFactory
     *  plus all the SWFs assocatiated with RSLs preLoaded by this IFlexModuleFactory.
     *
     */
    override public function allowInsecureDomain(... domains):void
    {
        Security.allowInsecureDomain.apply(null, domains);

        for (var loaderInfo:Object in _preloadedRSLs)
        {
            if (loaderInfo.content && ("allowInsecureDomainInRSL" in loaderInfo.content))
                loaderInfo.content["allowInsecureDomainInRSL"].apply(null, domains);
        }
        if (!_allowInsecureDomainParameters)
            _allowInsecureDomainParameters = new Vector.<Array>();
        _allowInsecureDomainParameters.push(domains);

        // Run our handler before the default handlers so the RSL is trusted before the
        // default handlers run.
        addEventListener(RSLEvent.RSL_ADD_PRELOADED, addPreloadedRSLHandler, false, 50);
    }

    /**
     *  @private
     */
    private function addPreloadedRSLHandler(event:RSLEvent):void
    {
        var loaderInfo:LoaderInfo = event.loaderInfo;
        if (!loaderInfo || !loaderInfo.content)
            return;
        var domains:Array
        if (allowDomainsInNewRSLs && _allowDomainParameters)
        {
            for each (domains in _allowDomainParameters)
            {
                if ("allowDomainInRSL" in loaderInfo.content)
                    loaderInfo.content["allowDomainInRSL"].apply(null, domains);
            }
        }

        if (allowInsecureDomainsInNewRSLs && _allowInsecureDomainParameters)
        {
            for each (domains in _allowInsecureDomainParameters)
            {
                if ("allowInsecureDomainInRSL" in loaderInfo.content)
                    loaderInfo.content["allowInsecureDomainInRSL"].apply(null, domains);
            }
        }
    }


}

}
