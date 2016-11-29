//=require_tree ./fileinput_locales 
//<input className="file-loading"/>

/*   <div className="file-preview-frame" data-template = "image">
 <div className="kv-file-content">
 <img className="kv-preview-data file-preview-image" src =''  title =''  style="width:auto;height:160px;" />
 </div>
 <div className="file-thumbnail-footer">
 <div className="file-footer-caption" title = ''>
 Фото нейм
 <bp />
 <samp>размер кб</samp>
 </div>
 </div>
 </div>*/

//Форма картинки
//Входной параметр file. Картинка
class Picture extends React.Component{
    constructor(props) {
        super(props);
        this.state = {
                        photo: this.props.file,
                        patch: null,
                        flag:false
        };
        this.handleImageloaded = this.handleImageloaded.bind(this)

    }

    handleImageloaded(e){
        this.setState({patch: e.target.result,
                        flag:true});
    }

    render() {
        const imgStype ={
            width:'auto',
            height:'160px'
        };
        var image = new FileReader;
        var patch;
        if (!this.state.flag) {
            image.onload = this.handleImageloaded;
            image.readAsDataURL(this.state.photo);
        }
        return (
            <div className="file-preview-frame" data-template="image">
                <div className="kv-file-content">
                    <img className="kv-preview-data file-preview-image" src ={this.state.patch}  title ={this.state.photo.name}  style={imgStype}></img>
                </div>
                <div className="file-thumbnail-footer">
                    <div className="file-footer-caption" title={this.state.photo.name}>
                        {this.state.photo.name}
                        <br />
                        <samp>{Math.round(this.state.photo.size/1024*100)/100} кб</samp>
                    </div>
                </div>
            </div>

        );
    }
};




//Входные параметры id={id} className={nameClass} name={name} multiple={multiple}
class Fileinput extends React.Component{
    constructor(props) {
        super(props);
        this.state = {files: ''};
        this.handleChange = this.handleChange.bind(this);
        this.handleDeleteAll = this.handleDeleteAll.bind(this);

    }

    handleChange(event) {
        var inputfiles = document.querySelector('#' + this.props.id).files;
        var files = [];
        for (var i=0; i<inputfiles.length; i++){
            if (!inputfiles[i].type.match('image.*')) {
                continue;
            }
            files[files.length] = inputfiles[i]
        }
        this.setState({files:files})
    }

    handleDeleteAll(){
        document.querySelector('#' + this.props.id).value ='';
        this.setState({files:''});
    }

    render() {
        var photos;
        var files = this.state.files;
        if (files !='' ) {
            photos = files.map(function (file) {
               return <Picture file={file} />
            });
        }
        var clear = function(files) {
            if (files !='' ) {
                return (
                    <button className="btn btn-default fileinput-remove fileinput-remove-button"
                            onClick={this.handleDeleteAll} type="button" tabIndex={500}
                            title="Очистить выбранные файлы">
                        <i className="glyphicon glyphicon-tras"/>
                        <span className="hidden-xs">Очистить</span>
                    </button>);
            } 
        };
        return (
            <div className="file-input">{/*file-input-new*/}
                {/*<div className="file-preview"></div>*/}
                {/*Компонент выбора фото
                Если фото выбрано, то появляется новая кнопка "Очистить"*/}
                {photos}
                <div className="input-group file-caption-main">
                    <div className="form-control file-caption  kv-fileinput-caption" tabIndex={500}>
                        <div className="file-caption-name"></div>
                    </div>
                    <div className="input-group-btn">
                        {clear(files)}
                        <div className="btn btn-primary btn-file" >
                            <i className="glyphicon glyphicon-folder-open"></i>
                            <span className="hidden-xs"> Выбрать...</span>
                            <input onChange={this.handleChange} id={this.props.id} className={this.props.nameClass} name={this.props.name}  type="file" multiple = {this.props.multiple} accept="image/*,image/jpeg" />
                        </div>
                    </div>
                </div>
            </div>
        );
    }
};
