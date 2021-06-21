import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.database, this.job})
      : super(key: key);
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => EditJobPage(database: database, job: job),
      fullscreenDialog: true,
    ));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ratePerHourFocusNode = FocusNode();
  bool isLoading = false;
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  void _nameEditingComplete() {
    final form = _formKey.currentState;
    form.save();
    final newFocus = _name.isNotEmpty ? _ratePerHourFocusNode : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      setState(() {
        isLoading = true;
        submitted = true;
      });
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(
            context,
            title: "Name already used",
            content: "Please choose a different job name",
            defaultActionText: "OK",
          );
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(name: _name, ratePerHour: _ratePerHour, id: id);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 2.w,
        title: Text(widget.job == null ? 'New Job' : 'Edit Job'),
        actions: <Widget>[
          FlatButton(
              onPressed: submitted ? null : _submit,
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18.ssp, color: Colors.white),
              ))
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildFormChildren(),
          ),
        ),
        isLoading ? CircularProgressIndicator() : Container(),
      ],
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        focusNode: _nameFocusNode,
        initialValue: _name,
        textInputAction: TextInputAction.next,
        onEditingComplete: _nameEditingComplete,
        decoration: InputDecoration(labelText: 'Jobs name'),
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ],
        onSaved: (value) => _name = value,
        enabled: !isLoading,
      ),
      TextFormField(
        focusNode: _ratePerHourFocusNode,
        initialValue: _ratePerHour?.toString() ?? '',
        decoration: InputDecoration(labelText: 'Rate per hour'),
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        validator: (value) => value.isNotEmpty ? null : 'Rate can\'t be empty',
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter
        ],
        onSaved: (value) => _ratePerHour = int.tryParse(value),
        onEditingComplete: _submit,
        enabled: !isLoading,
      ),
    ];
  }
}
