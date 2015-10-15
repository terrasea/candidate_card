library candidate_card.test;

import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';

import 'package:candidate_card/candidate_card.dart';

main() async {
  await initPolymer();

  group('[candidate-card]', () {
    CandidateCard card;

    group('[name and image passed in as parameters]', () {
      var candidateName = "Bill Murray";
      var imageUrl = 'images/passports.jpg';
      var linkUrl = '#somelink';
      var content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hoeri difoemoe datifi cebo mecyfafa batoe lacahipel mode, jadadimiju, bim quil joceh. Libipid misiremajo, pimeje fymamima, min rivim li cajys vo ducique hil, ropep vasoejom feque. Jimale, fime loefi jicajida sidi vis leve bi cutani, lyl. Be boen dibi fi, neca la dub badet befis quadode mup lo lemedequemi tos.';

      setUp(() {
        card = createElement(
            '<div class="candidate" is="candidate-card" candidate-name="$candidateName" image-url="$imageUrl" link-url="$linkUrl">'
            '$content'
            '</div>'
        );

        document.body.append(card);

        return waitForSync(card);
      });

      tearDown(() {
        card.remove();
        window.location.href = '#';
      });

      test('candidateName is $candidateName', () {
        expect(card.candidateName, candidateName);
      });

      test('candidate name is displayed', () {
        expect(card.querySelector('#name'), isNotNull);
      });

      test('candidate name is $candidateName', () {
        expect(card.querySelector('#name').text.trim(), candidateName);
      });

      test('imageUrl is $imageUrl', () {
        expect(card.imageUrl, imageUrl);
      });

      test('image is displayed', () {
        expect(card.querySelector('#picture'), isNotNull);
      });

      test('image src is $imageUrl', () {
        expect(card.querySelector('#picture').src, endsWith(imageUrl));
      });

      test('content is displayed', () {
        expect(card.querySelector('#snippet'), isNotNull);
      });

      test('content is presemt', () {
        expect(card.querySelector('#snippet').text, content);
      });

      test('linkUrl is $linkUrl', () {
        expect(card.linkUrl, linkUrl);
      });

      test('clicking on button will take us to the $linkUrl URL', () {
        card.querySelector('paper-button').click();
        expect(window.location.href, endsWith(linkUrl));
      });
    });

    group('[name and image in the content of the card]', () {
      var candidateName = "Bill Murray";
      var imageUrl = 'images/passports.jpg';
      var linkUrl = '#somelink';
      var content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hoeri difoemoe datifi cebo mecyfafa batoe lacahipel mode, jadadimiju, bim quil joceh. Libipid misiremajo, pimeje fymamima, min rivim li cajys vo ducique hil, ropep vasoejom feque. Jimale, fime loefi jicajida sidi vis leve bi cutani, lyl. Be boen dibi fi, neca la dub badet befis quadode mup lo lemedequemi tos.';

      setUp(() {
        card = createElement(
            '<div id="card" class="candidate" is="candidate-card" link-url="$linkUrl">'
            '<h1 id="name">$candidateName</h1>'
            '<img id="picture" src="images/passports.jpg">'
            '$content'
            '</div>'
        );

        document.body.append(card);

        //have to run async() twice while waiting for the shifting of elements to be updated
        return waitForSync(card).then((_) => waitForSync(card));
      });

      tearDown(() {
        card.remove();
        window.location.href = '#';
      });

      test('candidateName is $candidateName', () {
        expect(card.candidateName, candidateName);
      });

      test('candidate name is displayed', () {
        expect(card.querySelector('#name'), isNotNull);
      });

      test('candidate name is $candidateName', () {
        expect(card.querySelector('#name').text.trim(), candidateName);
      });

      test('imageUrl is $imageUrl', () {
        expect(card.imageUrl, endsWith(imageUrl));
      });

      test('image is displayed', () {
        expect(card.querySelector('#picture'), isNotNull);
      });

      test('image src is $imageUrl', () {
        expect(card.querySelector('#picture').src, endsWith(imageUrl));
      });

      test('content is displayed', () {
        expect(card.querySelector('#snippet'), isNotNull);
      });

      test('content is presemt', () {
        expect(card.querySelector('#snippet').text, content);
      });

      test('linkUrl is $linkUrl', () {
        expect(card.linkUrl, linkUrl);
      });

      test('clicking on button will take us to the $linkUrl URL', () {
        card.querySelector('paper-button').click();
        expect(window.location.href, endsWith(linkUrl));
      });
    });
  });
}



createElement(String html) =>
  new Element.html(html, treeSanitizer: new NullTreeSanitizer());

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(node) {}
}

Future waitForSync(element) {
  var completer = new Completer();

  element.async(() => completer.complete());

  return completer.future;
}