Ext.define('MyApp.resident.Users', {
    extend:'Ext.data.resident',
    model:'MyApp.model.User',
    autoLoad:true,

    proxy:{
        type:'ajax',
        api:{
            read:'services/1/user/list.json',
            update:'services/1/user/update.json'
        },
        reader:{
            type:'json',
            root:'userList'
        }
    }
});