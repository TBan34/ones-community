if (document.URL.match(/new/|/edit/)){
  document.addEventListener('turbolinks:load', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('preview-img');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'PreviewImg')
      blobImage.setAttribute('src', blob);
      
      imageElement.appendChild(blobImage);
    };
    
    const postImage = document.getElementById('post_image');
    if (postImage) {
      postImage.addEventListener('change', (e) => {
        const imageContent = document.getElementById('preview-img').querySelector('img'); 
        if (imageContent){ 
          imageContent.remove();
        }
        
        const file = e.target.files[0];  
        const blob = window.URL.createObjectURL(file); 
        createImageHTML(blob); 
      });
    }
  });
}