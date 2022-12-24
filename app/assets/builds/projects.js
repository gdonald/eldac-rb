(() => {
  // app/javascript/projects.js
  window.askDeleteSurvey = function(id) {
    const project_id = $("#form_project_id").val();
    const url = "/projects/" + project_id + "/surveys/" + id + "/ask_delete";
    $.ajax({
      method: "get",
      url
    });
  };
  window.askDeleteForm = function(id) {
    const project_id = $("#form_project_id").val();
    const url = "/projects/" + project_id + "/forms/" + id + "/ask_delete";
    $.ajax({
      method: "get",
      url
    });
  };
  window.askDeleteFolder = function(id) {
    $.ajax({
      method: "get",
      url: "/folders/" + id + "/ask_delete"
    });
  };
  window.editFolder = function(id) {
    $.ajax({
      method: "get",
      url: "/folders/" + id + "/edit"
    });
  };
  window.toggleFolderCollapse = function(id) {
    const visible = $("span#fc-" + id).is(":visible");
    if (visible) {
      $("tr#header-" + id).show();
      $("span#fc-" + id).hide();
      $("span#fo-" + id).show();
    } else {
      $("tr#header-" + id).hide();
      $("span#fc-" + id).show();
      $("span#fo-" + id).hide();
    }
    $("tr[id^=f" + id + "]").each(function(k, v) {
      if (visible) {
        $(v).show();
      } else {
        $(v).hide();
      }
    });
    $.ajax({
      method: "post",
      url: "/folders/toggle_collapse",
      data: {
        id
      },
      success(result) {
      }
    });
  };
  window.rebindControls = function() {
    $('input:checkbox[id^="checkall"]').prop("checked", projectsAllChecked());
    $('input:checkbox[id^="p_"]').each(function() {
      $($(this)).click(function() {
        toggleProjectFolder($(this).attr("id").split("_")[1]);
      });
    });
    $('input:checkbox[id^="checkall"]').click(function() {
      checkAllProjects();
    });
    $('input:checkbox[id^="assigned"]').click(function() {
      setAssigned();
    });
  };
  window.setAssigned = function() {
    const assigned = $('input:checkbox[id^="assigned"]').prop("checked");
    $.ajax({
      method: "post",
      url: "/projects/assigned_folder",
      data: {
        assigned: assigned ? "1" : "0"
      },
      success(result) {
        $("#projects_list").html(result);
        rebindControls();
      }
    });
  };
  window.checkAllProjects = function() {
    const folder_id = $("select#folder_id").val();
    if (folder_id === 0) {
      return;
    }
    const checkall = $('input:checkbox[id^="checkall"]').prop("checked");
    let id = void 0;
    const project_ids = [];
    $('input:checkbox[id^="p_"]').each(function() {
      id = $(this).attr("id").split("_")[1];
      project_ids.push(id);
      $(this).prop("checked", checkall);
      $("div#s_" + id).show();
      $("div#s_" + id).fadeOut(1e3);
    });
    if (project_ids.length === 0) {
      return;
    }
    $.ajax({
      method: "post",
      url: "/projects/checkall_folder",
      data: {
        folder_id,
        project_ids,
        checkall: checkall ? "1" : "0"
      },
      success(result) {
      }
    });
  };
  window.toggleProjectFolder = function(project_id) {
    const folder_id = parseInt($("select#folder_id").val());
    if (folder_id === 0) {
      return;
    }
    $("div#s_" + project_id).show();
    $("div#s_" + project_id).fadeOut(1e3);
    $.ajax({
      method: "post",
      url: "/projects/toggle_folder",
      data: {
        folder_id,
        project_ids: [project_id]
      },
      success(result) {
        $('input:checkbox[id^="checkall"]').prop("checked", projectsAllChecked());
      }
    });
  };
  window.getProjects = function() {
    const folder_id = parseInt($("select#folder_id").val());
    $("#projects_list").html("");
    $.ajax({
      method: "post",
      url: "/folders/organize",
      data: {
        folder_id
      },
      success(result) {
        $("#projects_list").html(result);
        rebindControls();
      }
    });
  };
  window.projectsAllChecked = function() {
    const cbs = $('input:checkbox[id^="p_"]');
    if (cbs.length === 0) {
      return false;
    }
    let r = true;
    $('input:checkbox[id^="p_"]').each(function() {
      if (!$(this).prop("checked")) {
        r = false;
      }
    });
    return r;
  };
  window.saveFoldersSort = function() {
    const order = $("#sort_folders tbody").sortable("serialize");
    $.ajax({
      method: "post",
      url: "/folders/save_sort",
      data: {
        order
      },
      success(result) {
      }
    });
  };
  window.saveFormsSort = function(project_id) {
    const order = $("#sort_forms tbody").sortable("serialize");
    $.ajax({
      method: "post",
      url: "/projects/" + project_id + "/forms/save_sort",
      data: {
        order
      },
      success(result) {
      }
    });
  };
  $(function() {
    $("a#tab_project").click(function() {
      $("div#forms").addClass("hidden");
      $("div#surveys").addClass("hidden");
      $("div#project").removeClass("hidden");
      $("li#li_forms").removeClass("active");
      $("li#li_surveys").removeClass("active");
      return $("li#li_project").addClass("active");
    });
    $("a#tab_forms").click(function() {
      $("div#surveys").addClass("hidden");
      $("div#project").addClass("hidden");
      $("div#forms").removeClass("hidden");
      $("li#li_forms").addClass("active");
      $("li#li_surveys").removeClass("active");
      return $("li#li_project").removeClass("active");
    });
    $("a#tab_surveys").click(function() {
      $("div#forms").addClass("hidden");
      $("div#project").addClass("hidden");
      $("div#surveys").removeClass("hidden");
      $("li#li_forms").removeClass("active");
      $("li#li_surveys").addClass("active");
      return $("li#li_project").removeClass("active");
    });
    $("a#tab_project").click();
    $("#sort_folders tbody").sortable({
      cursor: "move",
      opacity: 0.7,
      update(e, ui) {
        saveFoldersSort();
      }
    });
    $("#sort_forms tbody").sortable({
      cursor: "move",
      opacity: 0.7,
      update(e, ui) {
        saveFormsSort($("#form_project_id").val());
      }
    });
    $('input:checkbox[id^="assigned"]').click(function() {
      getProjects();
    });
    $("select#folder_id").change(function() {
      getProjects();
    });
    $('a[id^="ad_folder_"]').each(function() {
      return $($(this)).click(function() {
        askDeleteFolder($(this).attr("id").split("_")[2]);
      });
    });
    $('a[id^="folder_"]').each(function() {
      return $($(this)).click(function() {
        editFolder($(this).attr("id").split("_")[1]);
      });
    });
    $('a[id^="ad_form_"]').each(function() {
      return $($(this)).click(function() {
        askDeleteForm($(this).attr("id").split("_")[2]);
      });
    });
    $('a[id^="ad_survey_"]').each(function() {
      return $($(this)).click(function() {
        askDeleteSurvey($(this).attr("id").split("_")[2]);
      });
    });
  });
})();
//# sourceMappingURL=assets/projects.js.map
