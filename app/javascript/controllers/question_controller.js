// jQuery(($) => {
//   // grab elememts
//   let $wrapper = $('.row');
//   let $list = $wrapper.find('.question-card')

//   let $clonedList = $list.clone()
//   let cardLength = 0

//   // set an offset of 4 pixels
//   let listHeight = 4

//   // add the height of all cards
//   $list.find('.user-card').each((_, el) => {
//     cardLength++

//     listHeight += ['height', 'margin-top', 'margin-bottom']
//       .map((key) =>
//         parseInt(window.getComputedStyle(el).getPropertyValue(key), 10)
//       )
//       .reduce((prev, cur) => prev + cur)
//   })

//   // attach the calculation of the height as a style
//   $list.add($clonedList).css({
//     height: listHeight + 'px'
//   })




//   // $clonedList.css({
//   //   // 'position': 'absolute',
//   //   // 'left' : '0',
//   //   // 'top': '350px'
//   //   'background': 'red'
//   // })




//   $clonedList.addClass('cloned').appendTo('.row')


//   // execute animations
//   let infinite = new TimelineMax({ repeat: -1, paused: true })
//   let time = cardLength * 3

//   let el = document.getElementsByClassName("question-card")[0];
//   let targets = [...document.getElementsByClassName("user-card")];

//   let callback = (entries, observer) => {
//     entries.forEach(entry => {
//       if (entry.isIntersecting) {
//         const tl = gsap.to(entry.target, { scale: 1.1 })
//       }
//       else {
//         const tl = gsap.to(entry.target, { scale: 1 })
//       }
//     });
//   };


//   let io = new IntersectionObserver(callback, {
//     root: el,
//     threshold: .5
//   });


//   targets.forEach(target => io.observe(target))
//   infinite
//     .fromTo(
//       $list,
//       time,
//       { y: 0 },
//       { y: '-' + listHeight, ease: Linear.easeNone },
//       0
//     )
//     .fromTo(
//       $clonedList,
//       time,
//       { y: listHeight },
//       { y: 0, ease: Linear.easeNone },
//       0
//     ).play()

//   $wrapper
//     .on('mouseenter', () => infinite.pause())
//     .on('mouseleave', () => infinite.play())
// })

let card = new Card('question-card');
card.run();


function Card(classCard) {
  this.cards = document.querySelectorAll('.' + classCard);
  this.bindEventsCard = function () {
    for (let i = 0, length = this.cards.length; i < length; i++) {
      this.cards[i].addEventListener('mousemove', this.startRotate);
      this.cards[i].addEventListener('mouseout', this.stopRotate);
    }
  }
  this.startRotate = function (event) {
    let cardItem = this.querySelector('.user-card'),
      halfHeight = cardItem.offsetHeight / 2,
      halfWidth = cardItem.offsetWidth / 2;
    cardItem.style.transform = 'rotatex(' + -(event.offsetY - halfHeight) / 38 + 'deg) rotateY(' + (event.offsetX - halfWidth) / 38 + 'deg)';
  }
  this.stopRotate = function (event) {
    let cardItem = this.querySelector('.user-card');
    cardItem.style.transform = 'rotate(0)';
  }
  this.run = () => {
    this.bindEventsCard();
  }
}
