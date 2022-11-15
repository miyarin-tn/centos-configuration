<template>
  <footer class="footer">
    <div class="footer-box">
      <span class="copyright">{{$t('COPYRIGHT')}} © 2022</span>
      <span class="author">{{$t('CREATED_BY', { name: 'Yuudachi' })}}</span>
    </div>
  </footer>
</template>

<style lang="scss" scoped>
.footer {
  position: relative;
  background-color: var(--vs-theme-bg);
  margin-top: -50px;
  padding: 15px;
  margin-left: 255px;
  @media (max-width: 992px) {
    margin-left: 0;
  }
  .footer-box {
    display: flex;
    justify-content: space-between;
  }
  .copyright,
  .author {
    opacity: 0.5;
    font-size: 0.8rem;
  }
}
</style>
