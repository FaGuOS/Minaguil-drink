/* global bootstrap */

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// app/javascript/packs/application.js

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function() {
  initializeBootstrapComponents();
  initializeTagFunctionality();
  initializeImagePreviewFunctionality();
  initializeQuestionTagButton();
});

function initializeBootstrapComponents() {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl)
  })

  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  popoverTriggerList.forEach(function (popoverTriggerEl) {
    new bootstrap.Popover(popoverTriggerEl)
  })
}

function initializeTagFunctionality() {
  const tagInput = document.getElementById('tag-input');
  const addTagButton = document.getElementById('add-tag-button');
  const tagsContainer = document.getElementById('tags-container');
  const tagListHiddenInput = document.getElementById('tag-list-hidden');
  let tags = tagListHiddenInput.value ? tagListHiddenInput.value.split(',') : [];

  if (!tagInput || !addTagButton || !tagsContainer || !tagListHiddenInput) {
    return;
  }

  displayTags();

  addTagButton.addEventListener('click', function() {
    const tagValue = tagInput.value.trim();
    if (tagValue !== '' && !tags.includes(tagValue)) {
      tags.push(tagValue);
      displayTags();
      updateHiddenTagList();
    }
  });

  function displayTags() {
    tagsContainer.innerHTML = '';
    tags.forEach(tag => {
      const tagElement = document.createElement('div');
      tagElement.className = 'badge bg-secondary me-2 mb-2';
      const button = document.createElement('button');
      button.className = 'btn-close ms-2';
      button.type = 'button';
      button.setAttribute('aria-label', 'Close');
      button.onclick = function() {
        removeTag(tag);
      };
      tagElement.textContent = tag;
      tagElement.appendChild(button);
      tagsContainer.appendChild(tagElement);
    });
    tagInput.value = '';
  }

  function updateHiddenTagList() {
    tagListHiddenInput.value = tags.join(',');
  }

  function removeTag(tag) {
    tags = tags.filter(t => t !== tag);
    displayTags();
    updateHiddenTagList();
  }
}

function initializeImagePreviewFunctionality() {
  const fileInput = document.getElementById('post_image');
  const imagePreview = document.getElementById('image_preview');

  if (!fileInput || !imagePreview) {
    return;
  }

  fileInput.addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
      imagePreview.src = reader.result;
    };
    reader.onerror = function() {
      alert('Failed to read file!');
    };
    if (event.target.files.length > 0) {
      reader.readAsDataURL(event.target.files[0]);
    }
  });
}

function initializeQuestionTagButton() {
  const questionTagButton = document.getElementById('question-tag-button');
  const tagInput = document.getElementById('tag-input');
  const addTagButton = document.getElementById('add-tag-button');

  if (!questionTagButton || !tagInput || !addTagButton) {
    return;
  }

  questionTagButton.addEventListener('click', function() {
    tagInput.value = '質問';
    addTagButton.click();
  });
}

document.addEventListener("DOMContentLoaded", function() {
  const circleButton = document.querySelector(".circle-button");
  const triangleButton = document.querySelector(".triangle-button");

  circleButton.addEventListener("mouseover", function() {
    circleButton.style.backgroundColor = "blue";
  });

  circleButton.addEventListener("mouseout", function() {
    circleButton.style.backgroundColor = "grey";
  });

  triangleButton.addEventListener("mouseover", function() {
    triangleButton.style.borderTopColor = "blue";
  });

  triangleButton.addEventListener("mouseout", function() {
    triangleButton.style.borderTopColor = "grey";
  });
});