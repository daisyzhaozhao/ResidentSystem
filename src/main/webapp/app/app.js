Ext.Loader.setConfig({enabled:true, disableCache:true});

Ext.application({
    name:'MyApp',
    appFolder:"app",
    autoCreateViewport:false,

    models:['User'],
    residents:['Users'],
    controllers:['Users'],

    launch:function ()
    {
        this.viewport = Ext.create('MyApp.view.Main', {
            application:this
        });
    }
});


