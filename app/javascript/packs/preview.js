window.addEventListener('load', () => {
    const uploader = document.querySelector('.form-article-img');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const image = reader.result;
        document.querySelector('.img_prev').setAttribute('src', image);
      }
    });
});

window.addEventListener('load', () => {
    const uploader = document.querySelector('.form-user-img');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const image = reader.result;
        document.querySelector('.modal-user-img').setAttribute('src', image);
      }
    });
});