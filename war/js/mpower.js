$(document).ready(function()
   {
	
	/* This code block is your window.onload.  Please don't set window.onload directly. */
	
	rowCloner("#report_advanced_filters tr:last");
	rowCloner("#report_groupbyfields tr:last");
	rowCloner("#report_matrixrows tr:last");
	rowCloner("#report_matrixColumns tr:last");
	
	$("#report_filters td .deleteButton").click(function(){
		deleteRow($(this).parent().parent());
	});
	
	updateList(document.getElementById("move"), document.getElementById("newList"));
	
   }
);

function rowCloner(selector) {
	$(selector).one("change",function(event){
		if(event.keyCode != 9) { // ignore tab
			addNewRow(selector);
		}
		rowCloner(selector);
	});
}

function callServer(name) {
    Hello.greet(name, callback);
}
function callback(data) {
    alert("AJAX Response:" + data);
}
function addNewRow(selector) {
	$(selector).find(".deleteButton").click(function(){
			deleteRow($(this).parent().parent());
		}).show();
	var newRow = $(selector).clone(true);
	newRow.find(".deleteButton").hide();
	var i = newRow.attr("rowindex");
	var j = parseInt(i) + 1;
	newRow.attr("rowindex",j);
	var findExp = new RegExp("\\["+i+"\\]","gi");

	newRow.find("input").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		field.attr('name',nameString);
		field.val("");	
		var idString = field.attr('id').replace(findExp, "["+j+"]");
		field.attr('id',idString);		
	});
	
	newRow.find(":checkbox").each(function(){
		$(this).val("true");
	});

	newRow.find("select").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		field.attr('name',nameString);
		var idString = field.attr('id').replace(findExp, "["+j+"]");
		field.attr('id',idString);				
	});

	newRow.removeClass("focused highlight");
	$(selector).parent().append(newRow);
}

function deleteRow(row) {
	if($(".tablesorter tbody tr").length > 1) {
		row.fadeOut("slow",function(){$(this).remove();})
	} else {
		alert("Sorry, you cannot delete that row since it's the only remaining row.")
	};
}

function moveUp(element) {
	for(index = 0; index < element.options.length; index++) {
		if(element.options[index].selected == true) {
			if(index != 0) {
				var temp = new Option(element.options[index - 1].text, element.options[index - 1].value);
				var temp2 = new Option(element.options[index].text, element.options[index].value);
				temp.id = element.options[index - 1].id;
				temp2.id = element.options[index].id;
				element.options[index] = temp;
				element.options[index - 1] = temp2;
				element.options[index - 1].selected = true;
			}
	    	break;
		}
	}
}

function moveDown(element) {
	for(index = (element.options.length - 1); index >= 0; index--) {
		if(element.options[index].selected == true) {
			if(index != (element.options.length - 1)) {
				var temp = new Option(element.options[index + 1].text, element.options[index + 1].value);
				var temp2 = new Option(element.options[index].text, element.options[index].value);
				temp.id = element.options[index + 1].id;
				temp2.id = element.options[index].id;				
				element.options[index] = temp;
				element.options[index+1] = temp2;
				element.options[index+1].selected = true;
			}
	    	break;
		}
	}
}

function moveTop(element) {
	for(index = 0; index < element.options.length; index++) {
	    if(element.options[index].selected == true) {
	    	if(index != 0) {
	    		while(index > 0) {
	    			moveUp(element);
	    			index--;
	    		}
	    	}
	    	break;
	    }
	 }
}

function moveBottom(element) {
	for(index = (element.options.length - 1); index >= 0; index--) {
		if(element.options[index].selected == true) {
			if(index != (element.options.length - 1)) {
				while(index < element.options.length - 1) {
					moveDown(element);
				}
			}
	    	break;
	    }
	}
}

function updateList(list, textBox) {
	if (textBox != null && list != null) {
		textBox.value = '';
		for(i = 0; i < list.options.length; i++) {
			if (i == 0) {
				textBox.value += list.options[i].id;
			} else {
				textBox.value += ',' + list.options[i].id;
			}	
		}
	}
}

function checkBoxValidate(cb) {
	for (j = 0; j < 4; j++) {
		if (eval("document.myform.ckbox[" + j + "].checked") == true) {
			document.myform.ckbox[j].checked = false;
			if (j == cb) {
				document.myform.ckbox[j].checked = true;
			}
		}
	}
}

function SingleSelect(regex,current) {
	checked = current.checked;
	re = new RegExp(regex);
	for(i = 0; i < document.forms[0].elements.length; i++) {
		elm = document.forms[0].elements[i];
		if (elm.type == 'checkbox') {
			if (re.test(elm.name)) {
				elm.checked = false;
			}
		}
	}
	if (checked)
		current.checked = true;
}

function toggleValueTextBoxEnabled() {
	
}

